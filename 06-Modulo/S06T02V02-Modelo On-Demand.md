# Atividade - S06T02V02: Modelo On-Demand e Desperdício em Cloud
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 12 de julho de 2026  

---

## Parte 1 - Questões de Múltipla Escolha

| Questão | Alternativa Correta |
| :--- | :---: |
| **Questão 1: Início da cobrança** | **b** |
| **Questão 2: Definição de Servidor Zumbi** | **c** |
| **Questão 3: Cálculo t3.large (45 horas)** | **b** |
| **Questão 4: Caso de uso ideal** | **c** |
| **Questão 5: Granularidade de cobrança** | **b** |
| **Questão 6: Abordagem de governança eficaz** | **b** |

---

## Parte 2 - Questão Dissertativa

### Questão 7: Análise de Lançamento de Aplicativo por Startup
O modelo On-Demand é ideal devido à extrema imprevisibilidade inicial do volume de acessos[cite: 15]. Ele oferece a flexibilidade necessária para escalar a infraestrutura em segundos caso o aplicativo viralize, ou reduzir a capacidade imediatamente se o crescimento for lento, evitando contratos de fidelidade rígidos ou desperdício de capital prematuro[cite: 15]. 

Durante esses 30 dias, o time deve monitorar com rigor os seguintes riscos operacionais e financeiros:
*   **Servidores Zumbis:** Instâncias criadas para testes pontuais ou homologação temporária que sejam esquecidas ligadas consumindo orçamento sem necessidade[cite: 15].
*   **Ausência de Alertas de Orçamento:** Risco de faturamento descontrolado caso picos repentinos de tráfego escalem a infraestrutura sem a devida parametrização de *budget alerts*[cite: 15].
*   **Recursos Sem Identificação (Tags):** Falta de rastreabilidade que impeça o time de distinguir o tráfego gerado pelo ambiente produtivo real daqueles criados para experimentação isolada[cite: 15].

---

## Parte 3 - Análise de Cenário (TechCorp)

### Questão 8a: Cálculos de Custo e Desperdício Mensal

*   **Custo Mensal Total Atual:** 
    $$47 \text{ instâncias} \times \$60/\text{mês} = \mathbf{\$2.820/\text{mês}}$$[cite: 15]
*   **Volume de Instâncias Ociosas (Zumbis):** 
    $$47 \text{ instâncias no total} - 12 \text{ instâncias com tráfego real} = \mathbf{35 \text{ instâncias}}$$[cite: 15]
*   **Custo Mensal do Desperdício:** 
    $$35 \text{ instâncias ociosas} \times \$60/\text{mês} = \mathbf{\$2.100/\text{mês}}$$ *(Aproximadamente 74,4% do orçamento total direcionado ao lixo)*[cite: 15].
*   **Projeção de Desperdício Anual:** 
    $$\$2.100/\text{mês} \times 12 \text{ meses} = \mathbf{\$25.200/\text{ano}}$$[cite: 15].

### Questão 8b: Medidas Concretas de Mitigação Imediata

1.  **Implementar Política de Tags Obrigatórias por Código:** Configurar uma diretiva de controle centralizado no provedor (como *Tag Policies* ou políticas do IAM) que rejeite e bloqueie o provisionamento de qualquer novo recurso que não possua as chaves mandatórias preenchidas, como `Owner` (Dono), `Environment` (Ambiente: dev, staging, prod) e `Purpose` (Propósito)[cite: 15].
2.  **Configurar Alertas de Orçamento Multi-Nível (Budget Alerts):** Definir imediatamente no console de faturamento alertas automatizados disparados quando o consumo real atingir os gatilhos de 70%, 90% e 100% da meta orçamentária projetada para o mês, enviando notificações instantâneas aos canais de comunicação oficiais da engenharia[cite: 15].
3.  **Automatizar o Desligamento Programado de Ambientes de Não-Produção:** Adotar ferramentas nativas de agendamento de instâncias para forçar o desligamento em lote de todos os recursos marcados como `Environment=dev` ou `Environment=staging` de segunda a sexta-feira após o horário comercial (ex: às 20h), religando-os no início da manhã seguinte (ex: às 8h), e mantendo-os totalmente desligados durante os finais de semana[cite: 15]. Isso elimina mais de 60% do tempo de ociosidade sem intervenção manual humana[cite: 15].
