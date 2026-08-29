````bash
devops@DESKTOP-LUF8FTQ:~$ podman --version
podman version 4.9.3-minimal

devops@DESKTOP-LUF8FTQ:~$ podman run --rm hello-world
Resolved "hello-world" as an alias (/etc/containers/registries.conf.d/shortnames.conf)
Trying to pull docker.io/library/hello-world:latest...
Getting image source signatures
Copying blob 719385e32844 done  
Copying config c14030739f done  
Writing manifest to image destination
Hello from Docker!
This message shows that your installation appears to be working correctly.

devops@DESKTOP-LUF8FTQ:~$ podman run -d -p 8080:80 --name test-web nginx:alpine
Resolved "nginx" as an alias (/etc/containers/registries.conf.d/shortnames.conf)
Trying to pull docker.io/library/nginx:alpine...
Getting image source signatures
Copying blob 9750b6910e5d done  
Copying config 4c740751fa done  
Writing manifest to image destination
7c52a38b1d91207e8a9466e3b2e564d262d1921356e7921389e1b203c9a6231a

devops@DESKTOP-LUF8FTQ:~$ podman ps
CONTAINER ID  IMAGE                           COMMAND               CREATED        STATUS        PORTS                 NAMES
7c52a38b1d91  docker.io/library/nginx:alpine  nginx -g daemon o...  10 seconds ago Up 10 seconds 0.0.0.0:8080->80/tcp  test-web

devops@DESKTOP-LUF8FTQ:~$ podman stop test-web && podman rm test-web
7c52a38b1d91
7c52a38b1d91

devops@DESKTOP-LUF8FTQ:~$ alias docker=podman
devops@DESKTOP-LUF8FTQ:~$ docker --version
podman version 4.9.3-minimal

devops@DESKTOP-LUF8FTQ:~$ docker ps
CONTAINER ID  IMAGE  COMMAND  CREATED  STATUS  PORTS  NAMES

devops@DESKTOP-LUF8FTQ:~$ docker images
REPOSITORY                      TAG         IMAGE ID      CREATED      SIZE
docker.io/library/nginx         alpine      4c740751fa3a  2 days ago   43.4 MB
docker.io/library/hello-world   latest      c14030739f13  6 months ago 13.3 kB

devops@DESKTOP-LUF8FTQ:~/app-podman$ cat Dockerfile
FROM nginx:alpine
RUN echo "<h1>Hello Podman & Buildah</h1>" > /usr/share/nginx/html/index.html

devops@DESKTOP-LUF8FTQ:~/app-podman$ podman build -t meu-app:1.0.0 .
STEP 1/2: FROM nginx:alpine
STEP 2/2: RUN echo "<h1>Hello Podman & Buildah</h1>" > /usr/share/nginx/html/index.html
--> 2d86f1e63a12
COMMIT meu-app:1.0.0
--> 2d86f1e63a12
Successfully tagged localhost/meu-app:1.0.0
2d86f1e63a12a52b96e6761611fa67715f210d18b628373b79bf10e9803bf2b9

devops@DESKTOP-LUF8FTQ:~/app-podman$ podman images
REPOSITORY                      TAG         IMAGE ID      CREATED        SIZE
localhost/meu-app               1.0.0       2d86f1e63a12  15 seconds ago 43.4 MB
docker.io/library/nginx         alpine      4c740751fa3a  2 days ago     43.4 MB

devops@DESKTOP-LUF8FTQ:~/app-podman$ buildah --version
buildah version 1.34.2

devops@DESKTOP-LUF8FTQ:~/app-podman$ buildah bud -t meu-app:2.0.0 .
STEP 1/2: FROM nginx:alpine
STEP 2/2: RUN echo "<h1>Hello Podman & Buildah</h1>" > /usr/share/nginx/html/index.html
--> f482c191a92e
COMMIT meu-app:2.0.0
--> f482c191a92e
Successfully tagged localhost/meu-app:2.0.0
f482c191a92e542b89a421bc29a5921cbf7123aa1290bbfa710214a123bc65a1

devops@DESKTOP-LUF8FTQ:~/app-podman$ podman run --rm meu-app:2.0.0 cat /usr/share/nginx/html/index.html
<h1>Hello Podman & Buildah</h1>
````

# Atividade Prática: Além do Docker (Podman e Buildah) - V11

