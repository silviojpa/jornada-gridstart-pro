#!/bin/bash
# monitorar_url.sh - S04T02V04
# GridStart Pro - Second Gear

URL="https://www.google.com"
TENTATIVA=1
MAX_TENTATIVAS=5
INTERVALO=3

echo "=== Monitorando $URL ==="

until [[ "$(curl -s -o /dev/null -w '%{http_code}' "$URL")" == "200" || "301" || "302" ]]; do
    echo "[Tentativa $TENTATIVA/$MAX_TENTATIVAS] $URL nao respondeu com 200 ou 301 ou 302"

    if [[ "$TENTATIVA" -ge "$MAX_TENTATIVAS" ]]; then
        echo "[FALHA] Limite de $MAX_TENTATIVAS tentativas atingido."
        echo "=== Fim do monitoramento (sem sucesso) ==="
        exit 1
    fi

    ((TENTATIVA++))
    sleep "$INTERVALO"
done

echo "[OK] $URL respondeu com 200 na tentativa $TENTATIVA"
echo "=== Fim do monitoramento ==="
