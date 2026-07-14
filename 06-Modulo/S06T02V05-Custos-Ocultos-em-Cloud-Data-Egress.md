# Atividade - S06T02V05: Custos Ocultos em Cloud Data Egress e Transferência de Dados
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 13 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta |
| :--- | :---: |
| **Questão 1: Custos de Ingress vs. Egress** | **c** |
| **Questão 2: Impacto financeiro do tráfego inter-AZ** | **c** |
| **Questão 3: Conceito de lock-in por Egress** | **b** |
| **Questão 4: Estratégia de redução de custo de arquivos estáticos** | **c** |
| **Questão 5: Ferramenta de alertas automáticos por anomalias de custo** | **b** |

---

## PARTE 2 - Análise de Cenário

### Cenário A: Fatura Surpresa (TechNova)

#### Pergunta 1: O que gerou o custo de US$ 2.300 e por que ele aparece separado do custo das instâncias?
> **Sua resposta:** [O custo de US$ 2.300 foi gerado pelo tráfego de saída de dados para a internet (Data Transfer Out) decorrente do consumo dos vídeos pelos usuários finais via streaming. Ele aparece separado das instâncias EC2 porque a AWS separa a cobrança de computação (tempo de execução da CPU/RAM por hora) da cobrança de vazão de rede física (network throughput), permitindo identificar de forma isolada quanto o tráfego de rede está pesando no orçamento da aplicação.]

#### Pergunta 2: Sugira duas ações concretas para reduzir esse custo no próximo mês.
> **Sua resposta:** [Implementação do Amazon CloudFront: Configurar o CloudFront como CDN na frente do bucket S3 que armazena os vídeos. O tráfego de saída do CloudFront para a internet é mais barato do que o tráfego direto do S3/EC2, e o cache nas Edge Locations evita transferências repetidas de dados a partir da origem.]

---

### Cenário B: Arquitetura Multi-AZ (E-commerce)

#### Pergunta: Identifique o problema de custo dessa arquitetura e sugira uma melhoria para reduzir custos mantendo a resiliência.
> **Sua resposta:** [Problema de Custo: A arquitetura possui um alto custo invisível de transferência de dados inter-AZ. Cada requisição de compra precisa cruzar os limites de diferentes AZs repetidamente em sequência (us-east-1a $\rightarrow$ us-east-1b $\rightarrow$ us-east-1c $\rightarrow$ us-east-1b), gerando múltiplas cobranças de US$ 0,01 por GB em tráfego de saída e entrada no nível de rede para cada etapa.]

---

## PARTE 3 - Questão Prática (Cálculo de Egress no S3)

*   **1. Valor total estimado de Egress para 5 TB/mês na us-east-1:** [A AWS oferece o primeiro 1 GB gratuito. A faixa de preço até 10 TB custa US$ 0,09 por GB. / $$\text{Total (5 TB)} = (5.120 \text{ GB} - 1 \text{ GB}) \times \text{US\$ } 0,09 = \mathbf{\text{US\$ } 460,71/\text{mês}}$$]
*   **2. Comparação com o custo para 50 TB/mês (análise de tiers):** [A precificação do Egress de dados possui tiers progressivos (quanto mais você usa, menor é o valor do GB excedente):  Primeiro 1 GB: Gratuito  Próximos 9,999 TB (até 10 TB no total): US$ 0,09 / GB  Próximos 40 TB (até 50 TB no total): US$ 0,085 / GB] > [Cálculo de 50 TB:Tier 1 (até 10 TB): $10.239 \text{ GB} \times \text{US\$ } 0,09 = \text{US\$ } 921,51$  Tier 2 (próximos 40 TB): $40.960 \text{ GB} \times \text{US\$ } 0,085 = \text{US\$ } 3.481,60$  Total (50 TB): $\$921,51 + \$3.481,60 = \mathbf{\text{US\$ } 4.403,11/\text{mês}}$]
*   **3. Diferença percentual de preço por GB entre os dois volumes:** []
