# Atividade - S06T03V02: IaaS - O Controle Total da Máquina Virtual
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Responsabilidade da provedora** | **c** | A provedora é estritamente responsável pela segurança física do datacenter, o que inclui o fornecimento ininterrupto de energia elétrica, refrigeração e segurança perimetral[cite: 14]. |
| **2. Incidente por falta de patch** | **b** | No modelo IaaS, o sistema operacional da máquina virtual fica sob controle e responsabilidade total do cliente, incluindo a aplicação de correções e patches de segurança[cite: 14]. |
| **3. Shared Responsibility Model** | **b** | O modelo delimita claramente as fronteiras de atuação. No IaaS, a provedora cuida da infraestrutura física e virtualização, cabendo ao cliente gerenciar do sistema operacional para cima[cite: 14]. |
| **4. Redução de Lock-in** | **c** | Ao utilizar VMs puras em vez de serviços proprietários de banco de dados ou mensageria do provedor, o cliente pode facilmente migrar a mesma imagem da máquina para qualquer outra nuvem[cite: 14]. |
| **5. Cenário inadequado para IaaS** | **b** | Se a velocidade de entrega do MVP é a prioridade absoluta de uma equipe pequena, a carga de gerenciar servidores virtuais (IaaS) consumirá tempo valioso que seria melhor aproveitado usando PaaS[cite: 14]. |

---

## PARTE 2 - Verdadeiro ou Falso

*   **6. (F)** 
    *   *Correção:* No modelo IaaS, o **cliente** (e não a provedora de nuvem) é o único responsável por configurar, manter e atualizar o sistema operacional das máquinas virtuais com os últimos patches de segurança[cite: 14].
*   **7. (V)** 
    *   *Justificativa:* Como o sistema operacional é o mesmo (Ubuntu), as configurações de nível de SO, bibliotecas e runtimes são idênticas, simplificando significativamente a migração da carga de trabalho entre diferentes clouds.
*   **8. (V)** 
    *   *Justificativa:* O controle total sobre o SO e as portas de rede traz flexibilidade máxima para instalar qualquer software customizado, mas transfere todo o trabalho de manutenção rotineira para o time do cliente.
*   **9. (V)** 
    *   *Justificativa:* Esta divisão reflete perfeitamente a premissa de que a AWS/Azure/GCP garante a segurança "da" nuvem (hardware, redes físicas e hipervisores) enquanto o cliente garante a segurança "na" nuvem (dados e sistemas operacionais)[cite: 14].

---

## PARTE 3 - Estudo de Caso (LogiTrack)

### 10. Indicação de modelo para a LogiTrack:
> **Modelo Recomendado:** **PaaS (Platform as a Service)**.
> 
> **Justificativa:** Com um prazo de lançamento extremamente agressivo de apenas 60 dias e uma equipe técnica muito enxuta (3 desenvolvedores e apenas 1 DevOps júnior), a LogiTrack não possui braço operacional para gerenciar sistemas operacionais de VMs, configurar clusters de banco de dados do zero ou administrar a resiliência de um servidor de filas privado[cite: 14]. Ao escolher um modelo PaaS, toda a infraestrutura subjacente, o runtime do Python, a alta disponibilidade do PostgreSQL e o gerenciamento da mensageria são delegados ao provedor de nuvem[cite: 14]. Isso permite que o time foque exclusivamente no desenvolvimento rápido das regras de negócio e na API de rastreamento, garantindo uma entrega segura e dentro do prazo estimado.

---

### 11. Três responsabilidades operacionais caso a LogiTrack optasse por IaaS:

1.  **Gerenciamento, Atualização e Patching do Sistema Operacional:** O time seria obrigado a realizar a manutenção periódica do Linux/Windows das VMs, aplicando patches de segurança do kernel e atualizando pacotes para mitigar vulnerabilidades ativas[cite: 14].
2.  **Configuração e Monitoramento de Firewalls e Redes (Security Groups):** Seria necessário configurar manualmente as regras de tráfego de entrada e saída, isolando o banco de dados PostgreSQL para aceitar conexões apenas da VM da API e restringindo o acesso SSH[cite: 14].
3.  **Administração, Backup e Tuning do Banco de Dados PostgreSQL:** A equipe precisaria configurar rotinas automatizadas de backup (e testar sua restauração), gerenciar o armazenamento em disco e garantir que o serviço de banco de dados se recupere automaticamente em caso de falhas da máquina.
