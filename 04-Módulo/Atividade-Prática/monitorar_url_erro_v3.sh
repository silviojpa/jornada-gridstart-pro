#!/bin/bash
# monitorar_url.sh - S04T02V04
# GridStart Pro - Second Gear

URL="https://www.google.com"
TENTATIVA=1
MAX_TENTATIVAS=5
INTERVALO=2

echo "=== Monitorando $URL ==="

while [ $TENTATIVA -le $MAX_TENTATIVAS ]; do

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

    echo "[Tentativa $TENTATIVA/$MAX_TENTATIVAS] $URL respondeu com status: $HTTP_CODE"

    # Se responder com Sucesso (200) ou Redirecionamento (301, 302)
    if [[ "$HTTP_CODE" == "200" || "$HTTP_CODE" == "301" || "$HTTP_CODE" == "302" ]]; then
        echo "[OK] $URL respondeu com sucesso ($HTTP_CODE) na tentativa $TENTATIVA"
        echo "=== Fim do monitoramento ==="
        exit 0

    # Se responder com os erros de servidor solicitados (500, 502, 503)
    elif [[ "$HTTP_CODE" == "500" || "$HTTP_CODE" == "502" || "$HTTP_CODE" == "503" ]]; then
        echo "[AVISO] $URL respondeu com erro de servidor ($HTTP_CODE)"
        echo "=== Fim do monitoramento (com erro de servidor) ==="
        exit 1
    fi

    ((TENTATIVA++))
    [ $TENTATIVA -le $MAX_TENTATIVAS ] && sleep "$INTERVALO"
done

# Se sair do loop sem dar exit, estourou o limite de tentativas
echo "=== Fim do monitoramento (limite de tentativas atingido sem sucesso) ==="
exit 1
