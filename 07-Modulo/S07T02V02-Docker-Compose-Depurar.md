# Atividade Prática - S07T02V02: Docker Compose (Depurar + Justificar Produção)

Análise crítica e depuração de um arquivo `docker-compose.yml`, além da fundamentação técnica sobre as limitações do Compose para ambientes de produção de alta escala.

---

## Parte 1 - Identificação dos 5 Problemas

### **1. Campo de topo obsoleto (`version`)**
* **Problema:** A chave `version: "3.8"` no topo do arquivo.
* **Por quê:** Nas versões recentes do Docker Compose (Compose V2), a especificação do formato passou a ser unificada (*Compose Specification*). A tag `version` tornou-se obsoleta e gera avisos informando que é desnecessária.
* **Correção:** Remover a linha `version: "3.8"` do topo do arquivo.

### **2. Ausência de persistência de dados no Banco (`volumes`)**
* **Problema:** O serviço `banco` não possui um mapeamento de volume persistente.
* **Por quê:** O sistema de arquivos de um contêiner é efêmero. Sem um volume montado no diretório de dados do PostgreSQL, todos os dados salvos serão perdidos se o contêiner for removido ou recriado.
* **Correção:** Declarar um volume nomeado na raiz e associá-lo ao caminho `/var/lib/postgresql/data` dentro do serviço `banco`.

### **3. Faltando teste de integridade no Banco (`healthcheck`)**
* **Problema:** O serviço `banco` não possui uma instrução de `healthcheck`.
* **Por quê:** O Docker não consegue saber se o PostgreSQL já terminou de inicializar internamente e está pronto para receber conexões, sabendo apenas se o processo do contêiner iniciou.
* **Correção:** Adicionar a seção `healthcheck` usando o comando `pg_isready -U loja -d loja` para verificar o estado real da aplicação.

### **4. Endereço do banco incorreto na API (`DATABASE_URL`)**
* **Problema:** A variável da API usa `DATABASE_URL: postgres://loja:senha@localhost:5432/loja`.
* **Por quê:** Dentro do contêiner da `api`, a palavra `localhost` aponta para a sua própria interface de rede de loopback, e não para o contêiner do banco. O Compose possui DNS interno onde os serviços se encontram pelo próprio nome do serviço.
* **Correção:** Alterar o endereço de `localhost` para o nome do serviço: `postgres://loja:senha@banco:5432/loja`.

### **5. Dependência fraca no `depends_on` da API**
* **Problema:** A instrução no serviço `api` está usando a sintaxe simples `depends_on: - banco`.
* **Por quê:** A sintaxe simples apenas garante a ordem de inicialização (inicia o contêiner do banco milissegundos antes), mas não espera o PostgreSQL aceitar conexões, fazendo a API quebrar na subida por falta de conexão.
* **Correção:** Usar a sintaxe expandida do `depends_on` com `condition: service_healthy`.

---

## Parte 2 - Trecho Crítico Corrigido (`banco` e `api`)

```yaml
services:
  banco:
    image: postgres:16
    environment:
      POSTGRES_USER: loja
      POSTGRES_PASSWORD: senha
      POSTGRES_DB: loja
    volumes:
      - dados_postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U loja -d loja"]
      interval: 5s
      timeout: 5s
      retries: 5

  api:
    build: ./api
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgres://loja:senha@banco:5432/loja
    depends_on:
      banco:
        condition: service_healthy

volumes:
  dados_postgres:
````

Parte 3 - O Chapéu do Cético (Compose em Produção na Black Friday)
- Mesmo com o arquivo 100% corrigido, utilizar apenas o Docker Compose para segurar o pico de acesso da Black Friday representa um risco altíssimo por conta de seus limites arquiteturais:

1- Limitação de Servidor Único (Single-Host / Ponto Único de Falha): O Docker Compose roda por padrão em uma única máquina física ou virtual. Se a CPU do host esgotar ou a VM travar durante o pico de 20x no tráfego, toda a loja (front-end, API e banco) sairá do ar simultaneamente sem qualquer alta disponibilidade entre nós.

2- Falta de Auto-Escalonamento e Atualizações sem Pausa (Autoscaling e Rolling Updates): O Compose não possui inteligência para aumentar ou diminuir réplicas automaticamente baseando-se no consumo de CPU/memória ao longo do dia, nem oferece mecanismos nativos de rolling update com rollback automático caso um novo deploy falhe durante a operação da Black Friday.
