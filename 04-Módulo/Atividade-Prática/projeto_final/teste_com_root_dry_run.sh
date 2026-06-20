#!/bin/bash
# =============================================================
# 04_teste_com_root_dry_run.sh (S04T02V08)
# GridStart Pro - Second Gear
#
# Demonstra o update_sistema.sh rodando COM sudo, mas com
# MODO_EXECUCAO="false" no update_sistema.conf (dry run).
# Espera-se exit code 0, sem alterar pacotes de fato.
# =============================================================

echo "Executando update_sistema.sh COM sudo, MODO_EXECUCAO=false (dry run):"
echo

sudo ./update_sistema.sh
echo "Codigo de saida: $?"

echo
echo "Conteudo do log apos a execucao:"
cat update_sistema.log
