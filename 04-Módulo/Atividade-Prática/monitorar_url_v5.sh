#!/bin/bash
# =============================================================
# monitorar_url_v5.sh - versao 5 (S04T02V06)
# GridStart Pro - Second Gear
# Organizado em funcoes reutilizaveis com captura de string.
# =============================================================

SCRIPT_NAME="$0"

# --- Funcao 1: valida os argumentos recebidos pelo script ---
validar_argumentos() {
    if [[ -z "$1" ]]; then
        echo "Uso: $SCRIPT_NAME <URL> [MAX_TENTATIVAS] [INTERVALO] [STATUS_ESPERADO]"
        echo "Exemplo: $SCRIPT_NAME https://www.google.com 5 3 200"
        exit 1
    fi
}

# --- TAREFA 1: Nova funcao montar_mensagem_inicial() ---
montar_mensagem_inicial() {
    local url="$1"
    local max_tentativas="$2"
    local intervalo="$3"
    
    # "Devolve" a string formatada exatamente no padrao original
    echo "=== Monitorando $url (max: $max_tentativas tentativas, intervalo: ${intervalo}s, esperado: $STATUS_ESPERADO) ==="
}

# --- Funcao 2: faz as tentativas de curl ate a URL responder ---
checar_url() {
    local url="$1"
    local max_tentativas="$2"
    local intervalo="$3"
    local status_esperado="$4"
    local tentativa=1

    until [[ "$(curl -s -o /dev/null -w '%{http_code}' "$url")" == "$status_esperado" ]]; do
        if [[ "$tentativa" -ge "$max_tentativas" ]]; then
            echo "FALHA: $url nao respondeu com $status_esperado apos $max_tentativas tentativas"
            return 1
        fi
        tentativa=$((tentativa + 1))
        sleep "$intervalo"
    done

    echo "OK: $url respondeu com $status_esperado na tentativa $tentativa"
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

# =============================================================
# FLUXO PRINCIPAL
# =============================================================

validar_argumentos "$1"

URL="$1"
MAX_TENTATIVAS="${2:-5}"
INTERVALO="${3:-3}"
STATUS_ESPERADO="${4:-200}"

if [[ ${#STATUS_ESPERADO} -ne 3 ]]; then
    echo "[ERRO] O parametro STATUS_ESPERADO deve ter exatamente 3 digitos."
    exit 1
fi

# --- TAREFA 2: Substituindo a linha original por captura de funca ---
MENSAGEM_INICIAL=$(montar_mensagem_inicial "$URL" "$MAX_TENTATIVAS" "$INTERVALO")
echo "$MENSAGEM_INICIAL"

# Executa a checagem
RESULTADO=$(checar_url "$URL" "$MAX_TENTATIVAS" "$INTERVALO" "$STATUS_ESPERADO")
STATUS=$?

exibir_resultado "$RESULTADO" "$STATUS"

exit "$STATUS"
