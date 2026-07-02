# Atividade - Monólito ou Microsserviços? O Diagnóstico Final

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar o critério de decisão visto no vídeo — dor real medida, custo de coordenação compensado e maturidade do time a um cenário fictício, decidindo se um sistema deveria migrar para microsserviços agora, mais pra frente, ou permanecer monólito.  
**Tipo:** Diagnóstico + reflexão escrita — sem terminal, sem comando real.  
**Tempo estimado:** 10-15 minutos  
**Entrega:** Respostas escritas às três questões abaixo.

---

## Contexto (cenário fictício)

A TrilhaFit é um aplicativo de acompanhamento de treinos, com cerca de 50 mil usuários ativos. O sistema inteiro — cadastro de usuário, registro de treino, geração de relatório de evolução e cobrança de assinatura — roda hoje como um monólito bem escrito, com deploy único, mantido por um time de 4 desenvolvedores.

O fundador da TrilhaFit voltou de um evento de tecnologia entusiasmado: *"toda empresa grande que eu vi lá usa microsserviços. A gente precisa migrar pra isso se quiser ser uma empresa séria."* Não existe, até agora, nenhum registro de lentidão, queda ou reclamação de usuário relacionado a desempenho.

---

## Questões

### 1. A moda ou a dor?
Usando o primeiro critério do vídeo — *"você tem uma dor real, já medida, ou é uma suposição de que vai precisar um dia?"* — avalie o pedido do fundador da TrilhaFit. Existe, no cenário descrito, alguma evidência medida que justifique migrar para microsserviços agora? Compare a situação da TrilhaFit com os dois casos reais do vídeo (Amazon Prime Video e Segment): o que esses dois casos tinham que a TrilhaFit, no momento descrito, não tem?
- IA
> [Não existe nenhuma evidência ou dado medido no cenário atual que justifique a migração. O pedido do fundador é puramente baseado na "moda" ou no "DevOps de palco", gerado pelo entusiasmo de ver grandes empresas usando a arquitetura. A grande diferença é que os casos da Amazon Prime Video e da Segment tinham dores e gargalos reais de escala e custo medidos em produção (como faturas exorbitantes de rede/infraestrutura ou problemas severos de acoplamento que travavam as entregas). A TrilhaFit tem um monólito bem escrito, sem lentidão e sem reclamações. Migrar agora seria adicionar uma complexidade operacional gigantesca sem nenhum ganho real para o usuário ou para o negócio.]

### 2. E se a dor aparecesse?
Agora imagine que, três meses depois, o time de Operações da TrilhaFit mediu, de fato, um problema concreto: o módulo de geração de relatório de evolução — que faz um processamento pesado de dados de treino — trava o sistema inteiro por cerca de oito minutos, duas vezes por semana, sempre no horário de pico de uso (segunda-feira e quinta-feira à noite). Isso já gerou reclamação registrada de usuários nesses horários.

Usando o segundo critério do vídeo — *"o ganho compensa o custo de coordenar N peças em vez de uma?"* — essa nova informação muda sua resposta da questão 1? Qual parte específica do sistema, e só ela, passaria a ser candidata real à extração?

> [Sim, essa nova informação muda o diagnóstico. Agora há uma dor real, recorrente, medida com métricas claras (8 minutos de travamento total, duas vezes por semana) e com impacto direto na experiência do cliente. O ganho de isolar o problema passa a compensar o custo de coordenação. No entanto, em vez de quebrar o sistema todo, apenas o módulo de geração de relatório de evolução passa a ser o candidato a extração. O resto do sistema (cadastro, treinos, cobrança) deve continuar rodando intacto dentro do monólito para não ter o custo de arquitetura.]

### 3. Dor medida, mas o time pode sustentar?
Mesmo com a dor medida da questão 2, a TrilhaFit continua com apenas 4 desenvolvedores, nenhum deles dedicado a operações de infraestrutura. Usando o terceiro critério do vídeo — *"seu time tem o tamanho e a maturidade operacional pra sustentar isso?"* — isso muda a forma como a extração do módulo de relatório deveria ser feita? Proponha um caminho de migração para a TrilhaFit que leve em conta essa limitação de time, sem recomendar quebrar o sistema inteiro em microsserviços de uma vez.

> [O caminho ideal de migração é incremental: o time deve manter o monólito centralizado e extrair única e exclusivamente o módulo de relatórios, transformando em um trabalhador em segundo plano assíncrono ou uma função serverless isolada. O monólito apenas enfileira o pedido de relatório, liberando o sistema principal para os usuários, enquanto esse único componente isolado processa o peso de dados de forma independente.]
---

**Dica de pit stop:** A pergunta central de hoje não é "monólito ou microsserviços é melhor?" — é "o que mudou, de fato, entre a questão 1 e a questão 2, pra justificar uma decisão diferente?". Releia o trecho do vídeo sobre "comece simples, monólito bem escrito, e só extraia um serviço de verdade quando você tiver a dor medida apontando exatamente pra aquele pedaço" antes de responder à questão 3.
