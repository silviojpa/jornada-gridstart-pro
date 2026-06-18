#!/bin/bash
# monitorar_url.sh - S04T02V04
# GridStart Pro - Second Gear

URL="https://www.google.com"
TENTATIVA=1
MAX_TENTATIVAS=5
INTERVALO=2

finalizar_monitoramento() {
    local STATUS_SAIDA=$1
    local MENSAGEM=$2
  
    local tempo_total
    (( tempo_total = (TENTATIVA - 1) * INTERVALO ))
    
    echo ""
    echo "$MENSAGEM"
    echo "Tempo total de monitoramento: ${tempo_total} segundos."
    echo "=== Fim do monitoramento ==="
    exit "$STATUS_SAIDA"
}

echo "=== Monitorando $URL ==="

while [ $TENTATIVA -le $MAX_TENTATIVAS ]; do

    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    
    echo "[Tentativa $TENTATIVA/$MAX_TENTATIVAS] $URL respondeu com status: $HTTP_CODE"

    # Caso 1: Sucesso (200) ou Redirecionamento (301, 302)
    if [[ "$HTTP_CODE" == "200" || "$HTTP_CODE" == "301" || "$HTTP_CODE" == "302" ]]; then
        finalizar_monitoramento 0 "[OK] $URL respondeu com sucesso ($HTTP_CODE) na tentativa $TENTATIVA"
    
    # Caso 2: Erros de Servidor mapeados (500, 502, 503)
    elif [[ "$HTTP_CODE" == "500" || "$HTTP_CODE" == "502" || "$HTTP_CODE" == "503" ]]; then
        finalizar_monitoramento 1 "[AVISO] $URL respondeu com erro de servidor ($HTTP_CODE)"
    fi

    ((TENTATIVA++))
    [ $TENTATIVA -le $MAX_TENTATIVAS ] && sleep "$INTERVALO"
done

# Caso 3: Se estourou o loop (Limite de tentativas atingido)
finalizar_monitoramento 1 "=== Erro: Limite de tentativas atingido sem sucesso ==="
