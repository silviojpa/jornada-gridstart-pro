# Atividade - S06T03V03: PaaS e SaaS - Focando no Código e Esquecendo o SO
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## Parte 1 - Classifique o Serviço

| # | Serviço | Classificação | Justificativa |
| :-: | :--- | :---: | :--- |
| **1** | **Amazon EC2** (Máquina Virtual) | **IaaS** | O usuário tem controle total sobre o sistema operacional e a infraestrutura virtualizada[cite: 15]. |
| **2** | **Google Workspace** (Gmail, Docs) | **SaaS** | É um software final pronto para uso pelo usuário, sem necessidade de gerenciar infraestrutura ou plataforma[cite: 15]. |
| **3** | **Heroku** (Plataforma de Deploy) | **PaaS** | Abstrai completamente a infraestrutura física e o sistema operacional, permitindo focar apenas no deploy do código[cite: 15]. |
| **4** | **Amazon RDS** (PostgreSQL Gerenciado) | **PaaS** *(DBaaS)* | A AWS gerencia o sistema operacional, patching e backups, disponibilizando apenas o motor e a conexão do banco de dados[cite: 15]. |
| **5** | **Microsoft Azure Virtual Machines** | **IaaS** | Fornece poder computacional sob demanda na forma de máquinas virtuais com controle total do SO pelo cliente[cite: 15]. |
| **6** | **Slack** | **SaaS** | É uma aplicação de comunicação pronta e consumida diretamente pelos usuários via web, desktop ou mobile[cite: 15]. |
| **7** | **Google App Engine** | **PaaS** | Gerencia automaticamente o provisionamento de servidores, balanceamento de carga e escalabilidade com base no código enviado[cite: 15]. |
| **8** | **Salesforce CRM** | **SaaS** | É uma solução completa de gerenciamento de relacionamento com clientes entregue pronta como serviço na nuvem[cite: 15]. |
| **9** | **DigitalOcean Droplets** | **IaaS** | Trata-se de servidores virtuais onde o usuário escolhe e gerencia o sistema operacional, redes e recursos[cite: 15]. |
| **10**| **Stripe** | **SaaS** | Fornece uma plataforma de pagamentos online pronta, integrada via API, sem visibilidade ou gestão de infraestrutura pelo cliente[cite: 15]. |

---

## Parte 2 - Análise de Cenário

### a) Recomendação de modelo para hospedar a API:
> **Recomendação:** **PaaS (Platform as a Service)**.
> 
> **Justificativa:** Com apenas 3 desenvolvedores, nenhum especialista em infraestrutura e um prazo agressivo de 60 dias para o lançamento, o time precisa concentrar 100% de sua energia nas regras de negócio da API[cite: 15]. Adotar um modelo PaaS elimina a necessidade de configurar servidores virtuais, redes, balanceadores de carga e atualizações de sistema operacional, permitindo colocar a aplicação em produção com poucos cliques e de forma extremamente ágil[cite: 15].

---

### b) Abordagem recomendada para o banco de dados (VM vs. DBaaS):
> **Recomendação:** **DBaaS (Database as a Service)** — como o Amazon RDS[cite: 15].
> 
> **Justificativa:** Configurar alta disponibilidade (Multi-AZ) e rotinas de backup consistentes em um banco instalado em uma VM (IaaS) exige conhecimento sênior de administração de banco de dados (DBA) e consome muito tempo de operação técnica. Ao optar por um DBaaS, funções críticas como backups automatizados, monitoramento, atualizações de patches e replicação para alta disponibilidade são configuradas e garantidas pelo provedor de nuvem de forma nativa e simplificada[cite: 15].

---

### c) Modelo de serviço para comunicação interna/CRM e exemplos reais:
> **Modelo de Serviço:** **SaaS (Software as a Service)**[cite: 15].
> 
> **Exemplos de Ferramentas:**
> *   **Comunicação Interna:** Slack, Microsoft Teams, Discord ou Google Chat.
> *   **CRM (Customer Relationship Management):** Salesforce[cite: 15], HubSpot, Pipedrive ou Zoho CRM.

---

### d) Avaliação de migração para IaaS após 2 anos de crescimento:
> **Faria sentido migrar?** **Sim, potencialmente faz sentido**, pois a startup atingiu um nível de maturidade técnica e organizacional em que as restrições e o custo do PaaS começaram a gargalar a operação e a conformidade (compliance)[cite: 15].
> 
> **Fatores a avaliar para tomar a decisão:**
> 1.  **Custo Operacional vs. Custo de Infraestrutura:** Colocar a equipe para gerenciar servidores virtuais tem um custo de horas de trabalho. A economia financeira da infraestrutura de IaaS compensa o tempo que os 2 especialistas em infraestrutura gastarão mantendo o ambiente no ar[cite: 15]?
> 2.  **Exigências de Conformidade e Segurança:** A necessidade do SO customizado e das regras específicas de rede é um requisito de compliance de um cliente grande ou regulador? Se sim, a migração para IaaS torna-se mandatória para viabilizar o negócio.
> 3.  **Complexidade de Migração:** O time tem a maturidade técnica para empacotar a aplicação (ex: conteinerizar com Docker) e gerenciar a resiliência operacional que antes o PaaS resolvia de forma automática[cite: 15]?
