# Atividade - S06T02V01: CapEx vs. OpEx e Modelos de Cobrança em Cloud
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 12 de julho de 2026  

---

## Parte 1 - Análise de Cenário

### 1. Custo operacional anual do Cenário A (apenas recorrentes):
> **Sua resposta:** [R$ 420.000,00 por ano /  Cálculo: R$ 35.000,00/mês x 12 meses. A depreciação é desconsiderada por ser um custo contábil não recorrente de caixa.]

### 2. Custo operacional anual do Cenário B (com migração diluída + egress):
> **Sua resposta:** [R$ 346.666,67 por ano.]

- Cálculo:
  - Baixa temporada (10 meses): 10 $\times$ R$ 18.000,00 = R$ 180.000,00
  - Alta temporada (2 meses): 2 $\times$ R$ 58.000,00 = R$ 116.000,00
  - Custo de Egress anual: 12 $\times$ R$ 2.000,00 = R$ 24.000,00
  - Migração diluída por ano (3 anos): R$ 80.000,00 / 3 = R$ 26.666,67
    - Total: R$ 180.000,00 + R$ 116.000,00 + R$ 24.000,00 + R$ 26.666,67 = R$ 346.666,67.

### 3. Qual cenário apresenta menor custo anual nos próximos 3 anos? Mostre o cálculo comparativo acumulado.
> **Sua resposta:**
- O Cenário B (Cloud) apresenta o menor custo.
- Cálculo de Acumulado em 3 anos:
  - Cenário A (On-premise): R$ 420.000,00 $\times$ 3 = R$ 1.260.000,00.
  - Cenário B (Cloud): R$ 346.666,67 $\times$ 3 = R$ 1.040.000,00 (ou R$ 180k + R$ 116k + R$ 24k) $\times$ 3 + R$ 80.000,00 integrais de migração.
  - Economia total para a empresa: R$ 220.000,00 em 3 anos a favor da migração para a Nuvem.

### 4. Qual é o risco financeiro oculto do Cenário A que não aparece diretamente no custo recorrente? (Até 3 linhas).

> **Sua resposta:**  [O risco reside no sufocamento físico de hardware e no custo de oportunidade. Como os servidores operam no limite máximo em novembro/dezembro (80% a 100%), qualquer crescimento inesperado de mercado exigirá um novo aporte massivo e imediato de CapEx (comprar novos servidores), cujo tempo de entrega e provisionamento lento pode fazer a empresa perder vendas no pico por falta de capacidade computacional.]

---

## Parte 2 - Classificação CapEx / OpEx

| # | Item | Classificação | Justificativa |
| :--- | :--- | :--- | :--- |
| **1** | Compra de 10 switches de rede por R$ 200.000 | [CapEx] | [Trata-se de um investimento inicial em ativos físicos de infraestrutura com valor depreciado a longo prazo] |
| **2** | Fatura mensal de R$ 30.000 da AWS | [OpEx] | [Despesa operacional baseada em consumo de serviços (utility computing), paga conforme o uso do período.] |
| **3** | Contrato de Reserved Instances por 3 anos na Azure (pagamento antecipado) | [CapEx] | [Embora seja nuvem, o pagamento antecipado integral transforma o custo em um ativo intangível de longo prazo a ser amortizado.] |
| **4** | Licença perpétua de software de banco de dados por R$ 150.000 | [CapEx] | [Gasto com a propriedade definitiva de um ativo de software corporativo sem recorrência operacional] |
| **5** | Assinatura mensal de R$ 5.000 de um serviço SaaS de monitoramento | [OpEx] | [Despesa recorrente de serviço que se mantém ativa somente durante o período de contratação e uso.] |
| **6** | Construção de sala-cofre para datacenter por R$ 500.000 | [CapEx] | [Investimento em infraestrutura civil fixa e melhoria de propriedades corporativas de longo prazo.] |
| **7** | Custo de R$ 4.000/mês com egress de dados no GCP | [OpEx] | [Custo operacional dinâmico gerado pela vazão e consumo real da infraestrutura de rede no mês.] |
| **8** | Aquisição de servidor físico para ambiente de testes por R$ 80.000 | [CapEx] | [Aquisição de hardware físico permanente corporativo, independentemente de sua finalidade ser para testes ou produção.] |

---

