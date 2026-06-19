#!/bin/bash
# =============================================================
# monitorar_url.sh - versao 3 (S04T02V05)
# GridStart Pro - Second Gear
# =============================================================

# TAREFA 2: Atualizando a mensagem de uso e exemplo para incluir o 4º parâmetro
if [[ $# -lt 1 ]]; then
    echo "Uso: $0 <URL> [MAX_TENTATIVAS] [INTERVALO] [STATUS_ESPERADO]"
    echo "Exemplo: $0 https://www.google.com 5 3 200"
    exit 1
fi

URL="$1"
MAX_TENTATIVAS="${2:-5}"
INTERVALO="${3:-3}"
TENTATIVA=1
# TAREFA 1: Quarto parâmetro opcional definido com valor padrão 200
STATUS_ESPERADO="${4:-200}"

# Ajustado o echo inicial para mostrar dinamicamente o status que estamos buscando
echo "=== Monitorando $URL (max: $MAX_TENTATIVAS tentativas, intervalo: ${INTERVALO}s, status esperado: $STATUS_ESPERADO) ==="

# TAREFA 1: Substituído o "200" fixo por "$STATUS_ESPERADO" na condição do until
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

# Ajustado o echo final de sucesso para mostrar a variável dinâmica
echo "[OK] $URL respondeu com $STATUS_ESPERADO na tentativa $TENTATIVA"
echo "=== Fim do monitoramento ==="
