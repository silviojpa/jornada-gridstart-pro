# Atividade - S05T01V07: Desenhando seu Próprio Experimento de Chaos Engineering

**Objetivo:** Aplicar os três elementos de um experimento de Chaos Engineering (estado estável, falha controlada, rollback automático) a um ponto diferente do projeto-gridstart — não o `deploy.sh`, que já foi usado no vídeo.  
**Tipo:** Reflexão escrita + (opcional) execução real do `chaos_injector.sh` sobre o próprio `deploy.sh`  
**Tempo estimado:** 20-25 minutos  
**Entrega:** Texto estruturado descrevendo o experimento + (opcional) saída real do script

---

## Pré-requisitos

* Ter assistido S05T01V07 (este vídeo).
* Ter `scripts/deploy.sh` e `scripts/feedback_amplifier.sh` (S05T01V05) do projeto-gridstart - ou, se ainda não tiver, descrever o que esperaria ver.
* *Opcional, mas recomendado:* ter rodado o `chaos_injector.sh` (ver `S05_T01_V07_PASSO_A_PASSO_COMANDOS.md`) sobre o `deploy.sh` para sentir o experimento na prática antes de desenhar um novo.

---

## Parte 1 - Escolher o ponto do experimento

Escolha um ponto do projeto-gridstart diferente do `deploy.sh` para um experimento hipotético (ex: `backup.sh`, `monitorar.sh`, o próprio `git push`, ou outro script que você já tenha).

> [Seu ponto escolhido aqui]

---

## Parte 2 - Estado estável

Descreva como você sabe, hoje, que esse ponto está funcionando bem. Que sinal, log ou comportamento te diz "está tudo certo" antes de qualquer experimento?

> [Sua descrição aqui]

---

## Parte 3 - Falha controlada

Descreva a falha que você injetaria: o que exatamente mudaria, por quanto tempo, e por que o *blast radius* (raio de impacto) dela é pequeno e conhecido (ou seja, por que ela não arrisca o projeto inteiro).

> [Sua descrição aqui]

---

## Parte 4 - Rollback

Descreva como o sistema voltaria ao normal ao final do experimento manual (um comando que você roda) ou automático (como o `trap` do `chaos_injector.sh`).

> [Sua descrição aqui]

---

## Parte 5 - Execução real (opcional)

Se você rodou o `chaos_injector.sh` de verdade sobre o `deploy.sh`, cole aqui o resultado: a hipótese do vídeo se confirmou no seu projeto?

> [Cole aqui a saída real, ou descreva o que esperaria ver]

---

## Entrega

* **Parte 1:** ponto do experimento, diferente do `deploy.sh`
* **Parte 2:** estado estável descrito de forma específica
* **Parte 3:** falha controlada, com *blast radius* justificado
* **Parte 4:** rollback descrito (manual ou automático)
* **Parte 5:** execução real ou descrição do esperado

*Gabarito (critérios de avaliação) disponível em `S05_T01_V07_GABARITO.md`.*
