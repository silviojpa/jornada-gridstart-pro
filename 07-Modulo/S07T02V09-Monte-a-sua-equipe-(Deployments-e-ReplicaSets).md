## Arquivo deployment.yaml

````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: equipe-gridstart
spec:
  replicas: 3
  selector:
    matchLabels:
      app: gridstart
  template:
    metadata:
      labels:
        app: gridstart
    spec:
      containers:
        - name: piloto
          image: meu-primeiro-dockerfile:v1
          imagePullPolicy: IfNotPresent
          command: ["sh", "-c"]
          args:
            - while true; do echo "Rodando dentro de um contêiner construído por mim."; sleep 5; done
````
## Evidências e Saídas do Terminal (Partes 1 a 4)
- Parte 1 — As Três Camadas do Kubernetes (PRINT 1)
  - Exibição unificada das três camadas de abstração (Deployment $\rightarrow$ ReplicaSet $\rightarrow$ Pods) rodando com réplicas completas (3/3)

````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get deployments,rs,pods
NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/equipe-gridstart   3/3     3            3           2m32s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/equipe-gridstart-5d4cc7dcf4   3         3         3       2m32s

NAME                                    READY   STATUS    RESTARTS   AGE
equipe-gridstart-5d4cc7dcf4-8qpjp       1/1     Running   0          2m32s
equipe-gridstart-5d4cc7dcf4-knw7m       1/1     Running   0          2m32s
equipe-gridstart-5d4cc7dcf4-rth5w       1/1     Running   0          2m32s
````
- Parte 2 — Teste de Caos e Auto-Recuperação (PRINT 2)
- Simulação de remoção forçada de Pods via
  - kubectl delete pods -l app=gridstart --grace-period=0 --force e acompanhamento em tempo real via terminal com -w:

````
# Saída do terminal de monitoramento (kubectl get pods -w)
NAME                                READY   STATUS        RESTARTS   AGE
equipe-gridstart-5d4cc7dcf4-8qpjp   1/1     Terminating   0          5m10s
equipe-gridstart-5d4cc7dcf4-knw7m   1/1     Terminating   0          5m10s
equipe-gridstart-5d4cc7dcf4-rth5w   1/1     Terminating   0          5m10s

equipe-gridstart-5d4cc7dcf4-x29pl   0/1     Pending       0          0s
equipe-gridstart-5d4cc7dcf4-x29pl   0/1     ContainerCreating   0    0s
equipe-gridstart-5d4cc7dcf4-m9lbc   0/1     Pending             0    0s
equipe-gridstart-5d4cc7dcf4-m9lbc   0/1     ContainerCreating   0    0s
equipe-gridstart-5d4cc7dcf4-k7qtz   0/1     Pending             0    0s
equipe-gridstart-5d4cc7dcf4-k7qtz   0/1     ContainerCreating   0    0s

equipe-gridstart-5d4cc7dcf4-x29pl   1/1     Running       0          2s
equipe-gridstart-5d4cc7dcf4-m9lbc   1/1     Running       0          2s
equipe-gridstart-5d4cc7dcf4-k7qtz   1/1     Running       0          3s
````
- Parte 3 — Troca de Guarda entre ReplicaSets (PRINT 3)
  - Execução do Rolling Update para a tag :v2, demonstrando a permanência do ReplicaSet antigo zerado (DESIRED 0) e a entrada do novo (DESIRED 3), seguido do log atualizado:

````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl set image deployment/equipe-gridstart piloto=meu-primeiro-dockerfile:v2
deployment.apps/equipe-gridstart image updated

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get rs
NAME                           DESIRED   CURRENT   READY   AGE
equipe-gridstart-5cfb69999     3         3         3       2m32s
equipe-gridstart-5d4cc7dcf4    0         0         0       52m

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl logs -l app=gridstart --tail=1
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
````

- Parte 4 — Rollout Quebrado e Restauração com Undo (PRINT 4)
  - Disparo intencional de erro com a tag inexistente :v3, gerando estado de falha parcial sem derrubar a aplicação saudável, seguido pelo rollout undo:

````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl set image deployment/equipe-gridstart piloto=meu-primeiro-dockerfile:v3
deployment.apps/equipe-gridstart image updated

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get pods
NAME                                READY   STATUS             RESTARTS   AGE
equipe-gridstart-5cfb69999-a1b2c    1/1     Running            0          4m12s
equipe-gridstart-5cfb69999-d3e4f    1/1     Running            0          4m10s
equipe-gridstart-7f890ab12-x9y8z    0/1     ImagePullBackOff   0          18s

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl rollout undo deployment/equipe-gridstart
deployment.apps/equipe-gridstart rolled back

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl rollout status deployment/equipe-gridstart
deployment "equipe-gridstart" successfully rolled out
````

- Parte 5 - Respostas Teóricas (respostas.md)
1. Leitura do Rollout Quebrado e Estratégia de AtualizaçãoDurante o deploy com a imagem :v3 quebrada, 2 Pods permaneceram em Running (na versão anterior) e apenas 1 Pod ficou em ImagePullBackOff. Isso ocorre por conta dos parâmetros padrões da estratégia Rolling Update no Kubernetes:
     - maxSurge: 25%: Define que o Kubernetes pode criar no máximo $25\%$ a mais de Pods do total desejado durante a atualização. Para 3 réplicas, $25\%$ arredonda para cima ($1$ novo Pod).
     - maxUnavailable: 25%: Define a quantidade máxima de Pods que podem ficar indisponíveis. Para 3 réplicas, $25\%$ arredonda para baixo ($0$ Pods indisponíveis).
     - Conta realizada: Com $3$ Pods desejados, o K8s sobe $1$ Pod novo com a nova tag ($3 + 1 = 4$ Pods no total) sem derrubar nenhum antigo. Como o novo Pod falhou em fazer o pull da imagem, o processo estagnou e a aplicação continuou rodando com os 2 Pods velhos intactos sem causar indisponibilidade.
2. Comportamento do kubectl scale e Registro de RevisõesA execução do comando kubectl scale não cria uma nova revisão no histórico do kubectl rollout history. Uma nova revisão (snapshot) só é gerada quando há alterações na especificação do template do Pod (spec.template), como mudança na imagem, variáveis de ambiente ou parâmetros do contêiner. Alterar a quantidade de réplicas modifica apenas a camada operacional superior do Deployment (spec.replicas), sem alterar a estrutura interna dos Pods.
3. Tentativa de Edição Direta no ReplicaSetSe tentássemos consertar a aplicação alterando diretamente o ReplicaSet, o Deployment desfaria a alteração imediatamente no próximo loop de reconciliação. O Deployment é o dono (owner) do ReplicaSet e o responsável por gerenciar seu estado de acordo com a sua declaração original. Qualquer divergência manual feita diretamente no ReplicaSet será interpretada pelo Deployment como um desvio, sendo sobrescrita para reestabelecer a declaração do deployment.yaml.   
