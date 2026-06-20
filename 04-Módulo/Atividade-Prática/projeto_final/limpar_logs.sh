#!/bin/bash
set -euo pipefail
# =============================================================
# limpar_logs.sh
# GridStart Pro - Second Gear
#
# Le configuracoes de 'limpar_logs.conf' para listar ou deletar
# arquivos .log de uma pasta especifica de forma segura.
#
# Convencao de exit codes deste script:
#   0 = sucesso (arquivos limpos ou simulados)
#   2 = arquivo de configuracao nao encontrado
#   3 = pasta de destino dos logs nao encontrada
# =============================================================

CONFIG_FILE="./limpar_logs.conf"

# --- 1. Validacao e carregamento do arquivo de configuracao ---
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERRO: arquivo de configuracao nao encontrado: $CONFIG_FILE"
    exit 2
fi

# shellcheck source=/dev/null
source "$CONFIG_FILE"

# --- 2. Funcao de Log Estruturado ---
log() {
    local nivel="$1"
    local mensagem="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$nivel] $mensagem" >> "$LOG_FILE"
}

# --- 3. Trap de saida ---
ao_sair() {
    local codigo=$?
    if [[ "$codigo" -eq 0 ]]; then
        log "INFO" "limpar_logs.sh finalizado com sucesso (codigo $codigo)"
    else
        log "ERROR" "limpar_logs.sh finalizado com erro (codigo $codigo)"
    fi
}

trap ao_sair EXIT

# --- Inicio do Fluxo ---
log "INFO" "limpar_logs.sh iniciado (modo: $MODO_EXECUCAO)"

# --- 4. Validacao da pasta alvo ---
if [[ ! -d "$PASTA_LOGS" ]]; then
    log "ERROR" "A pasta alvo de logs nao existe: $PASTA_LOGS"
    echo "ERRO: O diretorio de logs '$PASTA_LOGS' nao existe."
    exit 3
fi

# --- 5. Contagem dos arquivos .log ---
# Usa find para listar apenas arquivos (.log) na pasta e wc -l para contar
TOTAL_LOGS=$(find "$PASTA_LOGS" -maxdepth 1 -name "*.log" | wc -l)

# --- 6. Decisao com base no MODO_EXECUCAO ---
if [[ "$MODO_EXECUCAO" != "true" ]]; then
    # Modo Dry Run (Simulacao)
    log "INFO" "MODO_EXECUCAO=false. Simulacao: $TOTAL_LOGS arquivo(s) seriam removidos."
    echo "[DRY RUN] $TOTAL_LOGS arquivo(s) .log seriam removidos da pasta '$PASTA_LOGS'. Nada foi alterado."
else
    # Modo Real (Delecao de fato)
    if [[ "$TOTAL_LOGS" -eq 0 ]]; then
        log "INFO" "Nenhum arquivo .log encontrado para remover."
        echo "Pasta '$PASTA_LOGS' ja esta limpa. Nada a fazer."
    else
        log "WARNING" "Iniciando a remocao de $TOTAL_LOGS arquivo(s) .log em '$PASTA_LOGS'."

        # Remove os logs de forma segura apenas naquela pasta informada
        find "$PASTA_LOGS" -maxdepth 1 -name "*.log" -delete

        log "INFO" "Remocao concluida. $TOTAL_LOGS arquivo(s) foram apagados."
        echo "OK: $TOTAL_LOGS arquivo(s) .log foram removidos com sucesso."
    fi
fi

exit 0
