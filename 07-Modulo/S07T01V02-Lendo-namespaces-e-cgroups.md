# Atividade Prática — S07T01V02: Lendo namespaces e cgroups como um engenheiro
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 19 de agosto de 2026  

---

## PARTE 1 — Perguntas de Fixação

### 1. Qual a diferença fundamental entre o que um namespace resolve e o que um cgroup resolve?
> **Resposta:** 
> * **Namespace:** Resolve o **isolamento de visão** (*o que o processo enxerga*). Ele limita a visibilidade de recursos do sistema (processos, rede, arquivos, hostname) para que o contêiner acredite que está rodando sozinho na máquina.
> * **Cgroup (Control Group):** Resolve a **limitação de consumo de recursos** (*o que o processo gasta*). Ele controla e limita a quantidade de hardware (CPU, memória RAM, I/O de disco, quantidade de PIDs) que um grupo de processos pode utilizar.

---

### 2. Cite 4 dos 7 tipos de namespace do Linux e explique o que cada um isola:
> **Resposta:**
> 1. **PID (Process ID):** Isola a árvore e a numeração de processos, fazendo com que o processo principal do contêiner enxergue a si mesmo como `PID 1`.
> 2. **NET (Network):** Isola as interfaces de rede, tabela de roteamento, regras de firewall e portas de conexão (TCP/UDP).
> 3. **MNT (Mount):** Isola os pontos de montagem e a visão do sistema de arquivos, permitindo que o contêiner tenha seu próprio `rootfs` (`/`).
> 4. **UTS (UNIX Timesharing System):** Isola o nome do host (*hostname*) e o domínio NIS, permitindo que o contêiner tenha um nome de rede próprio sem alterar o host.

---

### 3. Por que dois contêineres conseguem escutar na mesma porta (ex: 8000) sem conflito? Qual namespace resolve isso?
> **Resposta:** Porque cada contêiner possui sua própria pilha de rede independente, interfaces virtuais e tabela de socket isoladas. O namespace responsável por isso é o **NET namespace**.

---

### 4. O que é o User namespace e por que ele é uma peça central de segurança em produção?
> **Resposta:** O **User namespace** permite mapear os IDs de usuário e grupo (UID e GID) de dentro do contêiner para UIDs/GIDs diferentes no sistema hospedeiro. Sua relevância para a segurança consiste em permitir que um processo rode como `root` (UID 0) dentro do contêiner, mas seja mapeado para um usuário completamente sem privilégios (ex: UID 10001) no host, impedindo que uma invasão com *container escape* conceda acesso administrativo ao servidor físico.

---

### 5. Cite os 4 controllers de cgroup vistos e o que cada um limita:
> **Resposta:**
> 1. **`memory`:** Limita o uso de memória RAM (alocação de memória e memória swap).
> 2. **`cpu`:** Limita a quantidade e o tempo de uso do processador (fracionamento de vCPUs/cota de tempo).
> 3. **`io` / `blkio`:** Controla e limita a taxa de transferência e operações de leitura/escrita em disco (I/O throughput e IOPS).
> 4. **`pids`:** Limita o número máximo de processos/threads que podem ser criados dentro do cgroup (evita ataques de *fork bomb*).

---

### 6. O que é o OOM killer e em que situação ele age dentro de um cgroup?
> **Resposta:** O **OOM (Out Of Memory) Killer** é um mecanismo de emergência do kernel Linux que encerra processos para liberar memória e evitar o travamento geral do sistema. Dentro de um cgroup, ele é acionado quando o consumo de memória RAM dos processos daquele cgroup atinge e ultrapassa o limite máximo configurado (ex: `memory.max`). O kernel então identifica e mata o processo com maior consumo do cgroup.

---

### 7. Complete e explique a frase:
> **Frase:** *"Docker não inventou isolamento de contêiner, Docker **popularizou e empacotou esses recursos nativos do kernel através de uma interface amigável**."*
>
> **Explicação:** Tecnologias de isolamento como `namespaces` e `cgroups` já existiam há anos no kernel do Linux. O grande diferencial do Docker foi criar uma camada de abstração de alto nível (API, CLI, motor de build e imagens) para que engenheiros pudessem manipular esses recursos complexos com comandos simples como `docker run`.

