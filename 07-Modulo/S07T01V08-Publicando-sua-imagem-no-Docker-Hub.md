# Atividade Prática: Publicando a Imagem Segura no Docker Hub (V08)

Relatório de tagueamento, autenticação via Personal Access Token (PAT), publicação (*push*) e validação pública (*pull*) da imagem Docker enxuta e não-root.

---

## 📌 1. Links e Dados de Publicação

* **Link Público no Docker Hub:** [https://hub.docker.com/r/silvio69luiz/demo-multistage](https://hub.docker.com/r/silvio69luiz/demo-multistage)[cite: 18]
* **Imagem/Tag Oficial:** `silvio69luiz/demo-multistage:1.0.0`
* **Usuário / Namespace:** `silvio69luiz`

---

## 🚀 2. Prova de Publicação e Download (`docker pull`)

Após taguear, realizar o *push* para o registry e remover a cópia local da imagem (`docker rmi`), o download a partir do Docker Hub foi efetuado com sucesso:

```bash
devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker tag seguranca-demo:segura silvio69luiz/demo-multistage:1.0.0
devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker push silvio69luiz/demo-multistage:1.0.0
The push refers to repository [docker.io/silvio69luiz/demo-multistage]
44136fa355b3: Pushed
6523a2a1df9e: Pushed
25f1d6b1951a: Pushed
8c88304b6c81: Pushed
0a38a4f6fea4: Pushed
de67e695e713: Pushed
3f88bccab479: Pushed
1.0.0: digest: sha256:13dc2e2e701e000b6bbb829319e7ea586b40ee813c4351fa934186e9b802aa30 size: 856

devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker rmi silvio69luiz/demo-multistage:1.0.0
Untagged: silvio69luiz/demo-multistage:1.0.0

devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker pull silvio69luiz/demo-multistage:1.0.0
1.0.0: Pulling from silvio69luiz/demo-multistage
Digest: sha256:13dc2e2e701e000b6bbb829319e7ea586b40ee813c4351fa934186e9b802aa30
Status: Downloaded newer image for silvio69luiz/demo-multistage:1.0.0
docker.io/silvio69luiz/demo-multistage:1.0.0
````

<img width="1481" height="728" alt="image" src="https://github.com/user-attachments/assets/ffe5578c-f5f6-40dd-934f-a79f7ec0fd58" />

## Perguntas de Reflexão
* Pergunta 1: Explique por que autenticar com um access token é mais seguro do que usar a senha principal da conta (cite pelo menos duas vantagens).
* Utilizar um Personal Access Token (PAT) é significativamente mais seguro por aplicar o princípio do menor privilégio. As duas principais vantagens são:
- Revogação Granular: Caso o token vazando em uma esteira de CI/CD ou máquina local seja comprometido, é possível revogá-lo instantaneamente no Docker Hub sem precisar alterar a senha principal da conta nem afetar outros sistemas.
- Escopo Limitado de Permissão: É possível criar tokens com permissões restritas (ex apenas write/push ou apenas read/pull), impedindo que um acesso indevido altere configurações da conta, faturamento ou exclua repositórios.

* Pergunta 2 Explique por que depender da tag :latest em produção é arriscado usando a ideia de que latest é um apelido móvel.
- A tag :latest não garante imutabilidade; ela é apenas um ponteiro (apelido móvel) que aponta para a última imagem enviada sem tag de versão explícita. Em ambientes de produção, utilizar :latest impede a rastreabilidade da versão real em execução.
