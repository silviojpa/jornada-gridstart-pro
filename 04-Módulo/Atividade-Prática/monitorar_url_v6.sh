#!/bin/bash
set -euo pipefail
# =============================================================
# monitorar_url_v6.sh - versao 6 (S04T02V07)
# GridStart Pro - Second Gear
# Adiciona: set -euo pipefail, trap, log() com timestamp/nivel
# =============================================================

LOG_FILE="./monitorar.log"

log() {
    local nivel="$1"
    local mensagem="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$nivel] $mensagem" >> "$LOG_FILE"
}

ao_sair() {
    local codigo=$?
    if [[ "$codigo" -eq 0 ]]; then
        log "INFO" "monitorar_url_v6.sh finalizado com sucesso (codigo $codigo)"
    else
        log "ERROR" "monitorar_url_v6.sh finalizado com erro (codigo $codigo)"
    fi
}

trap ao_sair EXIT

# --- Funcao 1: valida os argumentos recebidos pelo script ---
validar_argumentos() {
    if [[ $# -lt 1 ]]; then
        log "ERROR" "Argumentos invalidos: esperado pelo menos 1, recebido $#"
        echo "Uso: $0 <URL> [MAX_TENTATIVAS] [INTERVALO]"
        echo "Exemplo: $0 https://www.google.com 5 3"
        exit 2
    fi
}

# --- Funcao 2: faz as tentativas de curl ate a URL responder ---
checar_url() {
    local url="$1"
    local max_tentativas="$2"
    local intervalo="$3"
    local tentativa=1

    until curl --output /dev/null --silent --head --fail "$url"; do
        if [[ "$tentativa" -ge "$max_tentativas" ]]; then
            log "ERROR" "$url nao respondeu apos $max_tentativas tentativas"
            echo "FALHA: $url nao respondeu apos $max_tentativas tentativas"
            return 1
        fi
        log "WARNING" "$url nao respondeu na tentativa $tentativa, tentando novamente"
        tentativa=$((tentativa + 1))
        sleep "$intervalo"
    done

    log "INFO" "$url respondeu na tentativa $tentativa"
    echo "OK: $url respondeu na tentativa $tentativa"
    return 0
}

# --- Funcao 3: exibe o resultado final formatado ---
exibir_resultado() {
    local mensagem="$1"
    local status="$2"

    echo "================================================="
    echo "$mensagem"
    echo "Codigo de saida: $status"
    echo "================================================="
}

# --- Funcao 4: monta a mensagem inicial ---
montar_mensagem_inicial() {
    local url="$1"
    local max_tentativas="$2"
    local intervalo="$3"

    echo "=== Monitorando $url (max: $max_tentativas tentativas, intervalo: ${intervalo}s) ==="
}

# =============================================================
# FLUXO PRINCIPAL
# =============================================================

log "INFO" "monitorar_url_v6.sh iniciado"

validar_argumentos "$@"

URL="$1"
MAX_TENTATIVAS="${2:-5}"
INTERVALO="${3:-3}"

MENSAGEM_INICIAL=$(montar_mensagem_inicial "$URL" "$MAX_TENTATIVAS" "$INTERVALO")
echo "$MENSAGEM_INICIAL"
log "INFO" "$MENSAGEM_INICIAL"

RESULTADO=$(checar_url "$URL" "$MAX_TENTATIVAS" "$INTERVALO")
STATUS=$?

exibir_resultado "$RESULTADO" "$STATUS"

exit "$STATUS"
