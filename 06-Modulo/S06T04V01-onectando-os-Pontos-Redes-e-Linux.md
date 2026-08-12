# Atividade - S06T04V01: Conectando os Pontos - Redes e Linux do Módulo 3 na Cloud
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 12 de agosto de 2026  

---

## PARTE 1 — Mapeamento Direto

| # | Conceito Clássico (Redes / Linux) | Equivalente AWS |
| :-: | :--- | :--- |
| **1** | Rede local isolada, dividida em blocos menores de endereços (máscaras CIDR/24) | **VPC (Virtual Private Cloud) / Subnet (Sub-rede)** |
| **2** | Conjunto de regras de conexões/portas (`iptables` / `ufw`) | **Security Group (Grupo de Segurança)** |
| **3** | Controle de permissões de leitura, escrita e execução (`chmod` / permissões de usuário) | **AWS IAM (Identity and Access Management)** |
| **4** | Endereço IP fixo e roteável pela internet atrelado à instância | **Elastic IP (IP Elástico)** |

---

## PARTE 2 — Verdadeiro ou Falso

| # | Afirmação | (V / F) | Justificativa / Correção |
| :-: | :--- | :-: | :--- |
| **5** | A nuvem utiliza um protocolo de rede próprio, diferente do TCP/IP. | **(F)** | A nuvem opera utilizando exatamente a mesma pilha de protocolos padrão da internet (**TCP/IP**). |
| **6** | O terminal Linux perde relevância ao trabalhar com cloud computing. | **(F)** | O terminal ganha ainda mais relevância para gerenciamento de servidores, execução de CLI, automações e pipelines. |
| **7** | A CLI de um provedor de cloud roda dentro do mesmo shell que você já usa. | **(V)** | A AWS CLI (ou Azure/GCP CLI) é executada no mesmo terminal (ex: Bash, Zsh) via linha de comando. |
| **8** | Console web, CLI e API de um provedor configuram exatamente os mesmos recursos. | **(V)** | O console web e a CLI chamam, em segundo plano, exatamente as mesmas **APIs REST** do provedor. |

---

## PARTE 3 — Resposta Aberta

### 9. Posicionamento sobre a necessidade de conhecimento em Linux e Redes na Cloud:
> **Posicionamento:** Discordo totalmente da afirmação.
> 
> **Justificativa:** O console web é apenas uma interface gráfica provisória para abstrair comandos; ele não substitui a compreensão dos fundamentos técnicos que regem a infraestrutura. 
> 
> *   **Firewalls e Conectividade (Security Groups vs. `iptables`):** Ao criar um Security Group na AWS, você está definindo regras de firewall de entrada/saída idênticas ao que se faz com `iptables` ou `ufw` no Linux. Se o profissional não entender conceitos de portas (como 22 para SSH ou 80/443 para HTTP/HTTPS), protocolos (TCP/UDP) e blocos CIDR, ele deixará a aplicação inacessível ou liberará a rede para ataques globais (`0.0.0.0/0`).
> *   **Gerenciamento de Acesso (IAM vs. Permissões Linux):** O IAM funciona sob a mesma premissa de privilégio mínimo que as permissões e usuários no Linux (`chmod`/`chown`). Clicar no console sem entender como as políticas de acesso e papéis (*Roles*) se relacionam com os recursos resultará em falhas graves de governança e segurança.
> 
> Além disso, quando a instância entra no ar, o trabalho diário de diagnóstico de problemas, análise de logs, execução de pipelines de CI/CD e gerenciamento de aplicações ocorre diretamente via terminal Linux.

---

### 10. Análise da frase: “Cloud não substitui o conhecimento de redes e Linux, cloud empacota esse conhecimento numa interface mais rápida de operar, em escala”:
> **Explicação:** A nuvem não inventou uma nova forma de computação; ela automatizou o provisionamento de recursos de TI tradicionais através de APIs e software. Os conceitos fundamentais de roteamento, máscaras de rede, permissões e sistemas operacionais continuam idênticos. A diferença é que a nuvem substitui o processo manual e demorado de comprar hardware, passar cabos e instalar SOs por chamadas de código (Infraestrutura como Código) capazes de criar centenas de servidores em segundos.
> 
> **Exemplo Prático:** No modelo tradicional (*On-Premise*), para disponibilizar um servidor web com IP público e regras de segurança, um engenheiro precisava racked um servidor físico, instalar o Linux, configurar manualmente as placas de rede (`/etc/netplan` ou `ip a`), criar regras no firewall local (`iptables`) e solicitar um roteamento de IP fixo junto ao provedor. Na AWS, você declara essa mesma arquitetura em poucas linhas de código Terraform ou via CLI: uma **VPC** (sua rede física virtualizada), uma **Subnet** (sua divisão de rede), um **Security Group** (seu firewall `iptables`) e um **Elastic IP**. A física e a lógica do sistema continuam sendo de redes e Linux; a nuvem apenas empacotou tudo isso em uma camada de automação escalável.
