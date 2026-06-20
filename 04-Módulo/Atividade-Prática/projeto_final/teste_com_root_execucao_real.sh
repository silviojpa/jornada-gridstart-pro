#!/bin/bash
# =============================================================
# 05_teste_com_root_execucao_real.sh (S04T02V08)
# GridStart Pro - Second Gear
#
# Demonstra o update_sistema.sh rodando COM sudo e
# MODO_EXECUCAO="true" no update_sistema.conf - atualiza
# pacotes de fato. Use com cautela em maquina de gravacao.
# =============================================================

echo "ATENCAO: este modo aplica 'apt-get upgrade -y' de verdade."
echo "Confirme que MODO_EXECUCAO=\"true\" em update_sistema.conf antes de rodar."
echo

sudo ./update_sistema.sh
echo "Codigo de saida: $?"

echo
echo "Conteudo do log apos a execucao:"
cat update_sistema.log
