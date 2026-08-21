# Multistage Build Demo (Go)

Relatório prático de implementação de **Multistage Build** para otimização de imagens Docker utilizando uma aplicação em Go.

---

## 📌 1. Análise dos Resultados e Comparativo de Tamanho

| Métrica | Imagem Single-Stage (`gigante`) | Imagem Multistage (`enxuta`) |
| :--- | :--- | :--- |
| **Content Size** | 319 MB | 7.7 MB |
| **Disk Usage** | 1.31 GB | 23.3 MB |

### Diferença Prática
* **Redução em MB:** A imagem final ficou **311.3 MB menor** (considerando o *content size*).
* **Fator de Redução:** A imagem enxuta ficou aproximadamente **41,4 vezes menor** que a imagem single-stage original.

---

## ⚠️ 2. Diagnóstico da Execução e Solução

Ao tentar executar o comando `curl http://localhost:8080`, o contêiner enxuto finalizou imediatamente com status `Exited (255)`:

```bash
8201c07de0b1  multistage-demo:enxuta  "./servidor"  Exited (255)
````

-----------------------------------
### Causa Raiz
* Binários compilados em ambientes glibc (como na imagem base golang:1.22 baseada em Debian) falham ao rodar em distribuições que utilizam musl libc (como o Alpine), resultando em falhas de execução por dependências dinâmicas ausentes.

### Solução (Dockerfile.multistage)
* Para resolver o problema, basta desativar o CGO e definir a compilação estática com as variáveis CGO_ENABLED=0 e GOOS=linux.

````Dockerfile
# Estágio 1 — Builder (Ambiente de Compilação)
FROM golang:1.22 AS builder
WORKDIR /app
COPY . .

# Compilação estática sem dependências de CGO/libc
RUN CGO_ENABLED=0 GOOS=linux go build -o servidor .

# Estágio 2 — Imagem Final (Execução Leve)
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/servidor .
EXPOSE 8080
CMD ["./servidor"]
````

* Passo a passo de validação:
````Bash
docker build -f Dockerfile.multistage -t multistage-demo:enxuta .
docker run -d --name demo-enxuta -p 8080:8080 multistage-demo:enxuta
curl http://localhost:8080
````

Saída esperada: Servidor rodando dentro de uma imagem enxuta.

3. Perguntas de Reflexão
* Pergunta 10: O que exatamente a linha COPY --from=builder transfere para a imagem final e o que fica para trás?
- A instrução COPY --from=builder transfere apenas o binário compilado (servidor) gerado no primeiro estágio. Todo o ecossistema do SDK do Go (compilador, código-fonte original, dependências e bibliotecas do sistema operacional base) permanece no estágio builder e é descartado na imagem final.

* Pergunta 11: Relacione o tamanho menor com os benefícios de Custo e Segurança.
- Custo: A redução expressiva no tamanho da imagem acelera o tempo de build/deploy nas pipelines CI/CD, economiza largura de banda de rede e reduz o custo de armazenamento em Container Registries e nós de clusters Kubernetes.

* Segurança: Ao eliminar o SDK do Go e utilizar uma imagem base Alpine mínima, removemos utilitários, pacotes e ferramentas desnecessárias do sistema. Isso reduz drasticamente a superfície de ataque da aplicação e minimiza a exposição a vulnerabilidades conhecidas (CVEs).
