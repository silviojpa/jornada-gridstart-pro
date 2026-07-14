# Atividade - S06T02V03: Instâncias Reservadas e Savings Plans
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 13 de julho de 2026  

---

## Parte 1 - Questões Conceituais

### 1. Qual é a diferença fundamental entre o modelo On-Demand e um Savings Plan?
> **Sua resposta:** [Diferença Fundamental: O modelo On-Demand cobra exclusivamente por segundo ou hora de recurso ativo e provisionado, permitindo que você desligue ou delete os recursos a qualquer momento sem penalidades. Já o Savings Plan exige que você assuma um compromisso contratual de consumo de computação (mensurado em $/hora) por 1 ou 3 anos; em troca desse compromisso financeiro ininterrupto, o provedor concede descontos agressivos sobre a tarifa padrão de uso.]

### 2. ERP Financeiro estável rodando em m5.2xlarge na sa-east-1 sem previsão de mudança: Standard RI ou Compute Savings Plan? Justifique.
> **Sua resposta:** [Recomendação: Standard Reserved Instance (RI). Como o sistema de ERP opera de forma ininterrupta (24/7/365), utiliza sempre o mesmo tipo de máquina (m5.2xlarge), na mesma região (sa-east-1) e não há qualquer previsão de modificação estrutural, a Standard RI é ideal porque oferece a taxa máxima de desconto possível para esse cenário de imutabilidade, além de garantir a reserva de capacidade física no datacenter.]

### 3. Por que os Compute Savings Plans oferecem um desconto menor do que os EC2 Instance Savings Plans?
> **Sua resposta:** [Explicação: O desconto é menor porque o Compute Savings Plan oferece flexibilidade máxima. Ele permite que você mude a família de instâncias (ex: de m5 para c5), o tamanho da máquina, o sistema operacional, a região geográfica e até mesmo o modelo de computação (migrando de máquinas virtuais EC2 para containers Fargate ou funções serverless Lambda) sem perder o desconto.]

### 4. Savings Plan Compute de $3,00/hora em um cenário de consumo médio de $4,50/hora:
*   **a) O desconto do Savings Plan se aplica a toda a fatura?** [Não. O desconto do Savings Plan de $\$3,00/\text{hora}$ será aplicado estritamente sobre a fatura de computação até o limite exato de consumo de $\$3,00$ por hora contratada.]
*   **b) O que acontece com os $1,50/hora excedentes?** [Os $\$1,50/\text{hora}$ excedentes serão cobrados e faturados automaticamente na modalidade On-Demand (tarifa cheia sem desconto).]

### 5. A ausência de Savings Plans e instâncias Spot no MagaluCloud é uma desvantagem para quem opera exclusivamente no Brasil? Justifique.
> **Sua resposta:** [Para empresas nacionais operando exclusivamente no Brasil, a MagaluCloud tem como principal atrativo comercial a cobrança e o faturamento fixados 100% em reais BRL. Na AWS, mesmo utilizando descontos de Savings Plans ou Spot, os valores de faturamento são baseados em dólar USD, deixando a empresa vulnerável à severas mudanças do câmbio.]

---

## Parte 2 - Cenários de Decisão

### Cenário A: Startup com aplicativo móvel recente, crescimento incerto e adoção futura de Lambda.
*   **Modelo indicado:** [On-Demand]
*   **Justificativa:** [O crescimento e a infraestrutura são altamente voláteis e incertos no curto prazo. Comprometer contratualmente com Savings Plans ou instâncias reservadas agora trará o risco de subdimensionamento ou desperdício de uso antes de o produto encontrar estabilidade no mercado.]

### Cenário B: Banco com r6i.4xlarge para banco de dados produtivo estável há 2 anos, contrato de 3 anos e caixa para pagamento antecipado.
*   **Modelo indicado:** [Standard Reserved Instance]
*   **Justificativa:** [O workload do banco de dados está consolidado, roda há 2 anos no mesmo tipo de instância e tem estabilidade confirmada por mais 3 anos. Como a empresa tem capital em caixa para pagar adiantado, a Standard RI garante a maior porcentagem de desconto disponível no mercado e assegura a capacidade física do banco.]

### Cenário C: E-commerce com workloads mistos (EC2, ECS Fargate, Lambda), tamanho instável e alternância entre famílias m5 e c5.
*   **Modelo indicado:** [Compute Savings Plan]
*   **Justificativa:** [O ambiente utiliza uma mistura de diferentes serviços de computação (EC2, ECS Fargate e Lambda) e sofre alterações de famílias de instâncias (m5 e c5) pelo time de DevOps. O Compute Savings Plan aplicará o desconto automaticamente a todas essas tecnologias e mudanças de infraestrutura sem exigir intervenções manuais de conversão de contratos.]

### Cenário D: Empresa de logística com orçamento estrito em reais, avessa à variação cambial e com ambiente estável.
*   **Modelo indicado (provedor + modelo):** [MagaluCloud (On-Demand / Modelo de Preço Fixo)]
*   **Justificativa:** [A empresa necessita de total previsibilidade contábil sem exposição cambial ao dólar e prioriza a simplicidade de operação de servidores estáveis. A MagaluCloud entrega faturamento local em reais e elimina a necessidade de gerenciar complexos contratos de fidelidade de longo prazo das clouds estrangeiras.]

---

## Parte 3 - Cálculo de Economia (5 instâncias m5.xlarge)

*   **a) Custo mensal total no modelo On-Demand:** [Custo mensal total On-Demand: $\$691,20/\text{mês}$.Cálculo: $5 \text{ instâncias} \times \$0,192/\text{hora} \times 730 \text{ horas} = \$691,20$.]
*   **b) Custo mensal total com Standard RI (All Upfront, 40% de desconto):** [Custo mensal total com Standard RI (40% desc.): $\$414,72/\text{mês}$.Cálculo: $\$691,20 \times (1 - 0,40) = \$414,72$.]
*   **c) Custo mensal total com Compute Savings Plan (33% de desconto):** [Custo mensal total com Compute Savings Plan (33% desc.): $\$463,10/\text{mês}$.Cálculo: $\$691,20 \times (1 - 0,33) = \$463,104$.]
*   **d) Economia anual absoluta entre On-Demand e a Standard RI:** [Economia anual entre On-Demand e Standard RI: $\$3.317,76/\text{ano}$.Cálculo: $(\$691,20 - \$414,72) \times 12 \text{ meses} = \$276,48/\text{mês} \times 12 \text{ meses} = \$3.317,76$.]
*   **e) Análise final do workload: Standard RI ou Compute Savings Plan? Justifique.** [Análise do Workload: Justifica a Standard RI. Como o comportamento de uso do servidor se provou estritamente estático (mesmo tipo de instância, mesma região geográfica e sem previsão de modificações), não há necessidade de pagar o prêmio de flexibilidade exigido pelo Compute Savings Plan. Optar pela Standard RI entrega a maior economia de capital disponível (7% a mais de desconto, resultando em mais de $\$580,00$ de economia adicional acumulada no ano em relação ao Savings Plan).]

---

## Parte 4 - Exploração no Console AWS
> **Sua resposta:** []
