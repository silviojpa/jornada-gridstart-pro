#!/bin/bash
# ============================================================================
# S04T04V06 - O Checklist de Segunda Marcha: revisao do projeto-gridstart
#
# ATENCAO: NAO execute este arquivo de uma vez. Copie e cole BLOCO por BLOCO
# no terminal, na ordem, para acompanhar o resultado de cada checagem.
#
# Pre-requisitos:
#   - Ter concluido os videos S04T04V01 a V05 (e, antes deles, os topicos
#     T01, T02 e T03 do modulo Second Gear)
#   - Estar na pasta-pai de "projeto-gridstart" (o BLOCO 0 entra nela)
#
# Este script e SOMENTE DIAGNOSTICO: ele LE o estado do projeto e imprime
# PASS ou FAIL para cada item. Ele NAO cria, apaga, move ou comita nada.
# ============================================================================


# ============================================================
# BLOCO 0 - Ponto de partida + funcao auxiliar "check"
# ============================================================
cd projeto-gridstart || { echo "ERRO: pasta projeto-gridstart nao encontrada."; return 1; }

echo "=== Onde estamos ==="
pwd
git status
git log --oneline -15

# Contadores do checklist
PASS_COUNT=0
FAIL_COUNT=0

# Funcao "check": recebe uma descricao e o codigo de saida do comando
# anterior ($?). Codigo 0 = sucesso = PASS. Qualquer outro = FAIL.
# Essa e a mesma logica de "if/then/else" que a gente usou no T02,
# so que dentro de uma funcao para nao repetir o if 20 vezes.
check() {
  local descricao="$1"
  local resultado="$2"

  if [ "$resultado" -eq 0 ]; then
    echo "✅ PASS - $descricao"
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo "❌ FAIL - $descricao"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
}


# ============================================================
# BLOCO 1 - Revisao T01/T02: scripts de shell
# ============================================================
echo ""
echo "=== Checklist: scripts de shell (T01/T02) ==="

# 1. scripts/deploy.sh existe (foi movido para scripts/ com git mv na V05)
[ -f "scripts/deploy.sh" ]
check "scripts/deploy.sh existe (movido com git mv na V05)" $?

# 2. scripts/deploy.sh comeca com shebang
[ -f "scripts/deploy.sh" ] && head -n 1 scripts/deploy.sh | grep -qE '^#!(/usr/bin/env bash|/bin/bash)'
check "scripts/deploy.sh comeca com shebang #!/bin/bash" $?

# 3. scripts/deploy.sh tem permissao de execucao
[ -x "scripts/deploy.sh" ]
check "scripts/deploy.sh tem permissao de execucao (x)" $?

# 4. scripts/deploy.sh nao tem erro de sintaxe
bash -n scripts/deploy.sh 2>/dev/null
check "scripts/deploy.sh nao tem erro de sintaxe (bash -n)" $?

# 5. backup.sh existe (criado e documentado na V01)
[ -f "scripts/backup.sh" ]
check "backup.sh existe no projeto (movido com git mv na V04)" $?

# 6. monitorar.sh existe (corrigido na V01)
[ -f "scripts/monitorar.sh" ]
check "monitorar.sh existe no projeto (movido com git mv na V04)" $?


# ============================================================
# BLOCO 2 - Revisao T03: historico e colaboracao no Git
# ============================================================
echo ""
echo "=== Checklist: historico Git (T03) ==="

# 7. repositorio tem um historico de commits razoavel
TOTAL_COMMITS=$(git log --oneline | wc -l | tr -d ' ')
[ "$TOTAL_COMMITS" -ge 8 ]
check "repositorio tem pelo menos 8 commits (encontrados: $TOTAL_COMMITS)" $?

# 8. branch "main" existe
git branch --list main | grep -q main
check "branch 'main' existe" $?

# 9. branch "develop" existe
git branch --list develop | grep -q develop
check "branch 'develop' existe" $?

# 10. remoto "origin" configurado (conexao com o GitHub, da V11 do T03)
git remote | grep -q origin
check "remoto 'origin' configurado" $?

# 11. working tree limpo (nada para commitar)
[ -z "$(git status --porcelain)" ]
check "working tree limpo (sem alteracoes pendentes)" $?


# ============================================================
# BLOCO 3 - Revisao T04: boas praticas e seguranca do repositorio
# ============================================================
echo ""
echo "=== Checklist: boas praticas e seguranca (T04) ==="

# 12. .gitignore existe e ignora .env
[ -f ".gitignore" ] && grep -qx "\.env" .gitignore
check ".gitignore existe e ignora .env" $?

# 13. .gitignore ignora node_modules/ e *.log
[ -f ".gitignore" ] && grep -q "node_modules" .gitignore && grep -q "\*\.log" .gitignore
check ".gitignore ignora node_modules/ e *.log" $?

# 14. .env NAO esta versionado (segredo real fica fora do Git)
! git ls-files | grep -qx ".env"
check ".env NAO esta versionado (segredo fora do Git)" $?

# 15. .env.example ESTA versionado (documenta as variaveis esperadas)
git ls-files | grep -qx ".env.example"
check ".env.example esta versionado (documenta variaveis)" $?

# 16. pastas scripts/, docs/ e configs/ existem (organizacao da V05)
[ -d "scripts" ] && [ -d "docs" ] && [ -d "configs" ]
check "pastas scripts/, docs/ e configs/ existem" $?

# 17. docs/.gitkeep e configs/.gitkeep existem (pastas vazias versionadas)
[ -f "docs/.gitkeep" ] && [ -f "configs/.gitkeep" ]
check "docs/.gitkeep e configs/.gitkeep existem" $?

# 18. README.md tem a secao "Como usar"
[ -f "README.md" ] && grep -q "## Como usar" README.md
check "README.md tem secao 'Como usar'" $?

# 19. README.md tem a secao "Organização do repositório" (da V05)
[ -f "README.md" ] && grep -q "## Organização do repositório" README.md
check "README.md tem secao 'Organização do repositório'" $?

# 20. ultimos commits seguem Conventional Commits (feat/fix/docs/chore...)
git log --oneline -10 | grep -qE '^[a-f0-9]+ (feat|fix|docs|chore|refactor|test)(\([a-z0-9_-]+\))?: '
check "ultimos commits seguem Conventional Commits" $?


# ============================================================
# BLOCO 4 - Resumo final do Checklist de Segunda Marcha
# ============================================================
echo ""
echo "============================================================"
echo "RESUMO DO CHECKLIST DE SEGUNDA MARCHA"
echo "============================================================"
echo "PASS: $PASS_COUNT"
echo "FAIL: $FAIL_COUNT"
echo ""

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo "🏁 Tudo verde! O projeto-gridstart esta pronto para a Cultura DevOps."
else
  echo "⚠️  Ainda ha $FAIL_COUNT item(ns) pendente(s)."
  echo "Revise os itens marcados com FAIL acima antes de seguir para o Modulo 05."
fi

# Resultado esperado:
#   - Se voce seguiu os videos S04T04V01 a V05 sem pular blocos, o esperado
#     e PASS em TODOS os 20 itens.
#   - Se algum item aparecer como FAIL, volte ao video correspondente
#     (indicado no comentario de cada checagem) e refaca o bloco que faltou.
#   - Este script pode ser executado quantas vezes voce quiser: ele so LE o
#     estado do projeto, nunca altera nada.
