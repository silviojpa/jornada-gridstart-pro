# Atividade Prática: Autenticação e Push de Imagens Privadas no AWS ECR (V09)

Relatório de criação de repositório privado no Amazon ECR, autenticação via AWS CLI com IAM, tagueamento com a URI completa e publicação (*push*) da imagem segura.

---

##  1. Informações do Repositório Privado

* **ID da Conta AWS:** `592667671603`
* **Região AWS:** `us-east-1`
* **Nome do Repositório:** `silvio-luiz/gridstart-demo`
* **Repository URI:** `592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo`

---

##  2. Autenticação e Push no Amazon ECR

### **Autenticação no Registry:**
```bash
devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 592667671603.dkr.ecr.us-east-1.amazonaws.com

WARNING! Your credentials are stored unencrypted in '/home/devops/.docker/config.json'.
Configure a credential helper to remove this warning. See
[https://docs.docker.com/go/credential-store/](https://docs.docker.com/go/credential-store/)

Login Succeeded
````
* Tagueamento e Push da Imagem:
````bash
devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker tag seguranca-demo:segura [592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo:1.0](https://592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo:1.0)

devops@DESKTOP-LUF8FTQ:~/silvio/fred/meu-primeiro-dockerfile$ docker push [592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo:1.0](https://592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo:1.0)
The push refers to repository [[592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo](https://592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo)]
8c88304b6c81: Pushed 
44136fa355b3: Pushed 
25f1d6b1951a: Pushed 
6523a2a1df9e: Pushed 
0a38a4f6fea4: Pushed 
de67e695e713: Pushed 
3f88bccab479: Pushed 
1.0: digest: sha256:13dc2e2e701e000b6bbb829319e7ea586b40ee813c4351fa934186e9b802aa30 size: 856
````

* Private repositories
<img width="1649" height="286" alt="image" src="https://github.com/user-attachments/assets/52c82554-2d92-4619-a60c-2abe74773953" />

* silvio-luiz/gridstart-demo

<img width="1908" height="526" alt="image" src="https://github.com/user-attachments/assets/7e0705e0-011f-477e-a0fb-e7f08a188b59" />

3. Prova de Presença no ECR (aws ecr list-images)
Saída esperada do comando de verificação via AWS CLI para validar a tag 1.0 no repositório remoto:

<img width="1461" height="301" alt="image" src="https://github.com/user-attachments/assets/9f53504d-cf18-49e7-92b6-f94089e396e1" />

4. Encerramento e Limpeza
Comando executado ao final da atividade para deletar o repositório privado no ECR e evitar custos indesejados:

<img width="1472" height="267" alt="image" src="https://github.com/user-attachments/assets/d8940b7a-63e5-4699-a062-0437437cd318" />

5. Perguntas de Reflexão:
* Pergunta 1: Explique por que o ECR usa um token temporário via IAM em vez de um usuário e senha fixos como o Docker Hub e qual a vantagem de segurança disso.
  - O ECR utiliza tokens temporários (com validade de 12 horas) gerados via IAM para eliminar o uso de credenciais estáticas de longo prazo armazenadas em disco. A principal vantagem de segurança é a diminuição drástica do impacto em caso de vazamento de credenciais em pipelines ou máquinas de desenvolvimento, já que o token expira automaticamente e todas as ações ficam estritamente limitadas às políticas e auditorias (via CloudTrail) da identidade IAM.
* Pergunta 2: Explique por que a imagem precisa ser taggeada com a URI completa do repositório antes do push (o que o docker push faz com essa tag).
  - O comando docker push não possui um parâmetro isolado para definir o endereço do servidor remetente; ele analisa o prefixo da tag aplicada na imagem para identificar o destino. Ao taguear a imagem com a URI completa (592667671603.dkr.ecr.us-east-1.amazonaws.com/silvio-luiz/gridstart-demo:1.0), o Docker CLI sabe exatamente qual endpoint da AWS deve contatar, qual porta utilizar e em qual repositório armazenar as camadas enviadas.  
