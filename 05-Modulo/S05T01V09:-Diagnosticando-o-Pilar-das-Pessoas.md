# Atividade S05T01V09: Diagnosticando o Pilar das Pessoas

**Objetivo:** Analisar o cenário de uma empresa fictícia que investiu em ferramenta de ponta mas continua travada, e aplicar os três conceitos do vídeo — falácia da compra de cultura, Lei de Conway, liderança que blinda vs. microgerencia para diagnosticar o problema real e propor uma saída.  
**Tipo:** Reflexão escrita — sem terminal, sem código  
**Tempo estimado:** 15-20 minutos  
**Entrega:** Documento estruturado em Markdown ou texto, com as 4 respostas pedidas

---

## O Cenário: TechNorte

A TechNorte é uma empresa de médio porte que vende software de gestão para varejo. Há oito meses, o time de liderança técnica fez um investimento grande: assinou a stack mais moderna do mercado — Kubernetes gerenciado, Terraform para toda a infraestrutura, pipeline de CI/CD completo e uma ferramenta de observabilidade de ponta.

A expectativa era clara, registrada na ata da reunião de aprovação do investimento: *"com essa stack, o time vai colaborar melhor e o tempo de entrega vai cair."*

Seis meses depois, o tempo entre "pedido de mudança" e "mudança em produção" nem mudou. A empresa continua organizada em três departamentos: Desenvolvimento, Operações e Banco de Dados — cada um com seu próprio gerente, sua própria fila de chamados, e reuniões separadas. Toda mudança de aplicação que precisa de uma alteração de infraestrutura ainda abre um chamado formal pro departamento de Operações, que processa os chamados por ordem de chegada, em lotes semanais.

O time de Desenvolvimento reclama que "a infra é lenta". O time de Operações reclama que "Dev manda mudança sem avisar e quebra coisa em produção". Ninguém do time de Desenvolvimento participa de decisão de infraestrutura, e ninguém do time de Operações participa de decisão de arquitetura de aplicação.

A gerência está considerando contratar um líder técnico novo para "resolver a cultura do time".

---

## Parte 1 - Identifique a falácia da compra de cultura

Releia o cenário e copie a frase exata que mostra a expectativa da falácia da compra de cultura. Em até 4 linhas, explique por que essa expectativa não se confirmou, usando o conceito do vídeo.

> **Frase citada:** [O time de Desenvolvimento reclama que "a infra é lenta". O time de Operações reclama que "Dev manda
mudança sem avisar e quebra coisa em produção".]

> **Explicação:** [A questão desse muro entres os setores que usa a justificativa inversa como exemplo de apontaro erro, só traz um problema que estende sem solução no ao todo, princio a ser feito e da um start na boa comunição e participação de cada lider nas mundanças.   ]

---

## Parte 2 - Aplique a Lei de Conway

Usando a Lei de Conway, explique especificamente por que a estrutura atual da TechNorte (três departamentos separados, fila de chamado entre eles) está se refletindo no problema descrito no cenário. Não vale apenas repetir a definição da lei — aponte a relação concreta entre a estrutura organizacional e o sintoma relatado.

> [No meu ponto de vista separar as responsabilidades em cada setor, mas trazer uma boa comunição entre elas, usar metodoligas agiles e processos em cada, fazer com que os lideres participem da mudanças e finalizar o mes com o feedback do mes ]

---

## Parte 3 - Proponha uma reorganização (stream-aligned team)

Usando o conceito de *stream-aligned team* (Team Topologies), proponha como a TechNorte poderia reorganizar pelo menos uma parte do time. Nomeie pelo menos três disciplinas diferentes que estariam dentro desse novo time, e diga qual fluxo de valor de ponta a ponta esse time passaria a ser dono.

> **Disciplinas no novo time:** [liste pelo menos 3] - Comunicação, Acompanhamento e Observabilidade 
> **Fluxo de valor de ponta a ponta:** [descreva] - Usar esses três pilares inicialmente vai trazer um nova remodelagem na conexão dos setores ao ponto de diminuir as justificativas negativas de cada equipe e criar a dinâmica no fluxo.

---

## Parte 4 - O papel do novo líder técnico

A gerência quer contratar um líder técnico para "resolver a cultura". Descreva:

1. Uma ação concreta de blindagem que esse líder deveria tomar (não pode ser genérica, tipo "dar apoio ao time" — tem que ser uma ação específica).
2. Um exemplo claro de microgestão que esse líder deve evitar, ligado ao cenário da TechNorte.

> **Ação de blindagem:** [Introduzir na equipe a visão que agora o processo vai ter uma liderança para absorver as atividades e passada de forma dinamica e sendo esperado o apoio do time de cada setor. Organizar com lideress que o resultado positivos terá um retorno positivo de alguma formaa e
> o negativo vai ser estudado e passado de uma forma que não vire monstro punitivo. ]  
> **Exemplo de microgestão a evitar:** [Deixar que pessoas agarre certas responsabilidades como forma de justificar importancias e não monopolizar fluxo ou aceite de atividades no ao todo sendo passada pelo lider e deixar as equipe participar do que é ideial ou melhor para resdultado. ]

---

## Entrega

* **Parte 1:** frase citada + explicação da falácia
* **Parte 2:** aplicação específica da Lei de Conway ao cenário
* **Parte 3:** proposta de *stream-aligned team* com 3+ disciplinas e fluxo de ponta a ponta nomeado
* **Parte 4:** ação de blindagem concreta + exemplo de microgestão a evitar

*Gabarito (critérios de avaliação) disponível em `S05_T01_V09_GABARITO.md`.*
