# Atividade Prática: Boas Práticas de Segurança em Docker (Não-Root + Limpeza de Cache)

Relatório de implementação e endurecimento (*hardening*) de uma imagem Docker *multistage*, garantindo a execução do contêiner sob um usuário sem privilégios administrativos e com higienização de *cache* nas camadas do *build*.

---

## 📌 1. Análise dos Resultados e Tamanho da Imagem

```bash
IMAGE                  ID             DISK USAGE   CONTENT SIZE
seguranca-demo:segura  13dc2e2e701e   25MB         7.99MB
````

- Content Size: 7.99 MB

- Disk Usage: 25 MB

- Status: Imagem extremamente leve e enxuta, mantendo o ecossistema enxuto da base Alpine.

-----------------------------------

2. Prova de Execução Não-Root (whoami)
- Para validar que o contêiner não é mais executado como root, executamos a verificação obrigatória:

````Bash
$ docker run --rm seguranca-demo:segura whoami
````
- "app"

- Resultado: O comando retornou app, confirmando que os privilégios de superusuário foram revogados com sucesso.

📜 3. Conteúdo do Dockerfile.seguro
````Dockerfile
# Estágio 1 — O caminhão-oficina (pesado): compila o binário
FROM golang:1.22 AS builder
WORKDIR /app

# Instalação de dependências e limpeza de cache do apt na mesma camada
RUN apt-get update \
 && apt-get install -y --no-install-recommends git \
 && rm -rf /var/lib/apt/lists/*

COPY . .
RUN go build -o servidor .

# Estágio 2 — O carro esportivo (leve): recebe só o binário, roda sem root
FROM alpine:3.20

# Instalação no Alpine usando a flag para evitar armazenamento de cache
RUN apk add --no-cache ca-certificates

# Criação do grupo e usuário do sistema (sintaxe do Alpine)
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# O binário é copiado enquanto ainda somos root
COPY --from=builder /app/servidor .

# Troca para o usuário não-root antes de subir a aplicação
USER app

CMD ["./servidor"]
````

4. Perguntas de Reflexão
* Pergunta 10: Explique por que rodar o contêiner como root é perigoso, usando o conceito de escape de contêiner.
- Rodar um contêiner como root significa que o processo dentro do isolamento possui UID 0. Caso um atacante explore uma vulnerabilidade na aplicação e consiga realizar um container escape (quebra de isolamento do namespace ou cgroup), ele chegará ao sistema operacional hospedeiro (host) diretamente com privilégios de superusuário (root), podendo comprometer todo o servidor, acessar dados de outros contêineres e alterar configurações da infraestrutura.

<img width="1391" height="183" alt="image" src="https://github.com/user-attachments/assets/0f758b43-15b1-4e89-99fd-eb00dd6ef001" />


* Pergunta 11: Explique por que limpar o cache num RUN separado do apt-get install não reduz o tamanho da imagem, usando o conceito de camada imutável.
- Como o Docker funciona com um sistema de arquivos em camadas imutáveis (read-only), cada instrução RUN gera uma nova camada que é gravada permanentemente na imagem final. Se a limpeza do cache (rm -rf /var/lib/apt/lists/*) for executada em um comando RUN separado, o cache baixado no apt-get update continuará salvo na camada anterior. O comando posterior apenas esconderá os arquivos no ponteiro da imagem, mas o tamanho em disco da camada antiga não será reduzido.