---

## PARTE 2 — Interpretando uma Saída de `lsns`

Abaixo está a interpretação detalhada linha a linha da saída fornecida:

| # | TYPE (Tipo) | O que esse tipo isola | Interpretação da Linha (NPROCS / COMMAND) |
| :-: | :--- | :--- | :--- |
| **1** | `cgroup` | Isola a visualização da própria hierarquia de cgroups. | Com `NPROCS=142` e `COMMAND=/sbin/init` (PID 1), trata-se do **cgroup namespace raiz do sistema hospedeiro (host)**. |
| **2** | `user` | Isola a tabela de mapeamento de usuários e grupos (UID/GID). | Com `NPROCS=142` e `COMMAND=/sbin/init`, trata-se do **user namespace raiz/padrão do host**. |
| **3** | `mnt` | Isola os pontos de montagem da árvore do sistema de arquivos. | Com `NPROCS=3` associado ao `containerd-shim` (PID 4821), trata-se de um **MNT namespace isolado**, criado especificamente para prover o sistema de arquivos de um contêiner. |
| **4** | `uts` | Isola o hostname e o domínio NIS. | `NPROCS=3` rodando sob o `containerd-shim`: **UTS namespace isolado** de um contêiner (garante um hostname próprio). |
| **5** | `ipc` | Isola mecanismos de comunicação inter-processos (filas de mensagem, memória compartilhada). | `NPROCS=3` rodando sob o `containerd-shim`: **IPC namespace isolado** dedicado ao contêiner. |
| **6** | `pid` | Isola a numeração e a visão da árvore de PIDs. | `NPROCS=3` sob o `containerd-shim`: **PID namespace do contêiner**, onde seus processos internos possuem sua própria contagem isolada. |
| **7** | `net` | Isola a pilha de rede, interfaces, regras de roteamento e portas. | `NPROCS=3` sob o `containerd-shim`: **NET namespace exclusivo do contêiner**, provendo sua interface e IP virtuais. |

---

## PARTE 3 — Interpretando uma Saída de `cat /proc/PID/cgroup`

**Saída:** `0::/system.slice/docker-a1b2c3d4e5f6.scope`

### 1. O que esse caminho revela sobre a cgroup à qual esse processo pertence?
> **Resposta:** Revela que o processo é gerenciado pelo **systemd** através do slice de sistema (`system.slice`) e pertence ao escopo específico do contêiner Docker identificado pelo ID `a1b2c3d4e5f6`.

### 2. Por que, em cgroups v2, existe apenas uma linha (hierarquia unificada)?
> **Resposta:** No cgroups v1, cada controller (memória, CPU, I/O) possuía sua própria árvore/hierarquia independente, o que gerava inconsistências, problemas de sincronização e concorrência no tratamento de processos. O **cgroups v2** introduziu a **hierarquia unificada**, onde o processo é organizado dentro de uma única estrutura de diretórios onde todos os controllers atuam juntos.

### 3. Em qual caminho do filesystem (`/sys/fs/cgroup/...`) você esperaria encontrar o valor do limite de memória?
> **Resposta:** Espera-se encontrar o valor no arquivo `memory.max` situado no caminho:  
> `/sys/fs/cgroup/system.slice/docker-a1b2c3d4e5f6.scope/memory.max` *(ou `/sys/fs/cgroup/memory.max` se inspecionado de dentro do próprio contêiner)*.

---

## PARTE 4 — Tabela Comparativa

| Mecanismo | O que isola/limita | Exemplo de tipo/controller | Consequência se ultrapassado |
| :--- | :--- | :--- | :--- |
| **Namespace** | Isola a **visão** e a visibilidade de recursos do sistema operacional. | `NET` (rede) / `PID` (processos) / `MNT` (montagem) | O processo simplesmente **não enxerga** os recursos fora do seu namespace (ex: não acessa arquivos de outro MNT namespace ou processos do host). |
| **Cgroup** | Limita a **quantidade e o consumo** de recursos de hardware. | Controller `memory` (`memory.max`) / Controller `pids` | Se estourar o limite de memória, o processo sofre **OOM Killer** e é encerrado; se estourar o limite de PIDs/CPU, sofre estrangulamento (*throttling*) ou recusa de novos forks. |