## Parte 3 - Análise Crítica

### Questão 3.1: Análise técnica sobre a afirmação "Cloud é sempre melhor economicamente" no setor de saúde.
> **Sua resposta:** [Não concordo integralmente com a afirmação. Dizer que a nuvem é "sempre melhor economicamente" ignora as particularidades de conformidade e a arquitetura de dados legada do setor de saúde. Hospitais e clínicas lidam com registros médicos altamente sensíveis que, dependendo da regulação (como a LGPD no Brasil), exigem um nível de isolamento de dados rigoroso.]
IA ANSWER CONTRIBUTED
> [Para atender a esses requisitos na nuvem pública, muitas vezes é necessário contratar instâncias dedicadas (Dedicated Hosts) ou conexões de rede privadas e blindadas, componentes que possuem um custo fixo extremamente elevado que pode invalidar a economia esperada. Além disso, sistemas médicos conectados a equipamentos de suporte à vida em tempo real exigem latência próxima de zero, algo que um servidor local (On-premise) resolve nativamente. Migrar esse processamento crítico para a nuvem sem uma CDN ou Edge Locations robustas aumentaria a latência e o risco de indisponibilidade. Se o hospital já possui um datacenter próprio amortizado e funcional, o custo operacional de manter as cargas estáveis localmente pode ser menor do que pagar o tráfego de saída (Egress) massivo de imagens médicas pesadas (como tomografias e ressonâncias) que médicos consultam localmente a todo momento.]

### Questão 3.2: Diagnóstico técnico do crescimento de 200% da fatura sem aumento de usuários.
> **Sua resposta:** [O modelo de cobrança OpEx da nuvem é baseado no consumo. Se a fatura cresceu 200% sem o aumento proporcional de usuários, isso indica que o consumo de recursos computacionais internos disparou descontroladamente devido a desperdícios técnicos ou falha de automação.]
> 

---

## Parte 4 - Framework de Decisão (Cenário Logística)

### 1. Análise usando as 4 Perguntas do Framework:
*   **Pergunta 1:** [Qual é o padrão da carga de trabalho? Ela é altamente variável e sazonal. O sistema opera em alta atividade em horário comercial de dias úteis (50.000 eventos/hora) e cai para um estado quase ocioso nos fins de semana (500 eventos/hora), representando uma variação de 100 para 1 na demanda.]
*   **Pergunta 2:** [Qual é a capacidade de gerenciamento da equipe? Extremamente limitada. A equipe possui apenas 2 profissionais de infraestrutura para gerenciar o hardware, o sistema operacional, a rede física e os backups de 8 servidores, gerando uma sobrecarga operacional perigosa.]
*   **Pergunta 3:** [Qual é o ciclo de vida e depreciação dos ativos atuais? O hardware atual possui 6 anos de uso contínuo. Em termos de tecnologia, esses servidores físicos já ultrapassaram seu ciclo padrão de vida útil (geralmente de 3 a 5 anos), encontrando-se obsoletos e propensos a falhas físicas iminentes, exigindo substituição (CapEx).]
*   **Pergunta 4:** [O negócio se beneficia de agilidade e experimentação? Sim. Como o rastreamento logístico está sujeito a variações de rotas, novas frotas e integrações de APIs com clientes externos, delegar o gerenciamento da infraestrutura base para um provedor cloud permite que o time foque na estabilidade do software de entregas.]

### 2. Recomendação Final e Justificativa Técnica:
> **Sua resposta:** [Justificativa: Como o sistema opera em um padrão previsível de segunda a sexta, a empresa deve contratar Instâncias Reservadas (Reserved Instances) cobrindo apenas a capacidade mínima permanente necessária para sustentar a base estável do serviço. Para absorver a explosão de tráfego de 50.000 eventos/hora durante a semana, deve-se configurar grupos de Auto Scaling On-Demand, que provisionarão servidores elásticos complementares de segunda a sexta e os desligarão automaticamente no fim de semana quando o tráfego despencar para 500 eventos/hora.]
>[Isso elimina o desperdício financeiro de manter 8 servidores físicos ligados consumindo energia na ociosidade do sábado e domingo, reduz drasticamente a sobrecarga de trabalho operacional da pequena equipe de 2 profissionais e evita um aporte imediato de CapEx para renovar o hardware obsoleto de 6 anos.]
