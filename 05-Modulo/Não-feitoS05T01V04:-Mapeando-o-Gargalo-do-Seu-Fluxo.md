# [cite_start]Atividade - S05T01V04: Mapeando o Gargalo do Seu Fluxo [cite: 41, 42]

[cite_start]**Objetivo:** Aplicar a Teoria das Restrições ao próprio fluxo medido no projeto-gridstart, identificar visualmente o gargalo, propor a primeira ação de "exploração" (sem investir em nada novo) e conectar com o tipo de desperdício Lean presente. [cite: 43]  
[cite_start]**Tipo:** Reflexão visual + escrita curta - sem comandos novos de terminal como entrega obrigatória [cite: 44]  
[cite_start]**Tempo estimado:** 20-25 minutos [cite: 44]  
[cite_start]**Entrega:** Diagrama anotado (desenho ou print com marcação) + respostas curtas [cite: 44]

---

## Pré-requisitos

* [cite_start]Ter assistido S05T01V04 (este vídeo). [cite: 46]
* [cite_start]`flow_log.csv` já existente, gerado no S05T01V03, com pelo menos 2 ciclos registrados. [cite: 47]
* [cite_start]*Opcional, mas recomendado:* ter rodado o `bottleneck_finder.sh` (ver `S05_T01_V04_PASSO_A_PASSO_COMANDOS.md`) para confirmar o gargalo com números. [cite: 47, 48]

---

## Parte 1 - Identificar o gargalo

[cite_start]Se você rodou o `bottleneck_finder.sh`, cole aqui a linha `GARGALO IDENTIFICADO` que apareceu no terminal: [cite: 50]

> [cite_start][Cole aqui o resultado do bottleneck_finder.sh] [cite: 51]

[cite_start]Se não rodou o script, olhe direto para o seu `flow_log.csv` do V03 e responda: qual coluna (`espera_push_s`, `tempo_push_s` ou `tempo_deploy_s`) tem, na maioria das linhas, o maior valor? [cite: 52, 53]

> [cite_start][Sua resposta aqui] [cite: 54]

---

## Parte 2 - Desenhar o fluxo com o gargalo marcado

Desenhe (no papel, num editor de imagem, ou em texto estruturado tipo diagrama ASCII) as três etapas do fluxo: `commit` ➔ `git push` ➔ `scripts/deploy.sh`. [cite_start]Marque visualmente qual delas é o gargalo identificado na Parte 1 (uma seta, um círculo, uma cor diferente — o formato é livre). [cite: 56]

> [cite_start][Descreva ou anexe seu diagrama aqui] [cite: 57]

---

## Parte 3 - A ação de "exploração" (Passo 2 da TOC)

[cite_start]Sem investir em nada novo (sem trocar de ferramenta, sem contratar, sem mudar de provedor), que ação concreta você tomaria hoje para tirar o máximo da etapa que você marcou como gargalo? [cite: 59]

[cite_start]Justifique em 2-4 frases: [cite: 60]

> [cite_start][Sua resposta aqui] [cite: 61]

---

## [cite_start]Parte 4 - Que desperdício está presente? [cite: 62]

[cite_start]A aula apresentou três desperdícios visíveis no `flow_log.csv`: **espera** (tempo parado sem agregar valor), **handoff** (passagem de bastão entre Dev e Ops) e **retrabalho** (esforço repetido por falha). [cite: 63]

[cite_start]Qual desses três você identifica na etapa apontada como gargalo, e por quê? [cite: 64]

> [cite_start][Sua resposta aqui] [cite: 65]

---

## [cite_start]Parte 5 - Perguntas de reflexão [cite: 66, 67]

### 1. A aula disse que otimizar uma etapa que não é o gargalo não acelera o fluxo inteiro. [cite_start]Pensando no seu próprio fluxo, existe alguma etapa que você suspeitava ser "o problema" antes desta aula, mas que os dados mostraram não ser o gargalo real? [cite: 68, 69]

> [cite_start][Sua resposta aqui] [cite: 70]

### [cite_start]2. (Opcional) Se você resolvesse o gargalo apontado hoje, qual das outras duas etapas você imagina que se tornaria o novo gargalo (Passo 5 da TOC - repetir)? [cite: 71]

> [cite_start][Sua resposta aqui] [cite: 72]

---

## [cite_start]Entrega [cite: 73]

* [cite_start]**Parte 1:** gargalo identificado, baseado em dados reais [cite: 74, 78]
* [cite_start]**Parte 2:** diagrama do fluxo com o gargalo marcado [cite: 75, 79]
* [cite_start]**Parte 3:** ação de exploração concreta e sem investimento novo [cite: 76, 80]
* [cite_start]**Parte 4:** desperdício identificado e justificado [cite: 77, 81]
* [cite_start]**Parte 5:** perguntas de reflexão [cite: 82]

[cite_start]*Gabarito (critérios de avaliação) disponível em `S05_T01_V04_GABARITO.md`.* [cite: 83]
