# Atividade - S05T01V10: Mapeando o VSM do seu Fluxo

[cite_start]**Objetivo:** Gerar o esqueleto automático do VSM a partir dos dados reais já coletados pelo `flow_timer.sh` (V03) e `bottleneck_finder.sh` (V04), e completá-lo em time, mapeando Lead Time e Process Time das etapas humanas que nenhum script mede. [cite: 538]  
**Tipo:** Leitura/execução de script + reflexão escrita colaborativa  
[cite_start]**Tempo estimado:** 20-25 minutos [cite: 539]  
[cite_start]**Entrega:** Arquivo `vsm_AAAA-MM-DD_HHMMSS.md` completo [cite: 539]

---

## Pré-requisitos

* [cite_start]Ter assistido S05T01V10 (este vídeo). [cite: 541]
* [cite_start]Ter `flow_log.csv` (gerado pelo `flow_timer.sh`, S05T01V03, rodado pelo menos 2 vezes) e `medias.txt` (gerado pelo `bottleneck_finder.sh`, S05T01V04) já existentes no seu projeto-gridstart. [cite: 542]
* [cite_start]Ter rodado o `vsm_scaffold.sh` (ver `S05_T01_V10_PASSO_A_PASSO_COMANDOS.md`) para gerar o esqueleto com as três etapas automatizadas já preenchidas. [cite: 543]

---

## Parte 1 - Mapeando as etapas humanas

[cite_start]Liste pelo menos duas etapas humanas que acontecem entre o commit e a entrega final ao cliente, e que nenhum script deste curso mede (ex: code review, aprovação de QA, espera por outro time, validação de produto). [cite: 545] [cite_start]Se ainda não tiver um time real pra debater, simule a conversa por escrito - ver a "Dica de pit stop" no vídeo. [cite: 546]

> [cite_start]**Etapa humana 1:** [Code Review / Revisão de Código por Pares] [cite: 547]  
> [cite_start]**Lead Time estimado:** [24 horas (o commit fica à espera que outro programador tenha tempo para revisar)] [cite: 548]  
> [cite_start]**Process Time estimado:** [30 minutos (tempo real gasto a analisar o código e a dar o feedback)] [cite: 548]  

> [cite_start]**Etapa humana 2:** [Homologação / Testes manuais em QA] [cite: 549]  
> [cite_start]**Lead Time estimado:** [48 horas (o deploy em staging aguarda na fila para a equipa de QA testar)] [cite: 550]  
> [cite_start]**Process Time estimado:** [2 horas (tempo gasto a executar os cenários de teste manuais)] [cite: 550]  

---

## Parte 2 - Totais do fluxo completo

[cite_start]Some o Lead Time de todas as etapas da tabela (as três automatizadas do `vsm_scaffold.sh` + as etapas humanas da Parte 1), e faça o mesmo com o Process Time. [cite: 552]

> [cite_start]**Lead Time total do fluxo completo:** [72 horas e 15 minutos] [cite: 553]  
> [cite_start]**Process Time total do fluxo completo:** [2 horas e 40 minutos] [cite: 554]  

---

## Parte 3 - Identificando o gargalo

[cite_start]Aponte qual etapa específica tem o maior gap entre Lead Time e Process Time, e escreva uma frase concreta justificando por que essa etapa é o gargalo — não vale só citar o número. [cite: 555, 556]

> [cite_start]**Etapa com o maior gap:** [Homologação / Testes manuais em QA] [cite: 557]  
> [cite_start]**Gap (Lead Time - Process Time): [46 horas]** [cite: 558]  
> [cite_start]**Por que essa etapa é o gargalo:** [Esta etapa representa a maior restrição do fluxo porque os pacotes de alteração acumulam-se à espera de validação manual da equipa de QA, gerando um enorme desperdício de tempo parado em comparação com o tempo real de trabalho dedicado aos testes.] [cite: 559]  

---

## Parte 4 - Atualizando o arquivo gerado

[cite_start]Abra o arquivo `vsm_AAAA-MM-DD_HHMMSS.md` gerado pelo `vsm_scaffold.sh` e preencha as linhas `[preencher]` da tabela e da seção "Totais do fluxo completo" com o que você respondeu nas Partes 1 a 3. [cite: 561, 562]
> Os dados acima foram consolidados na tabela Markdown e na secção de totais do ficheiro gerado pelo vsm_scaffold.sh para refletir o mapa de valor real de ponta a ponta.
---

## Entrega

* [cite_start]**Parte 1:** pelo menos duas etapas humanas, com Lead Time e Process Time estimados [cite: 564]
* [cite_start]**Parte 2:** Lead Time total e Process Time total do fluxo completo [cite: 565]
* [cite_start]**Parte 3:** etapa com o maior gap, com justificativa específica [cite: 566]
* [cite_start]**Parte 4:** arquivo `vsm_*.md` atualizado com as Partes 1 a 3 [cite: 567]

[cite_start]*Gabarito (critérios de avaliação) disponível em `S05_T01_V10_GABARITO.md`.* [cite: 568]