Relatório da execução prática abordando contêineres sem daemon (*daemonless*), a substituição transparente do CLI via *alias*, o *build* de imagens locais com Podman e a integração complementar usando o Buildah.

---

## 1. Instalação e Execução Sem Daemon (`Podman`)

* **Versão do Podman:** `podman version 4.9.3-minimal`
* **Execução `hello-world`:** Imagem obtida e contêiner executado com sucesso em modo não-root.
* **Execução Nginx:** Contêiner `test-web` iniciado com a porta `8080:80` exposta e encerrado via `podman stop/rm`.

---

## 2. Compatibilidade Docker CLI (`alias docker=podman`)

Criação do *alias* na sessão do terminal (`alias docker=podman`) comprovando a retrocompatibilidade com a sintaxe padrão do Docker:

```bash
$ docker --version
podman version 4.9.3-minimal

$ docker ps
CONTAINER ID  IMAGE  COMMAND  CREATED  STATUS  PORTS  NAMES

$ docker images
REPOSITORY                      TAG         IMAGE ID      CREATED      SIZE
docker.io/library/nginx         alpine      4c740751fa3a  2 days ago   43.4 MB
docker.io/library/hello-world   latest      c14030739f13  6 months ago 13.3 kB
````

## 3. Construção e Execução da Imagem com Podman (1.0.0)
  - Comando de compilação executado na pasta com a imagem tagueada como meu-app:1.0.0:

````bash
$ podman build -t meu-app:1.0.0 .
STEP 1/2: FROM nginx:alpine
STEP 2/2: RUN echo "<h1>Hello Podman & Buildah</h1>" > /usr/share/nginx/html/index.html
--> 2d86f1e63a12
COMMIT meu-app:2.0.0
Successfully tagged localhost/meu-app:1.0.0
````

## 4. Desafio: Construção com Buildah (2.0.0) e Execução com Podman
- Versão do Buildah: buildah version 1.34.2

- Compilação (buildah bud): Imagem tagueada como meu-app:2.0.0.

- Teste de Integração: O Podman executou transparentemente a imagem gerada pelo Buildah (compartilhando o mesmo armazenamento local cstorage):

````bash
$ buildah bud -t meu-app:2.0.0 .
STEP 1/2: FROM nginx:alpine
STEP 2/2: RUN echo "<h1>Hello Podman & Buildah</h1>" > /usr/share/nginx/html/index.html
--> f482c191a92e
COMMIT meu-app:2.0.0
Successfully tagged localhost/meu-app:2.0.0

$ podman run --rm meu-app:2.0.0 cat /usr/share/nginx/html/index.html
<h1>Hello Podman & Buildah</h1>
````

## 5. Perguntas de Reflexão
* Pergunta 13: Explique o que significa o Podman ser daemonless (modelo fork/exec) e duas vantagens de segurança disso — uma sobre ponto único de falha e outra sobre rootless.
* Ser daemonless significa que o Podman não mantém um serviço/processo central (daemon) rodando em segundo plano de forma contínua com privilégios de administrador. Ele adota o modelo clássico Unix de fork/exec, onde o comando podman cria o processo do contêiner diretamente como um filho do próprio processo invocador.

  - Sem Ponto Único de Falha: Se a ferramenta CLI falhar, se encerrar ou for atualizada, os contêineres que já estão rodando não caem, eliminando a dependência de um serviço centralizador como o dockerd.

  - Segurança Rootless Nativa: O contêiner roda inteiramente dentro do escopo e das permissões do usuário comum sem requerer acesso ao barramento root do sistema, impedindo ataques do tipo container escape que tentem tomar o controle do host.

* Pergunta 14: Explique a divisão de papéis entre Podman e Buildah (quem constrói e quem roda) e o que acontece por baixo quando você executa podman build.
  - O Buildah é uma ferramenta focada e especializada na criação e manipulação de imagens de contêiner (podendo construir a partir de Dockerfiles ou até scripts bash sem precisar de um Dockerfile), enquanto o Podman é especializado no gerenciamento do ciclo de vida dos contêineres (execução, rede, volumes e pods). Quando o comando podman build é executado, o Podman chama a biblioteca interna e a mecânica do Buildah por baixo para processar as instruções do Dockerfile e gerar as camadas da imagem no repositório local.
