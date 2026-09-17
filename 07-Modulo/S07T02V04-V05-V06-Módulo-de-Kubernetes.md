# Módulo de Kubernetes: V04, V05 e V06

---

## 📌 Atividade - S07T02V04: Introdução ao Kubernetes (Explicar, Ler e Decidir)

### Parte 1 — Estado Desejado + Leitura de YAML

* **1a) Estado Desejado vs. Imperativo:** Declarar o estado desejado é definir *o destino* (como a infraestrutura deve ficar), enquanto a abordagem imperativa exige *passos manuais*. O K8s usa o **loop de reconciliação** para alinhar continuamente a realidade ao arquivo declarativo.
* **1b) Análise de Cenários:**
  * **(i) Queda de 1 máquina/réplica:** O loop detecta que existem apenas 2 de 3 réplicas desejadas e aciona a **auto-cura (*self-healing*)**, subindo um novo Pod em uma máquina saudável.
  * **(ii) Mudança de `replicas: 3` para `replicas: 8`:** O K8s reconcilia a nova meta e instancia 5 novas réplicas para cobrir a diferença.

---

### Parte 2 — A Régua do Canhão

* **Cenário A (Dev no Notebook):** **Não se justifica.** Problema pequeno e local; o **Docker Compose** cumpre o papel de forma mais simples.
* **Cenário B (Empresa Grande com Milhões de Usuários):** **Se justifica.**
  * **Ganho Concreto:** Autoscaling elástico e padronização para múltiplos times.
  * **Pedágio:** Alta complexidade operacional e necessidade de equipe dedicada para gerenciar o cluster.

---

### Parte 3 — Por que o Kubernetes Venceu em Larga Escala

* **Herança do Google (Borg):** Projetado com base na experiência do Google operando contêineres em escala global.
* **Modelo Declarativo de Reconciliação:** Garante resiliência e reduz falhas humanas.
* **Ecossistema CNCF:** Governança neutra com ampla adoção pela comunidade e grandes fornecedores de nuvem.

---
---

## 📌 Atividade - S07T02V05: Anatomia do Control Plane

### Parte 1 — Associação de Componentes

1. **API Server $\rightarrow$ C:** Porta de entrada única do cluster; valida, autentica e é o único que acessa a base de dados.
2. **etcd $\rightarrow$ A:** Banco chave-valor que armazena a fonte única da verdade (estado atual e desejado).
3. **Scheduler $\rightarrow$ D:** Seleciona em qual *Worker Node* cada novo Pod deve ser alocado.
4. **Controller Manager $\rightarrow$ B:** Executa os controladores do loop de reconciliação.

---

### Parte 2 — Diagnóstico de Falhas no Control Plane

* **Cenário A (Perda do `etcd` sem backup):** O cluster perde toda a sua memória e estado. Na prática, o cluster é destruído, pois não há como recuperar o histórico do que deveria estar rodando.
* **Cenário B (Falha do `Scheduler`):** Os Pods já existentes continuam rodando normalmente. Porém, Pods novos ficarão travados no estado `Pending`, pois ninguém fará a decisão de em qual máquina eles devem ser colocados.

---

### Parte 3 — Papel do Controller Manager no Loop

> O **Controller Manager** abriga os loops de reconciliação. Ele consulta o estado desejado e o atual via **API Server** (que lê do **etcd**) e emite ordens de atualização para igualar a realidade à declaração, garantindo a centralização da segurança e da comunicação.

---
---

## 📌 Atividade - S07T02V06: Anatomia dos Worker Nodes

### Parte 1 — Associação de Componentes

1. **Kubelet $\rightarrow$ C:** Capataz da máquina; recebe ordens do API Server, solicita a execução de contêineres e reporta a saúde do nó.
2. **Kube-proxy $\rightarrow$ A:** Gerencia as regras de rede locais e o roteamento para os *Services*.
3. **Container Runtime $\rightarrow$ B:** Motor de baixo nível (ex.: `containerd`) que baixa imagens e executa os contêineres via CRI.

---

### Parte 2 — Diagnóstico de Falhas no Worker Node

* **Cenário A (Falha do `kube-proxy`):** Os contêineres no nó continuam executando. No entanto, a comunicação de rede através dos VIPs dos *Services* fica comprometida.
* **Cenário B (Falha do `kubelet`):** O nó para de aceitar novos Pods, não reinicia contêineres locais quebrados e o Control Plane deixa de receber os relatórios de saúde (*heartbeats*), podendo marcar o nó como `NotReady`.

---

### Parte 3 — Compatibilidade OCI e Troca de Runtime

> A substituição do Docker pelo `containerd` no nó não quebrou as imagens porque o processo de compilação (*build*) do Docker gera artefatos padronizados pela **OCI (Open Container Initiative)**. Como qualquer runtime compatível com a **CRI (Container Runtime Interface)** consegue interpretar especificações OCI, as imagens criadas pelo Docker continuam rodando perfeitamente em outros motores.
