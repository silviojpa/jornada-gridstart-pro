# Atividade - S05T01V05: Desenhando o Loop de Feedback

[cite_start]**Objetivo:** Aplicar a Segunda Via ao próprio projeto-gridstart - identificar visualmente onde um sinal de feedback (Ops ➔ Dev) deveria existir no fluxo commit push deploy, e definir o conteúdo mínimo desse sinal para que ele seja útil e amplificado, não apenas mais um log silencioso[cite: 86, 87].  
[cite_start]**Tipo:** Reflexão visual + escrita curta - sem comando novo de terminal como entrega obrigatória (rodar o `feedback_amplifier.sh` é opcional e ilustrativo) [cite: 88]  
**Tempo estimado:** 20-25 minutos  
[cite_start]**Entrega:** Diagrama anotado (desenho ou print com marcação) + respostas curtas [cite: 88]

---

## Pré-requisitos

* [cite_start]Ter assistido S05T01V05 (este vídeo)[cite: 90].
* [cite_start]Ter o diagrama do fluxo commit push deploy do projeto-gridstart (já usado em S05T01V03/V04) à mão, ou recriá-lo rapidamente[cite: 91, 92, 93].
* [cite_start]*Opcional, mas recomendado:* ter rodado o `feedback_amplifier.sh` (ver `S05_T01_V05_PASSO_A_PASSO_COMANDOS.md`) para ver o alerta real[cite: 94, 95].

---

## Parte 1 - Marcar o ponto do sinal de feedback

[cite_start]Desenhe (no papel, num editor de imagem, ou em texto estruturado tipo diagrama ASCII) as três etapas do fluxo `commit` ➔ `git push` ➔ `scripts/deploy.sh` e marque visualmente em qual ponto a Operação deveria mandar um sinal de volta para o Dev[cite: 96, 97, 98].
````
> [cite_start][Descreva ou anexe seu diagrama aqui] [cite: 99]
+------------+            +------------+            +---------------------+
| 1. Commit  | ---------> | 2. git push| ---------> | 3. scripts/deploy.sh| (Ops)
+------------+            +------------+            +---------------------+
      ^                                                        |
      |                                                        |
      +================= [ SINAL DE FEEDBACK ] ================+
                   (Alerta automático/Loop de retorno)
````
[cite_start]Justifique em 1-2 frases por que esse é o ponto certo (ou os pontos certos, se você marcar mais de um)[cite: 100].

> [cite_start][Sua justificativa aqui] [cite: 101]
> O sinal de feedback deve partir imediatamente após a execução do scripts/deploy.sh (ou durante a falha do mesmo) de volta para o estágio inicial de desenvolvimento (Commit). Isso garante que qualquer erro de infraestrutura, ambiente ou deploy seja detetado e comunicado ao Dev em segundos, permitindo uma correção rápida antes que o problema se propague ou permaneça silencioso na Operação.
---

## Parte 2 - O conteúdo mínimo do sinal

[cite_start]Um alerta vazio ("algo deu errado") não ajuda ninguém a agir rápido[cite: 103]. [cite_start]Com base no que o `feedback_amplifier.sh` registra (timestamp, status, mensagem), escreva em 3-5 frases o que um sinal de feedback precisa carregar, no mínimo, para ser útil sem virar um relatório longo que ninguém lê[cite: 104].

> [cite_start][Sua resposta aqui] [cite: 105]
> Na minha opnição o script deve trazer de forma concisa os pontoa onde realmente está causando esse alerta ou o ponto inicial que traz o efeito cascata do problema.

---

## Parte 3 - Rodando o sinal de verdade (opcional)

[cite_start]Se você rodou o `feedback_amplifier.sh` (Bloco 2 e, se quiser, o Bloco 3 do passo a passo), cole aqui a linha que apareceu no `feedback_log.csv`[cite: 107, 108]:

> [cite_start][Cole aqui o resultado, se rodou] [cite: 109]

[cite_start]Se não rodou, descreva o que você espera que apareceria se o `scripts/deploy.sh` do seu projeto falhasse agora[cite: 110].

> [cite_start][Sua resposta aqui] [cite: 111]

---

## Parte 4 - Uma verificação para "shiftar pra esquerda"

[cite_start]A aula apresentou o *Shift-Left*: mover testes, segurança e qualidade para mais perto da origem (commit), em vez de só descobrir problemas no fim da esteira[cite: 112, 113].

[cite_start]Identifique uma verificação que hoje só é feita tarde no seu fluxo (ou nem é feita) e que poderia ser movida para mais perto do commit[cite: 114]. [cite_start]Diga o que ela verifica e por que faz sentido movê-la[cite: 115].

> [cite_start][Sua resposta aqui] [cite: 116]
> A verificação com testes na nova funcionalidade no tamplate main so front e relatar antes do push e resolver na medida do possivel e depois devolver para p fluxo até o deploy da nova versão.

---

## Parte 5 - Pergunta de reflexão

[cite_start]A aula comparou a Segunda Via ao rádio entre o box e o carro, sempre ligado[cite: 117, 119]. 

[cite_start]Pensando no seu próprio fluxo: hoje, se o `deploy.sh` falhasse silenciosamente, quanto tempo (estimando) levaria até alguém perceber - e o que mudaria se esse tempo caísse para segundos[cite: 120]?

> [cite_start][Sua resposta aqui] [cite: 121]
> O tempo seria de pelo menos 2 dias,até o user final relatar o problema dedpois de tentativas sem sucesso, com isso sendo reslovido antes ou atpe segundo na prod, seria imperceptivel ao final user ou um carregar de page already fixed.  

---

## Entrega

* [cite_start]**Parte 1:** diagrama com o ponto do sinal de feedback marcado e justificado [cite: 123, 128]
* [cite_start]**Parte 2:** conteúdo mínimo do sinal, específico e objetivo [cite: 124, 128]
* [cite_start]**Parte 3:** resultado real ou esperado do `feedback_amplifier.sh` [cite: 125, 129]
* [cite_start]**Parte 4:** uma verificação concreta candidata a *Shift-Left* [cite: 126, 130]
* [cite_start]**Parte 5:** pergunta de reflexão [cite: 127, 131]

[cite_start]*Gabarito (critérios de avaliação) disponível em `S05_T01_V05_GABARITO.md`.* [cite: 132]
