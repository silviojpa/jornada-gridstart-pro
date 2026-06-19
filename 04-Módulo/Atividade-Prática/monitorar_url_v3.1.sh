#!/bin/bash
# monitorar_url.sh - versao 4 (S04T02V05)
# GridStart Pro - Second Gear

if [[ $# -lt 1 ]]; then
    echo "Uso: $0 <URL> [MAX_TENTATIVAS] [INTERVALO] [STATUS_ESPERADO]"
    echo "Exemplo: $0 https://www.google.com 5 3 200"
    exit 1
fi

URL="$1"
MAX_TENTATIVAS="${2:-5}"
INTERVALO="${3:-3}"
TENTATIVA=1
STATUS_ESPERADO="${4:-200}"

# TAREFA 3: Validando o formato do quarto argumento (HTTP Status)
if [[ ${#STATUS_ESPERADO} -ne 3 ]]; then
    echo "[ERRO] O parametro STATUS_ESPERADO deve ter exatamente 3 digitos numericos (Ex: 200, 404, 500)."
    echo "Valor recebido: '$STATUS_ESPERADO' (${#STATUS_ESPERADO} caracteres)"
    echo "=== Fim do monitoramento (abortado por erro de argumento) ==="
    exit 1
fi
# =============================================================

echo "=== Monitorando $URL (max: $MAX_TENTATIVAS tentativas, intervalo: ${INTERVALO}s, status esperado: $STATUS_ESPERADO) ==="

until [[ "$(curl -s -o /dev/null -w '%{http_code}' "$URL")" == "$STATUS_ESPERADO" ]]; do
    echo "[Tentativa $TENTATIVA/$MAX_TENTATIVAS] $URL nao respondeu com $STATUS_ESPERADO"

    if [[ "$TENTATIVA" -ge "$MAX_TENTATIVAS" ]]; then
        echo "[FALHA] Limite de $MAX_TENTATIVAS tentativas atingido."
        echo "=== Fim do monitoramento (sem sucesso) ==="
        exit 1
    fi

    ((TENTATIVA++))
    sleep "$INTERVALO"
done

echo "[OK] $URL respondeu com $STATUS_ESPERADO na tentativa $TENTATIVA"
echo "=== Fim do monitoramento ==="
