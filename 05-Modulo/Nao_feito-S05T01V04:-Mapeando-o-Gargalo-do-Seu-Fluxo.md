# Atividade - S05T01V03: Telemetria do Seu Fluxo

**Objetivo:** Tornar visível, com dados reais do próprio projeto-gridstart, o tempo consumido em cada etapa do fluxo de valor (commit push deploy), preparando o terreno para identificar gargalos na próxima aula.  
**Tipo:** Prática (terminal) + reflexão escrita curta  
**Tempo estimado:** 20-30 minutos  
**Entrega:** Saída do `flow_log.csv` (colar ou print) + respostas curtas

---

## Pré-requisitos

* Ter assistido S05T01V03 (este vídeo) em especial o bloco prático sobre o `flow_timer.sh`.
* projeto-gridstart já existente, com `scripts/deploy.sh`, `backup.sh` e `monitorar.sh` (estado pós S04T04V06).
* Ter seguido o `S05_T01_V03_PASSO_A_PASSO_COMANDOS.md` para copiar e dar permissão ao `flow_timer.sh`.

---

## Parte 1 - Rodar pelo menos dois ciclos

1. Rode `bash scripts/flow_timer.sh` uma primeira vez.
2. Faça uma pequena alteração em qualquer arquivo do projeto (ex: um comentário novo em `monitorar.sh`) e comite (`git add` + `git commit`).
3. Rode `bash scripts/flow_timer.sh` de novo.
4. Repita o passo 2-3 uma terceira vez, se quiser mais dados.

Cole aqui o conteúdo final do seu `flow_log.csv`:

> [Cole o conteúdo do flow_log.csv aqui]

---

## Parte 2 - Qual etapa consumiu mais tempo?

Olhando as colunas `espera_push_s`, `tempo_push_s` e `tempo_deploy_s` do seu `flow_log.csv`:

Qual etapa, na maioria das suas rodadas, teve o maior valor?

> [Sua resposta aqui]

---

## Parte 3 - Uma hipótese para a causa

Por que você acha que essa etapa específica consumiu mais tempo que as outras?  
*(Exemplos de hipótese: rede lenta no git push, o scripts/deploy.sh faz algo que demora ou demorou de propósito porque você simulou um sleep, ou você só demorou mais pra rodar o segundo comando manualmente.)*

Justifique em 2-4 frases:

> [Sua resposta aqui]

---

## Parte 4 - Perguntas de reflexão

### 1. Se o seu git push falhou por falta de remoto configurado, o flow_timer.sh ainda assim te deu informação útil sobre o fluxo? Por quê?

> [Sua resposta aqui]

### 2. O vídeo comparou o flow_timer.sh a "telemetria de corrida - tempo de cada setor da pista". Na sua experiência rodando o script, algum número te surpreendeu (foi mais rápido ou mais lento do que você imaginava antes de medir)?

> [Sua resposta aqui]

### 3. (Opcional) O vídeo citou que reduzir o tamanho dos lotes e reduzir handoffs também fazem parte da Primeira Via, além de tornar o fluxo visível. No seu fluxo medido, você enxerga algum handoff (passagem de uma pessoa/time pra outra) que poderia ser eliminado ou simplificado?

> [Sua resposta aqui]

---

## Entrega

* **Parte 1:** conteúdo do `flow_log.csv` com pelo menos 2 linhas
* **Parte 2:** etapa identificada como a mais lenta
* **Parte 3:** hipótese justificada para a causa
* **Parte 4:** respostas das perguntas de reflexão

*Gabarito (critérios de avaliação) disponível em `S05_T01_V03_GABARITO.md`.*
