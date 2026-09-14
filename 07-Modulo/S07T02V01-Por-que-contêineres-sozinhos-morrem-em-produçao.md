# Atividade Prática - S07T02V01: Por que contêineres sozinhos morrem em produção

Análise teórica sobre a transição do gerenciamento manual de contêineres para o uso de orquestradores em ambientes de produção[cite: 12].

---

## Parte 1 - Diagnóstico dos Três Problemas

* **a) Auto-cura (Self-Healing):**
  * **Fato Relacionado:** Fato 2 (O contêiner do banco caiu às 3h da manhã por pico de memória e ficou 4h30 fora do ar até o time acordar).
  * **Por quê:** Evidencia a falta de monitoramento contínuo e reinicialização automática da aplicação, dependendo de intervenção humana manual para reestabelecer o serviço indisponível.

* **b) Roteamento / Balanceamento de Carga + Descoberta de Serviço:**
  * **Fato Relacionado:** Fato 3 (A API precisa de réplicas, mas cada cópia nasce com um IP diferente e o front-end `web` perde a conexão).
  * **Por quê:** Mostra a ausência de um endereço ou nome DNS estável (*Service Discovery*) e de um balanceador de carga que distribua o tráfego automaticamente entre as novas instâncias dinâmicas da API.

* **c) Alocação e Escala Automática:**
  * **Fato Relacionado:** Fato 1 (Acesso na Black Friday multiplica por 20 durante o dia e volta ao normal à noite).
  * **Por quê:** Demonstra a limitação do dimensionamento estático de recursos, exigindo um mecanismo capaz de aumentar o número de cópias (*scale-out*) durante picos de demanda e reduzi-lo (*scale-in*) na ociosidade.

---

## Parte 2 - O que um Orquestrador Fará

### **4. O banco que caiu às 3h da manhã:**
> O orquestrador opera em um loop contínuo comparando o estado atual com o estado desejado declarativo (ex.: "manter 1 instância do banco rodando"). Ao detectar via *Health Checks* que o processo caiu, o motor de reconciliação recria o contêiner instantaneamente em instantes, restaurando a aplicação sem necessidade de intervenção humana de madrugada.

### **5. As cópias da API com endereços que mudam (Fato 3):**
> O orquestrador atribui um ponto de entrada único e estável (com nome DNS fixo e VIP/Virtual IP) para o serviço da API. Quando novas cópias nascem ou morrem, o *Service Discovery* atualiza a lista interna de rotas e o balanceador distribui as requisições do `web` de forma transparente entre as instâncias ativas, sem que o front-end perca a comunicação.

### **6. O pico da Black Friday (Fato 1):**
> O orquestrador utiliza métricas em tempo real (como uso de CPU, memória ou requisições) para acionar o *Autoscaling* de pods/contêineres. Durante o pico do dia, ele sobe réplicas automaticamente para absorver a carga de 20x e evitar quedas por sobrecarga; à noite, ao notar a queda do tráfego, remove as réplicas excedentes para economizar custos e evitar desperdício de infraestrutura.

---

## Parte 3 - Conceito-Chave (Mudança de Mentalidade)

### **7. Imperativo (Comando) vs. Declarativo (Estado Desejado):**
> Dar um comando imperativo ("suba este contêiner agora") é uma instrução pontual de execução única: se o processo morrer no segundo seguinte, o sistema não tomará nenhuma atitude. Declarar um estado desejado ("este contêiner tem que estar sempre de pé") define um contrato contínuo onde o orquestrador assume a responsabilidade de monitorar e restabelecer esse estado para sempre; essa busca constante por alinhar o real ao declarado é a fundação técnica da **auto-cura**.

---

## Parte 4 - Situando-se no Mapa

### **8. Ordenação das ferramentas (do mais simples ao mais poderoso) e função da primeira:**

1. **Docker Compose**
2. **Docker Swarm**
3. **Kubernetes**

> **Função do Docker Compose:** Serve para definir e orquestrar múltiplos contêineres em uma única máquina localmente através de um arquivo descritivo de configuração (`docker-compose.yml`).
> **Função do Docker Swarn ** Serve para gerenciar containers parecido com kubernetes ou gerenciamento de conraniners da própria em empresa.
> **Função do Kubernetes ** Serve para orquestrar os containers com LB, Observabilidade e healh check dos PODs dentro no NODEs.
