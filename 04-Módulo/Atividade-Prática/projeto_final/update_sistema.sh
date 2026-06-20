#!/bin/bash
set -euo pipefail
# =============================================================
# update_sistema.sh (S04T02V08)
# GridStart Pro - Second Gear
#
# Le configuracoes de um arquivo externo (.conf) via "source" e
# atualiza os pacotes do sistema (apt-get) de forma autonoma,
# registrando tudo em log com a funcao log() ja conhecida da V07.
#
# Convencao de exit codes deste script:
#   0 = sucesso
#   2 = arquivo de configuracao nao encontrado
#   3 = nao esta rodando como root (necessario para apt-get)
#   4 = apt-get update falhou
#   5 = apt-get upgrade falhou
# =============================================================

# --- 1. Localiza e carrega o arquivo de configuracao ---
CONFIG_FILE="./update_sistema.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERRO: arquivo de configuracao nao encontrado: $CONFIG_FILE"
    exit 2
fi

# shellcheck source=/dev/null
source "$CONFIG_FILE"

# --- 2. Funcao log() - identica ao padrao da V07 ---
log() {
    local nivel="$1"
    local mensagem="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$nivel] $mensagem" >> "$LOG_FILE"
}

# --- 3. trap de saida - identico ao padrao da V07 ---
ao_sair() {
    local codigo=$?
    if [[ "$codigo" -eq 0 ]]; then
        log "INFO" "update_sistema.sh finalizado com sucesso (codigo $codigo)"
    else
        log "ERROR" "update_sistema.sh finalizado com erro (codigo $codigo)"
    fi
}

trap ao_sair EXIT

# --- 4. Checagem de privilegios (precisa ser root para apt-get) ---
verificar_root() {
    if [[ "$EUID" -ne 0 ]]; then
        log "ERROR" "Script executado sem privilegios de root (EUID=$EUID)"
        echo "ERRO: este script precisa rodar como root. Use: sudo ./update_sistema.sh"
        exit 3
    fi
}

# --- 5. Atualiza a lista de pacotes (apt-get update) ---
atualizar_lista_pacotes() {
    log "INFO" "Iniciando apt-get update"

    if ! apt-get update > /tmp/apt_update_output.log 2>&1; then
        log "ERROR" "apt-get update falhou - ver /tmp/apt_update_output.log"
        exit 4
    fi

    log "INFO" "apt-get update concluido com sucesso"
}

# --- 6. Conta quantos pacotes podem ser atualizados ---
contar_pacotes_disponiveis() {
    local total
    total=$(apt-get -s upgrade 2>/dev/null | grep -c '^Inst ' || true)
    echo "$total"
}

# --- 7. Aplica (ou simula) a atualizacao dos pacotes ---
atualizar_pacotes() {
    local total_pacotes="$1"

    if [[ "$total_pacotes" -eq 0 ]]; then
        log "INFO" "Nenhum pacote pendente de atualizacao"
        echo "Sistema ja esta atualizado. Nada a fazer."
        return 0
    fi

    if [[ "$total_pacotes" -gt "$LIMITE_PACOTES_ALERTA" ]]; then
        log "WARNING" "$total_pacotes pacotes pendentes - acima do limite de $LIMITE_PACOTES_ALERTA configurado"
    else
        log "INFO" "$total_pacotes pacote(s) pendente(s) de atualizacao"
    fi

    if [[ "$MODO_EXECUCAO" != "true" ]]; then
        log "INFO" "MODO_EXECUCAO=false - simulacao apenas, nenhum pacote foi alterado"
        echo "[DRY RUN] $total_pacotes pacote(s) seriam atualizados. Nada foi alterado."
        return 0
    fi

    log "INFO" "Iniciando apt-get upgrade -y ($total_pacotes pacotes)"

    if ! apt-get upgrade -y > /tmp/apt_upgrade_output.log 2>&1; then
        log "ERROR" "apt-get upgrade falhou - ver /tmp/apt_upgrade_output.log"
        exit 5
    fi

    log "INFO" "apt-get upgrade concluido com sucesso ($total_pacotes pacotes atualizados)"
    echo "OK: $total_pacotes pacote(s) atualizados."
}

# =============================================================
# FLUXO PRINCIPAL
# =============================================================

log "INFO" "update_sistema.sh iniciado (config: $CONFIG_FILE, modo: $MODO_EXECUCAO)"

verificar_root

atualizar_lista_pacotes

TOTAL_PACOTES=$(contar_pacotes_disponiveis)

atualizar_pacotes "$TOTAL_PACOTES"

exit 0
