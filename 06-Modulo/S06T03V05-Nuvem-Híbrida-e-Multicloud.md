# Atividade - S06T03V05: Nuvem Híbrida e Multicloud
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Caracterização de nuvem híbrida** | **b** | A nuvem híbrida é definida pela conexão e orquestração de recursos entre ambientes privados (on-premise) e nuvens públicas[cite: 15]. |
| **2. Transbordo sob demanda** | **b** | O *Cloud Bursting* é a técnica de arquitetura onde uma aplicação transborda para a nuvem pública para absorver picos de tráfego temporários[cite: 15]. |
| **3. Diferença entre híbrida e multicloud** | **b** | A nuvem híbrida mistura público e privado; a multicloud envolve o uso combinado de dois ou mais provedores de nuvem pública (ex: AWS + Azure)[cite: 15]. |
| **4. Escolha pontual de provedor** | **b** | Representa o princípio de usar a melhor tecnologia disponível para resolver cada carga de trabalho específica (*best-of-breed*), otimizando custos e performance[cite: 15]. |
| **5. Relevância do Terraform** | **c** | O Terraform permite declarar e gerenciar infraestruturas em múltiplos provedores utilizando uma linguagem de configuração comum (HCL)[cite: 15]. |
| **6. Latência em arquiteturas multicloud** | **b** | Microsserviços e serviços com comunicação frequente e volumosa (*chatty*) geram latência e custos de saída de dados elevados se distribuídos entre nuvens diferentes[cite: 15]. |
| **7. Razão real para multicloud** | **b** | Adotar múltiplos provedores de nuvem pública reduz drasticamente o risco de indisponibilidade global e evita o lock-in comercial com uma única empresa[cite: 15]. |

---

## PARTE 2 - Análise de Cenário (NortSul Varejo)

### Questão A: Modelo sugerido para o ERP Legado e E-commerce

> **Modelo Recomendado:** **Nuvem Híbrida**[cite: 15].
> 
> **Justificativa:** 
> *   **ERP Legado:** O ERP roda há 12 anos em servidores locais e possui integrações extremamente complexas com a operação física[cite: 15]. Migrá-lo para a nuvem repentinamente seria um projeto demorado, de alto risco e custo elevado. O mais seguro é mantê-lo rodando de forma estável na infraestrutura privada (On-Premise)[cite: 15].
> *   **E-commerce:** Como o site sofre flutuações agressivas de demanda (picos multiplicados por 10 em datas promocionais)[cite: 15], ele precisa da escalabilidade elástica da **nuvem pública**. 
> *   **Integração:** Conectar o e-commerce moderno na nuvem pública com o banco de dados do ERP físico (para validação de estoques e faturamento em tempo real) através de canais seguros (como uma VPN dedicada ou AWS Direct Connect) caracteriza um cenário perfeito de arquitetura **Híbrida**[cite: 15].

---

### Questão B: Decisão estratégica de Machine Learning em outro provedor

> **Decisão Estratégica:** Trata-se de uma estratégia de **Best-of-Breed (Melhor de Cada Provedor)** no contexto de uma arquitetura Multicloud[cite: 15].
> 
> **Conceito Aplicado:** O conceito é a **seleção de soluções por especialização técnica**, em vez de concentrar todos os serviços por conveniência comercial[cite: 15]. Se um provedor concorrente (por exemplo, o Google Cloud com a plataforma Vertex AI) oferece algoritmos, ferramentas de ML prontas e maior facilidade para rodar modelos preditivos de recomendação do que o provedor de nuvem pública principal da NortSul, faz total sentido desenhar essa funcionalidade isolada no provedor especialista. Isso otimiza o tempo de colocação no mercado (*time-to-market*) e a precisão do algoritmo.

---

### Questão C: Riscos da falta de maturidade e ferramenta de mitigação

> **Principais Riscos Identificados:**
> 1.  **Sobrecarga Operacional e Complexidade Cognitiva:** Com um time pequeno e sem experiência prévia, gerenciar múltiplos painéis, diferentes consoles de segurança, faturamentos separados e APIs concorrentes gerará falhas operacionais e potenciais brechas de segurança cibernética por má configuração[cite: 15].
> 2.  **Frustração e Desperdício Financeiro:** A falta de controle sobre os custos de tráfego de dados de saída (*data egress*) entre provedores e no tráfego híbrido pode fazer com que a fatura exploda rapidamente.
> 
> **Ferramenta de Mitigação Recomendada:** **Terraform (HashiCorp)**[cite: 15].
> 
> **Como ela ajuda:** Sendo uma ferramenta de Infraestrutura como Código (IaC) agnóstica de provedor, o Terraform permite que esse time de infraestrutura pequeno descreva, versione e implante os recursos da nuvem privada, da AWS e do provedor de ML usando uma única linguagem unificada (HCL)[cite: 15]. Isso centraliza a gerência da infraestrutura, cria padrões replicáveis de segurança e reduz drasticamente a necessidade de dominar em profundidade os diferentes consoles web de cada provedor[cite: 15].
