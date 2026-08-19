## PARTE  — Perguntas de Fixação

1. Qual a diferença entre docker ps e docker ps -a?
Resposta:

* docker ps: Lista apenas os contêineres que estão atualmente em execução (STATUS: Up).

* docker ps -a (--all): Lista todos os contêineres do host, independentemente do seu estado atual (rodando, pausados ou interrompidos/Exited).

2. O que o docker stop faz de diferente em relação a simplesmente matar o processo na força?
* Resposta: O docker stop envia primeiramente um sinal de desligamento gracioso (SIGTERM) para o processo principal (PID 1) do contêiner, dando a ele um tempo limite (geralmente 10 segundos) para fechar conexões ativas, gravar logs, salvar estado ou finalizar transações pendentes. Se o processo não encerrar após essa janela, aí sim o Docker envia um SIGKILL para encerrá-lo forçadamente.

3. Por que o docker rm recusa remover um contêiner rodando? Como forçar e por que não é recomendado?
Resposta:

- Motivo: Recusa a remoção para prevenir a perda acidental de dados, corrupção de arquivos em escrita ou a interrupção abrupta de serviços em execução sem o encerramento correto.

- Como resolver sem stop: Usando a flag de remoção forçada docker rm -f <nome_ou_id>.

- Por que não é recomendado: Pois ela envia diretamente um sinal SIGKILL, matando os processos instantaneamente sem dar oportunidade de salvamento de dados ou desconexão segura de bancos de dados/clientes.

4. Papel dos 5 pacotes instalados no repositório oficial:
Resposta:

- docker-ce (Community Edition): O motor do Docker Daemon em si (dockerd), responsável por gerenciar imagens, contêineres, redes e volumes em segundo plano.

- docker-ce-cli: A interface de linha de comando (docker) utilizada para interagir e enviar instruções para o Docker Daemon através do socket Unix/REST API.

- containerd.io: O runtime de contêineres de alto nível (mecanismo que gerencia o ciclo de vida de contêineres, downloads de imagens e integração via OCI com o runc).

- docker-buildx-plugin: Extensão do Docker CLI que estende os recursos de build utilizando o BuildKit (permite builds concorrentes, suporte a multi-arquitetura e otimização de cache).

- docker-compose-plugin: Extensão que adiciona o comando docker compose nativamente no CLI para orquestrar e gerenciar múltiplos contêineres declarados em arquivos YAML (docker-compose.yml).
