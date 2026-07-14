# Atividade - S06T02V06: Alertas de Custo e Governança FinOps
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 13 de julho de 2026  

---

## PARTE 1 - Questões Conceituais

### 1. O que é FinOps e quais são seus três pilares? Por que ele surgiu com a adoção de cloud?
> **Sua resposta:** [Escreva aqui]

### 2. Explique a diferença entre um alarme de custo do tipo Actual e do tipo Forecasted. Em qual situação cada um é mais útil?
> **Sua resposta:** [Escreva aqui]

### 3. Por que configurar alertas de custo para um e-mail que ninguém monitora é ineficaz? Qual a abordagem correta?
> **Sua resposta:** [Escreva aqui]

### 4. O que é o Cost Anomaly Detection e de que forma ele complementa os AWS Budgets? Dê um exemplo prático.
> **Sua resposta:** [Escreva aqui]

---

## PARTE 2 - Prática Guiada

### Tarefa 1 - Criando um Cost Budget
*   **Configuração Realizada:** Cost Budget Mensal de USD 10.00 com 3 gatilhos de alerta (80% Actual, 100% Forecasted, 100% Actual).
*   **Evidência:**  
    ![Confirmação do AWS Budget](caminho_para_seu_print_do_budget.png)

### Tarefa 2 - Explorando o Cost Explorer
*   **a. Serviço com maior gasto nos últimos 30 dias:** [Ex: Amazon EC2 / AWS CloudTrail / Gratuito]
*   **b. Registro de gasto de Data Transfer:** [Ex: Não há registros / US$ 0.00]
*   **c. Visualização agrupada por serviço:** [Descreva o que visualizou no gráfico de barras/linhas]
*   **Evidência:**  
    ![Gráfico do Cost Explorer](caminho_para_seu_print_do_cost_explorer.png)

### Tarefa 3 - Configurando Tags de Alocação de Custo
*   **a. Tags ativas na conta:** [Liste as tags visualizadas, ex: `aws:createdBy`, `Project`]
*   **b. Recurso tagueado:** [Ex: Adicionada a tag `Project: Estudos` à instância EC2 / ao Bucket S3 de laboratório][cite: 15].
*   **c. Tempo de propagação após ativação da tag:** [Escreva aqui]
