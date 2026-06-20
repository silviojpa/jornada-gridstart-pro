#!/bin/bash
# =============================================================
# backup_simples.sh
# GridStart Pro - Second Gear
# Organizado com tratamento de erros, logs e traps
# =============================================================
set -euo pipefail

LOG_FILE="./backup.log"
PASTA_ORIGEM="/var/www/html"
PASTA_DESTINO="/backup"

# --- Funcao de Log Estruturado ---
log() {
    local nivel="$1"
    local mensagem="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$nivel] $mensagem" >> "$LOG_FILE"
}

# --- Tarefa 4: Funcao ao_sair() ---
ao_sair() {
    local codigo=$?
    if [[ "$codigo" -eq 0 ]]; then
        log "INFO" "backup_simples.sh finalizado com sucesso (codigo $codigo)"
    else
        log "ERROR" "backup_simples.sh finalizado com erro (codigo $codigo)"
    fi
}

# ⚠️ ATENÇÃO À ORDEM: O trap deve vir antes de qualquer checagem que possa dar exit!
trap ao_sair EXIT

# --- Inicio do Script ---
log "INFO" "backup_simples.sh iniciado"

# --- Tarefa 2: Checagens que podem falhar (Gerando logs de ERROR) ---
if [[ ! -d "$PASTA_ORIGEM" ]]; then
    log "ERROR" "Diretorio de origem '$PASTA_ORIGEM' nao existe ou nao foi encontrado."
    echo "Erro: Pasta de origem nao encontrada."
    exit 1
fi

if [[ ! -d "$PASTA_DESTINO" ]]; then
    log "ERROR" "Diretorio de destino '$PASTA_DESTINO' nao existe ou nao foi encontrado."
    echo "Erro: Pasta de destino nao encontrada."
    exit 1
fi

# --- Execução do Backup ---
TIMESTAMP_ARQUIVO=$(date '+%Y%m%d_%H%M%S')
NOME_BACKUP="backup_web_${TIMESTAMP_ARQUIVO}.tar.gz"

echo "Criando o backup comprimido em $PASTA_DESTINO/$NOME_BACKUP..."

# Protegendo o tar com || true por causa do set -e
tar -czf "$PASTA_DESTINO/$NOME_BACKUP" -C "$PASTA_ORIGEM" . || true
STATUS_TAR="${PIPESTATUS[0]}"

if [[ "$STATUS_TAR" -eq 0 ]]; then
    # --- Tarefa 2: INFO quando o backup é criado com sucesso, incluindo o nome ---
    log "INFO" "Backup criado com sucesso. Arquivo gerado: $NOME_BACKUP"
    echo "[OK] Backup gerado com sucesso!"
else
    log "ERROR" "Falha critica ao compactar arquivos com o comando tar."
    echo "Erro: Falha na compactacao."
    exit 1
fi

exit 0
