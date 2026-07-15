# Atividade - S06T03V07: O Ciclo de Vida do Recurso na Cloud
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Fases do ciclo de vida** | **b** | O ciclo de vida padrão consiste em Planejamento, Provisionamento, Operação e Descomissionamento[cite: 15]. |
| **2. Importância do Planejamento** | **b** | No planejamento definem-se o dimensionamento, criticidade, tags e o tempo de vida útil do recurso para evitar custos desnecessários[cite: 15]. |
| **3. Vantagem de IaC no descarte** | **b** | Recursos declarados via IaC (como Terraform) podem ser destruídos de forma limpa, previsível e completa com um único comando[cite: 15]. |
| **4. Analogia "Pet vs. Cattle" (Pet)** | **b** | Servidores "Pets" recebem manutenção manual e afetiva, gerando medo de desligamento devido à falta de padronização e automação[cite: 15]. |
| **5. Negligência no descomissionamento** | **b** | Diferente do deploy, o descarte quase nunca possui um processo formalizado ou automatizado, dependendo da memória humana[cite: 15]. |
| **6. Definição de "Recurso Órfão"** | **b** | São recursos que continuam ativos e gerando custos mesmo após o encerramento do serviço principal (ex: discos EBS soltos ou IPs elásticos não associados)[cite: 15]. |
| **7. O problema da "Conta Fantasma"** | **b** | A falta de controle sobre recursos ativos reflete diretamente uma baixa maturidade de governança, indicando potenciais brechas de segurança[cite: 15]. |

---

## PARTE 2 - Análise de Cenário (NimbusTech)

### Questão A: Em qual fase do ciclo de vida a NimbusTech está falhando de forma mais evidente?

> **Resposta:** A NimbusTech está falhando gravemente na fase de **Descomissionamento (ou Descarte)**[cite: 15]. 
> 
> **Justificativa:** Conforme descrito no cenário, o time de desenvolvimento simplesmente abandona os ambientes de homologação ao término ou cancelamento dos projetos, sem executar um processo formal de desligamento ou exclusão dos recursos[cite: 15]. A ausência de uma rotina de revisão mensal e de um fluxo de encerramento faz com que os recursos permaneçam ativos indefinidamente, quebrando o ciclo de vida saudável da infraestrutura[cite: 15].

---

### Questão B: Os ambientes estão sendo tratados como "pet" ou como "cattle"?

> **Resposta:** Estão sendo tratados como **"Pets" (Animais de Estimação)**[cite: 15].
> 
> **Elementos do cenário que sustentam a resposta:**
> 1.  **Criação Manual e Individualizada:** O time sobe toda a infraestrutura (instâncias, bancos de dados, IPs, discos) diretamente através do console web do provedor, de forma artesanal e sem o uso de templates reutilizáveis de Infraestrutura como Código (IaC)[cite: 15].
> 2.  **Falta de Padronização e Ciclo de Vida Desconhecido:** O comportamento de "apenas parar de acessar" e o receio ou negligência em desligar os recursos indicam que cada ambiente é visto como uma entidade única e indispensável, e não como um recurso descartável e substituível automaticamente por automações (*Cattle*)[cite: 15].

---

### Questão C: Que tipo de problema concreto a NimbusTech vai encontrar na fatura ao final do trimestre? Explique o mecanismo.

> **Resposta:** A empresa enfrentará um expressivo desperdício financeiro gerado pelo acúmulo de **recursos órfãos e ociosos (faturamento fantasma)**[cite: 15].
> 
> **Mecanismo do problema:**
> Ao apenas "parar de acessar" o ambiente, o time não destrói os recursos subjacentes. Na nuvem, o modelo de cobrança é baseado na alocação, não no uso ativo[cite: 15]. Consequentemente:
> *   As **instâncias virtuais** e os **bancos de dados** continuarão rodando e sendo cobrados por hora/segundo[cite: 15].
> *   Os **discos adicionais (volumes de bloco)** continuarão existindo e consumindo a cota de armazenamento provisionada por GB/mês, mesmo com a máquina virtual desligada[cite: 15].
> *   Os **IPs Elásticos (públicos)** que não estiverem associados a uma instância ativa sofrerão uma cobrança de penalidade por ociosidade imposta pela maioria dos provedores (para evitar o desperdício de endereços IPv4)[cite: 15].
> 
> A soma dessas alocações abandonadas de múltiplos projetos finalizados resultará em uma fatura acumulada extremamente alta por recursos que não estão gerando nenhum valor de negócio[cite: 15].
