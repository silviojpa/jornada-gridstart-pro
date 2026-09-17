# Atividade Prática - S07T02V03: Docker Swarm (Mapear, Ler e Decidir)

Análise teórica sobre o papel do Docker Swarm como orquestrador nativo, interpretação do ciclo de vida de serviços no cluster e tomada de decisão de arquitetura entre Compose, Swarm e Kubernetes.

---

## Parte 1 - Mapeamento dos 3 Limites do Compose vs. Solução do Swarm

### **1. Ponto Único de Falha (Single-Host)**
* **Limite do Compose:** Executa contêineres restritos a uma única máquina física ou virtual. Se o servidor falhar, a aplicação inteira fica indisponível.
* **Solução do Swarm:** Oferece suporte nativo a múltiplos nós (*Multi-Host*). Ele agrupa várias máquinas em um único cluster virtual gerenciado por nós *Managers* e conecta os contêineres através de uma *Overlay Network*, permitindo que a aplicação continue rodando mesmo se um servidor físico cair.

### **2. Sem Auto-Cura Entre Nós / Sem Escala Automática Real**
* **Limite do Compose:** Se o contêiner ou a máquina falhar, o Compose não revalida ou transfere a carga para outro servidor sozinho.
* **Solução do Swarm:** Utiliza o motor de reconciliação de estado desejado. Ao declarar um número de réplicas, o *Manager* monitora a saúde das *tasks* constantemente. Se um nó falhar, o Swarm recria automaticamente as réplicas ausentes nos nós saudáveis remanescentes e permite reajustar o número de instâncias facilmente via `docker service scale`.

### **3. Sem Rolling Update Robusto**
* **Limite do Compose:** Atualizar uma aplicação costuma exigir parar o contêiner antigo para subir o novo, gerando tempo de indisponibilidade (*downtime*).
* **Solução do Swarm:** Possui suporte nativo a *Rolling Updates*. Ele substitui as réplicas gradualmente (em lotes ou uma a uma), aguardando a nova versão ficar saudável antes de atualizar as demais. Se houver falha no processo, é possível executar um *rollback* automático para a versão anterior sem parar o serviço.

---

## Parte 2 - Leitura de Comandos e Estado do Cluster

### **Descrição dos Comandos Executados:**
1. **`docker swarm init`**: Inicializa o modo Swarm no nó local, transformando a máquina atual no primeiro nó gerenciador (*Manager*) do cluster.
2. **`docker service create --name api --replicas 3 -p 8080:8080 minha-loja-api:1.0`**: Cria um serviço gerenciado chamado `api` com 3 réplicas da imagem `1.0`, mapeando a porta `8080` de rede no cluster.
3. **`docker service ls`**: Lista os serviços ativos no Swarm, exibindo informações como ID, nome, modo, número de réplicas em execução em relação às desejadas e a imagem utilizada.
4. **`docker service scale api=6`**: Altera a declaração de estado desejado do serviço `api` para 6 réplicas.
5. **`docker service update --image minha-loja-api:2.0 api`**: Inicia o processo de *rolling update* do serviço `api`, atualizando a imagem da versão `1.0` para a `2.0` de forma gradual.

---

### **Perguntas de Fechamento:**

#### **(a) Réplicas desejadas e ação do Manager (Comando 4):**
> Após o comando 4, o cluster passa a desejar **6 réplicas** da API. O *Manager* compara o estado atual (3 réplicas rodando) com o novo estado desejado (6 réplicas) e aciona o motor de reconciliação para instanciar e agendar 3 novas *tasks* (contêineres) imediatamente.

#### **(b) Comportamento do Atualização de Imagem (Comando 5):**
> O comando 5 **não** derruba a API inteira de uma vez. O Swarm realiza um *rolling update*, atualizando as réplicas em etapas (substituindo uma ou um grupo por vez). Enquanto uma réplica é atualizada, as demais continuam ativas recebendo requisições através do roteamento interno (*Routing Mesh*), garantindo que os usuários não enfrentem indisponibilidade.

#### **(c) Limitação do Teste em Nó Único:**
> A vantagem da **alta disponibilidade com tolerância à falha de hardware** não pode ser observada em um cenário de nó único. Como há apenas uma máquina no cluster, se essa máquina física falhar ou reiniciar, não existe outro nó participante para o Swarm redistribuir as *tasks* e manter o serviço no ar.

---

## Parte 3 - Decisão de Arquitetura (O Chapéu do Arquiteto)

### **Cenário A: Desenvolvimento Local no Notebook**
* **Escolha:** **Docker Compose**
* **Justificativa:** Para o ambiente de desenvolvimento local na própria máquina, o Docker Compose é a ferramenta ideal por ser leve, simples de configurar e focada em orquestração *single-host*. Ele permite subir toda a pilha da aplicação (web, api, banco e cache) rapidamente com um único comando (`docker compose up`), sem a sobrecarga de gerenciar um cluster ou *daemons* de orquestração avançados no notebook.

### **Cenário B: Startup com 4 Servidores e Time Reduzido (2 Pessoas)**
* **Escolha:** **Docker Swarm**
* **Justificativa:** O Docker Swarm atende a todas as necessidades de produção da startup (múltiplos nós, tolerância a falhas de hardware, escala de réplicas e *rolling update* sem *downtime*) reutilizando a própria CLI e os arquivos do Docker, sem adicionar uma camada complexa de gerenciamento.
* **Risco da Escolha Oposta (Kubernetes):** Adotar o Kubernetes neste cenário traria uma complexidade operacional excessiva (*overengineering*). A curva de aprendizado alta e a necessidade de manter a infraestrutura do *Control Plane* consumiria o tempo reduzido do time de 2 pessoas, exigindo dedicação focada na manutenção do próprio orquestrador em vez de focar no produto.
