# Atividade - S06T01V06: Latência e Edge Locations

> "Latência e Edge Locations: Entendendo a distribuição global de conteúdo"

---

## Questão 1 - Análise de Latência Atual

### (a) Qual é a latência aproximada que um usuário em Tóquio enfrenta ao requisitar um vídeo do seu servidor em São Paulo?
*   [ ] 5-10 ms
*   [ ] 25-50 ms
*   [ ] 100-150 ms
*   [X] 200-300 ms

### (b) Essa latência afeta igualmente conteúdo estático (imagens) e dinâmico (metadados)? Explique por quê.
> **Sua resposta:** 
> [Sua resposta aqui]

---

## Questão 2 - Solução com CDN

### (a) Se você colocasse uma CDN na frente de seu servidor, qual seria o impacto aproximado na latência para usuários na Austrália?
*   [ ] Nenhum - CDN só funciona pra conteúdo dinâmico
*   [ ] Redução leve: ~50 ms
*   [X] Redução significativa: ~5-15 ms (servido de Edge em Sydney)
*   [ ] Aumento — CDN adiciona overhead

### (b) Qual tipo de conteúdo você colocaria ATRÁS de uma CDN?
*   [X] Vídeos pré-gravados (80% do tráfego)
*   [ ] Metadados dinâmicos (20% do tráfego)
*   [ ] Ambos
*   [ ] Nenhum

---

## Questão 3 - Distribuição de Infraestrutura

### (a) Quais 2 regiões você escolheria? (Considere latência, custo e cobertura)
*   [ ] São Paulo + Singapura
*   [ ] São Paulo + Dublin
*   [X] São Paulo + Virginia (EUA)
*   [ ] Dublin + Singapura

### (b) Por que você não escolheria as outras opções?
> **Sua resposta:** 
> [Sua resposta aqui]

---

## Questão 4 - Custo vs. Latência

### (a) Qual plano você escolheria? Por quê?
> **Sua resposta:** 
> [Sua resposta aqui]

### (b) Qual métrica é mais importante pra sua aplicação: custo ou latência? Justifique.
> **Sua resposta:** 
> [Sua resposta aqui]

---

## Questão 5 - Conteúdo Dinâmico vs. Estático

### (a) Como você resolveria latência alta pra conteúdo dinâmico servido pra usuários na Ásia?
*   [ ] Adicionar outra CDN resolve tudo
*   [X] Colocar um servidor regional na Ásia (Singapura/Tóquio) pra servir dinâmico
*   [ ] Ignorar latência - é só 20%
*   [ ] Aceitar latência alta é o preço de conteúdo dinâmico

### (b) Qual é a estratégia completa pra seu caso?
> **Sua resposta:** 
> [Sua resposta aqui]
