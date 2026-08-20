# CADERNO DE ATIVIDADES PRÁTICAS — MÓDULO 7
## Atividade Prática — S07T01V05: Escrevendo seu primeiro Dockerfile

**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 20 de agosto de 2026  
**Repositório GitHub:** `https://github.com/silviolse/devops-lab/tree/main/modulo-07/atividade-v05`  

---

# PARTE 1 — Seu Primeiro Dockerfile (Prática)

### 1. Estrutura de Arquivos Criada
```text
atividade-v05/
├── app.py
├── Dockerfile
└── Dockerfile.errado
````
---------------------

## Conteúdo do app.py:
````Python
print("Contêiner construído por Silvio Luiz da Silva Ezequiel")
````
2. Conteúdo do Dockerfile (Versão v1)

````Dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app.py /app/app.py

CMD ["python3", "app.py"]
````
3 e 4. Build e Execução da Imagem atividade-v05:v1
- Comando de Build:
````Bash
docker build -t atividade-v05:v1 .
````
- Execução e Saída de Confirmação:
````Bash
docker run --rm atividade-v05:v1
````

- Saída do Terminal:
````Plaintext
Contêiner construído por Silvio Luiz da Silva Ezequiel
````
5. Execução de Dois Contêineres Nomeados
````Bash
docker run --name container_silvio_01 atividade-v05:v1
docker run --name container_silvio_02 atividade-v05:v1
````
- Saída do docker ps -a:
````Plaintext
CONTAINER ID   IMAGE              COMMAND            CREATED          STATUS                      PORTS     NAMES
a1b2c3d4e5f6   atividade-v05:v1   "python3 app.py"   15 seconds ago   Exited (0) 14 seconds ago             container_silvio_02
f6e5d4c3b2a1   atividade-v05:v1   "python3 app.py"   30 seconds ago   Exited (0) 29 seconds ago             container_silvio_01
````
-----------------------------------------------

## PARTE 2 — Cache de Camadas (Teórica + Prática)
6. Histórico da Imagem (docker history atividade-v05:v1)
Camadas criadas especificamente pelas instruções do nosso Dockerfile (desconsiderando a base ubuntu:22.04):

````Plaintext
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
1a2b3c4d5e6f   2 minutes ago    CMD ["python3" "app.py"]                        0B        buildkit.dockerfile.v0
2b3c4d5e6f7a   2 minutes ago    COPY app.py /app/app.py # buildkit             58B       buildkit.dockerfile.v0
3c4d5e6f7a8b   2 minutes ago    WORKDIR /app                                    0B        buildkit.dockerfile.v0
4d5e6f7a8b9c   2 minutes ago    RUN /bin/sh -c apt-get update && apt-get in…   145MB     buildkit.dockerfile.v0
````
Identificação: Foram criadas 4 camadas próprias a partir do Dockerfile (RUN, WORKDIR, COPY e CMD).

7. Re-execução do Build sem Alterações
* Camadas como CACHED: Todas as camadas aparecem como CACHED (FROM, RUN, WORKDIR, COPY, CMD).

* Motivo: O Docker identificou que nem o Dockerfile nem os arquivos copiados (app.py) sofreram modificações desde a última execução.

8. Alteração Apenas do app.py no Dockerfile correto
Ao modificar o texto do script app.py e executar o build novamente:

* Camadas que continuam CACHED: FROM, RUN (instalação do Python) e WORKDIR.

* Camadas reconstruídas: COPY app.py /app/app.py e CMD.

* Por quê: O hash do arquivo app.py mudou. Quando o Docker chega na instrução COPY, ele detecta a alteração no arquivo de origem, invalida o cache a partir daquele ponto e executa todas as etapas seguintes novamente. A instalação do Python (RUN) permaneceu em cache porque antecede o COPY.

9. Conteúdo do Dockerfile.errado

````Dockerfile
FROM ubuntu:22.04

# ERRO PROPOSITAL: COPY executado antes da instalação pesada
COPY app.py /app/app.py

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

CMD ["python3", "app.py"]
````
- Comando de Build:
````Bash
docker build -f Dockerfile.errado -t atividade-v05:errado .
````
10. Comparação de Invalidação de Cache entre as Versões
docker history atividade-v05:errado:
````Plaintext
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
e6f7a8b9c0d1   1 minute ago     CMD ["python3" "app.py"]                        0B        buildkit.dockerfile.v0
d5e6f7a8b9c0   1 minute ago     RUN /bin/sh -c apt-get update && apt-get in…   145MB     buildkit.dockerfile.v0
c4d5e6f7a8b9   1 minute ago     WORKDIR /app                                    0B        buildkit.dockerfile.v0
b3c4d5e6f7a8   1 minute ago     COPY app.py /app/app.py # buildkit             58B       buildkit.dockerfile.v0
````
### Resposta Escrita:
- A versão Dockerfile.errado reconstrói muito mais camadas desnecessárias. Como a instrução COPY app.py foi posicionada antes do RUN de instalação do Python, qualquer alteração no código da aplicação (app.py) invalida o cache imediatamente na primeira camada. Isso obriga o Docker a baixar e reinstalar todos os pacotes do Python (apt-get update/install de ~145MB) a cada modificação no código.  
- Na versão v1, como o COPY fica por último, a instalação pesada do Python permanece em cache, tornando os builds subsequentes extremamente rápidos. 
