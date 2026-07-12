# Atividade Teórica - S06T01V04: Cálculo de Economia com Auto Scaling

> "Elasticidade não é mágica. É matemática."

---

## CENÁRIO 1: E-COMMERCE SEM ELASTICIDADE

### Pergunta 1a:
Quantos servidores você precisa CONSTANTEMENTE para suportar 200.000 requisições/dia sem elasticidade? (Assuma overhead 3x para segurança).

> **Sua resposta:** 
> [Pergunta 1a: De acordo com o cálculo de segurança operacional fornecido no enunciado do cenário fictício, você precisa de 2 servidores operando constantemente.]

### Pergunta 1b:
Qual é o custo mensal SEM elasticidade?
*   **Fórmula:** servidores x horas/mês x $/hora
*   **Assuma:** 1 mês = 730 horas

> **Sua resposta:** 
> [Pergunta 1b: R$ 146,00.
> Cálculo: 2 servidores x 730 horas x R$ 0,10/hora = R$ 146,00. ]

---

## CENÁRIO 2: E-COMMERCE COM PADRÃO DE DEMANDA REAL

### Pergunta 2a:
Com elasticidade, quantos servidores você manteria em cada período? (Deixe 20% overhead de segurança em TODOS os períodos. Cada servidor processa 100 req/s).
*   Horário comercial (8h-18h): ? servidores
*   Pós-comercial (18h-22h): ? servidores
*   Madrugada (22h-8h): ? servidores
*   Black Friday (1 dia): ? servidores

> **Sua resposta:** 
> [Pergunta 2a: Como cada servidor aguenta 100 req/s, todas as médias calculadas para os períodos normais (5 req/s, 5,2 req/s e 2,5 req/s) e para a Black Friday (13,9 req/s) ficam muito abaixo de 100 req/s, mesmo aplicando os 20% de overhead. Portanto, o mínimo necessário para manter o sistema funcional é:]

````
Horário comercial: 1 servidor  
Pós-comercial: 1 servidor  
Madrugada: 1 servidor  
Black Friday (1 dia): 1 servidor ]
````


### Pergunta 2b:
Calcule o custo mensal COM elasticidade:

> **Sua resposta:** 
> *   **Horário comercial:** ? servidores x 10h x 20 dias x R$ 0.10/h = R$ 20,00 
> *   **Pós-comercial:** ? servidores x 4h x 20 dias x R$ 0.10/h = R$ 8,00
> *   **Madrugada:** ? servidores x 10h x 20 dias x R$ 0.10/h = R$ 20,00
> *   **Black Friday:** ? servidores x 24h x 1 dia x R$ 0.10/h = R$ 2,40
> *   **Total:** R$ 20 + 8 + 20 + 2,40 = R$ 50,40

### Pergunta 2c:
Qual é a economia mensal? E o percentual de economia?

> **Sua resposta:**  
> *   **Economia absoluta (R$):** [Economia absoluta (R$): R$ 95,60 (Custo Sem Elasticidade de R$ 146,00 $-$ Custo Com Elasticidade de R$ 50,40). ]  
> *   **Percentual de economia (%):** [Percentual de economia (%): 65,48% (95,60 / 146,00 x 100)]

---

## CENÁRIO 3: AUTO SCALING E MÉTRICAS

### Pergunta 3a:
Em qual HORÁRIO o Auto Scaling Group vai disparar o primeiro scale-up? Justifique. (Regra: CPU > 70% por 2 min consecutivos).

> **Sua resposta:** 
> [Pergunta 3a: O gatilho de scale-up será disparado exatamente às 11:07. O histórico indica que o pico súbito começou às 11:00 e ultrapassou a marca de 70% às 11:05. Como a regra exige que a CPU permaneça acima de 70% por 2 minutos consecutivos, o tempo de validação se completa às 11:07. Nota: O novo servidor estará pronto para receber tráfego às 11:09 devido aos 2 minutos de boot da máquina.]

### Pergunta 3b:
A partir de que HORÁRIO o Auto Scaling vai disparar o primeiro scale-down? (Regra: CPU < 30% por 5 min consecutivos).

> **Sua resposta:** 
> [Pergunta 3b: O gatilho de scale-down será disparado às 20:05. A Black Friday acaba às 18:00, mas a CPU cai apenas para 35% (o que ainda é maior que o limite de 30%). O tráfego só cai para 15% (ficando abaixo dos 30% estipulados) a partir das 20:00. Como a regra exige 5 minutos consecutivos abaixo de 30%, o primeiro evento de redução ocorre às 20:05.]

### Pergunta 3c:
Quantos servidores você terá no máximo durante esse dia de Black Friday? Por quê? (Considere o teto de Max=20).

> **Sua resposta:** 
> [Pergunta 3c: Você terá 3 servidores no máximo. O grupo começa com o valor desejável de 2 servidores. Durante o período de pico (12:00 às 18:00), a CPU média se estabilizou em 72%, o que continua acima do limite de 70%. Passados os 5 minutos de cooldown do primeiro disparo, a CPU continuou alta, forçando o Auto Scaling a adicionar mais 1 servidor, totalizando 3. Como a carga se estabilizou em torno de 72% com essa nova capacidade dividida, a métrica média de CPU caiu para baixo do limite de disparo, interrompendo novas escaladas muito antes de raspar no teto máximo de 20 máquinas.]

### Pergunta 3d:
Qual é o TRADE-OFF de usar Auto Scaling? Ou seja, o que você perde?

> **Sua resposta:** 
> [Pergunta 3d: O principal trade-off é aceitar uma janela temporária de latência ou lentidão (gargalo) e o aumento da complexidade arquitetural. Como o gatilho de escala leva tempo para validar a métrica (2 minutos) e a nova instância demora mais um tempo para ligar e passar pelo health check (2 minutos), o sistema passa por um breve período de sobrecarga onde os usuários ativos podem experimentar lentidão até que o reforço de infraestrutura entre em produção.]
