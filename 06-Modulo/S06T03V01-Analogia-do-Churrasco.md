# Atividade - S06T03V01: A Analogia do Churrasco (IaaS, PaaS e SaaS)
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## Parte 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Modelo On-Premise** | **b** | No modelo local, a empresa é dona de toda a pilha tecnológica, possuindo controle total e a responsabilidade exclusiva de manutenção física e lógica[cite: 15]. |
| **2. Foco apenas no código** | **c** | O modelo **PaaS** (Plataforma como Serviço) abstrai a infraestrutura, permitindo que os desenvolvedores foquem exclusivamente no código da aplicação[cite: 15]. |
| **3. Descrição de SaaS** | **c** | No **SaaS** (Software como Serviço), o cliente consome uma aplicação final e pronta para uso diretamente pelo navegador ou app, sem gerenciar nada abaixo disso[cite: 15]. |
| **4. Responsabilidade pelos dados** | **b** | No Modelo de Responsabilidade Compartilhada, o **cliente** é sempre o proprietário e o único responsável pela segurança e governança de seus próprios dados[cite: 15]. |
| **5. Enviar containers no Kubernetes** | **d** | O modelo **CaaS** (Container como Serviço) é caracterizado pelo fornecimento de uma plataforma de orquestração (como o Kubernetes) onde o cliente gerencia apenas os containers[cite: 15]. |

---

## Parte 2 - Associação de Modelos de Serviço

| # | Descrição | Modelo de Serviço |
| :-: | :--- | :---: |
| **A** | Você usa o Gmail pelo browser. Não instala nada, não configura servidor. | **SaaS** |
| **B** | Você cria uma VM no console da AWS e acessa via SSH para instalar o Node.js. | **IaaS** |
| **C** | Sua empresa tem um data center próprio com servidores físicos comprados. | **On-Premise** |
| **D** | Você sobe seu código no Heroku e ele cuida do deploy, escalonamento e banco de dados. | **PaaS** |
| **E** | Você escreve uma função Python que dispara quando um arquivo é salvo no S3. Paga por execução. | **FaaS** |
| **F** | Você entrega uma imagem Docker e o provedor executa em um cluster Kubernetes gerenciado. | **CaaS** |

---

## Parte 3 - Respostas Abertas

### 6. Startup com dois desenvolvedores e sem especialista em infraestrutura lançando API REST:
> **Recomendação:** **PaaS (Platform as a Service)** ou **Serverless/FaaS**.
> 
> **Justificativa:** Com uma equipe extremamente enxuta e sem braço técnico focado em operações (DevOps/Sysadmin), a startup não pode desperdiçar tempo configurando sistemas operacionais, atualizando patches de segurança de servidores virtuais ou configurando redes complexas (o que ocorreria no modelo IaaS)[cite: 15]. Ao adotar um PaaS (como Render, Heroku ou AWS Elastic Beanstalk), os dois desenvolvedores conseguem focar 100% no desenvolvimento de regras de negócio e no lançamento rápido do produto no mercado, delegando a carga operacional de provisionamento, escalabilidade e gerenciamento de banco de dados para o provedor de nuvem[cite: 15].

---

### 7. O que é o Shared Responsibility Model (Modelo de Responsabilidade Compartilhada)?
> **Explicação:** Trata-se de uma matriz de divisão de tarefas que estabelece claramente onde termina a responsabilidade de segurança do provedor de nuvem e onde começa a do cliente. O provedor assume a segurança **"da"** nuvem (infraestrutura global, segurança física dos datacenters, hipervisores e hardware)[cite: 15], enquanto o cliente assume a segurança **"na"** nuvem (dados, criptografia, sistemas operacionais das VMs criadas e políticas de controle de acesso/IAM)[cite: 15].
> 
> **Exemplo Prático:** Se um invasor conseguir acessar uma máquina virtual EC2 (IaaS) da empresa porque o time de desenvolvimento deixou a porta 22 (SSH) aberta para toda a internet com chaves fracas, a falha de segurança é de inteira responsabilidade do **cliente** (segurança *na* nuvem). No entanto, se um hacker invadir fisicamente o datacenter da AWS e roubar um disco rígido físico, a falha de segurança é de responsabilidade do **provedor** (segurança *da* nuvem).

---

### 8. Infraestrutura para Core Banking de Banco Tradicional e Hibridização:
> **Modelo mais adequado para o Core Banking:** **On-Premise (Private Cloud)** ou um modelo híbrido altamente controlado.
> 
> **Justificativa:** Sistemas de core banking processam transações financeiras críticas que exigem latência quase zero, conformidade regulatória severa (como as normas do Banco Central) e controle absoluto sobre a custódia física dos dados e do hardware. Manter essa estrutura crítica localmente garante o controle ponta a ponta exigido pelas auditorias e evita riscos de soberania de dados em nuvens públicas[cite: 15].
> 
> **Cenário para adoção de Cloud Pública:** Sim, o banco pode (e deve) adotar uma estratégia de **Nuvem Híbrida**. Serviços que não pertencem ao núcleo transacional — como plataformas de CRM, ferramentas de análise de dados (Big Data/Analytics), portais de atendimento ao cliente, aplicativos móveis institucionais e ambientes de desenvolvimento e testes — podem rodar perfeitamente em nuvem pública (PaaS/SaaS)[cite: 15]. Isso permite usufruir da elasticidade e das ferramentas modernas de IA do provedor de nuvem sem comprometer a segurança regulatória do core banking[cite: 15].
