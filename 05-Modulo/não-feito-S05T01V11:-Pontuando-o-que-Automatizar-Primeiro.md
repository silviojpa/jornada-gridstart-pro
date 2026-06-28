# Atividade - S05T01V11: Pontuando o que Automatizar Primeiro

**Objetivo:** Aplicar os três critérios de Quick Win (repetitiva, bem definida, erro custoso) às etapas humanas que você mapeou no `vsm_*.md` (V10), usando o `quickwin_score.sh`, e decidir com dados o que automatizar primeiro e o que ainda não deve ser automatizado.  
**Tipo:** Edição + execução de script + conclusão escrita  
**Tempo estimado:** 15-20 minutos  
**Entrega:** Arquivo `quickwin_AAAA-MM-DD_HHMMSS.md` completo

---

## Pré-requisitos

* Ter assistido S05T01V11 (este vídeo) e S05T01V10.
* Ter o `vsm_AAAA-MM-DD_HHMMSS.md` gerado no V10, com pelo menos duas etapas humanas já preenchidas pelo time (Lead Time/Process Time).
* Ter `medias.txt` (gerado pelo `bottleneck_finder.sh`, S05T01V04) no seu projeto-gridstart.

---

## Parte 1 - Avaliando as etapas humanas pelos três critérios

Para cada etapa humana do seu `vsm_*.md`, responda com honestidade (com o time, debatendo e não no chute):

### Etapa humana 1: [nome - copie exatamente do seu vsm_*.md]
* É repetitiva e de alta frequência? (s/n): [ ]
* É bem definida/documentada, sem ambiguidade entre quem executa? (s/n): [ ]
* O erro humano nela já causou, ou pode causar, problema real? (s/n): [ ]

### Etapa humana 2: [nome - copie exatamente do seu vsm_*.md]
* É repetitiva e de alta frequência? (s/n): [ ]
* É bem definida/documentada, sem ambiguidade entre quem executa? (s/n): [ ]
* O erro humano nela já causou, ou pode causar, problema real? (s/n): [ ]

---

## Parte 2 - Editando e rodando o quickwin_score.sh

Abra `scripts/s05t01v11/S05_T01_V11_quickwin_score.sh` e, no **BLOCO 1**, substitua os dois exemplos (code review e aprovacao de QA) pelas suas etapas reais da Parte 1, no formato:

`"nome da etapa;s_ou_n;s_ou_n;s_ou_n"`

Depois rode o script - ver `S05_T01_V11_PASSO_A_PASSO_COMANDOS.md` para o passo a passo completo.

---

## Parte 3 - Conclusão

Com a tabela de pontuação gerada pelo script, responda:

* **Primeira automação recomendada (maior pontuação, ainda não automatizada):** [nome da etapa]
* **Etapa que NÃO deve ser automatizada ainda (menor pontuação):** [nome da etapa]

**Por que essa etapa de menor pontuação precisa de processo, e não de script:**
> [Sua justificativa específica aqui]

---

## Parte 4 - Atualizando o arquivo gerado

Abra o arquivo `quickwin_AAAA-MM-DD_HHMMSS.md` gerado pelo script e preencha as três linhas `[preencher]` da seção "Conclusão" com as respostas da Parte 3.

---

## Entrega

* **Parte 1:** critérios avaliados com (s/n) para as etapas humanas
* **Parte 2:** execução do script configurado
* **Parte 3:** recomendação e contraindicação de automação justificadas
* **Parte 4:** arquivo `quickwin_*.md` atualizado

*Gabarito (critérios de avaliação) disponível em `S05_T01_V11_GABARITO.md`.*
