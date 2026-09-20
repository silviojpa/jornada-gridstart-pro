# Atividade Prática - S07T02V08: Bote o seu piloto na pista (Declare o seu primeiro Pod)

Relatório de execução prática demonstrando a carga de imagens locais no **Kind**, criação e aplicação de manifestos YAML declarativos (`pod.yaml` e `pod-multi.yaml`), inspeção de telemetria e gerenciamento de múltiplos contêineres no mesmo Pod.

---

## 📄 Conteúdo dos Manifestos YAML

### 1. `pod.yaml` (Pod Simples)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: piloto-solo
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
2. pod-multi.yaml (Pod Multi-Contêiner com Volume Compartilhado)

````yaml
apiVersion: v1
kind: Pod
metadata:
  name: piloto-com-telemetria
spec:
  volumes:
    - name: trilha
      emptyDir: {}
  containers:
    - name: piloto
      image: meu-primeiro-dockerfile:v1
      imagePullPolicy: IfNotPresent
      command: ["sh", "-c"]
      args:
        - mkdir -p /trilha && while true; do echo "$(date +%H:%M:%S) volta completada" >> /trilha/telemetria.log; sleep 5; done
      volumeMounts:
        - name: trilha
          mountPath: /trilha

    - name: telemetria
      image: alpine:latest
      imagePullPolicy: IfNotPresent
      command: ["sh", "-c"]
      args:
        - touch /trilha/telemetria.log && tail -f /trilha/telemetria.log
      volumeMounts:
        - name: trilha
          mountPath: /trilha
````

## Execução e Evidências no Terminal
- Parte 1 & 2 — Carga da Imagem e Aparição do Pod piloto-solo (Print 1)
````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kind load docker-image meu-primeiro-dockerfile:v1 --name gridstart-lab
Image: "meu-primeiro-dockerfile:v1" with ID "sha256:671f336030cfbc1375def5ca46e0afd829e6094b39f92172a33cc1db8d3386fc" not yet present on node "gridstart-lab-control-plane", loading...

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl apply -f pod.yaml
pod/piloto-solo created

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get pod
NAME          READY   STATUS    RESTARTS   AGE
piloto-solo   1/1     Running   0          7s
````
## Parte 3 — Investigação do Pod piloto-solo (Events, Logs e Exec)
- Seção Events do kubectl describe pod piloto-solo (Print 2):

````
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  1m    default-scheduler  Successfully assigned default/piloto-solo to gridstart-lab-control-plane
  Normal  Pulled     1m    kubelet            Container image "meu-primeiro-dockerfile:v1" already present on machine
  Normal  Created    1m    kubelet            Created container piloto
  Normal  Started    1m    kubelet            Started container piloto
`````

- Confirmação dos Logs (kubectl logs piloto-solo):
````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl logs piloto-solo
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
Rodando dentro de um contêiner construído por mim.
````
## Parte 4 — O Pod Multi-Contêiner piloto-com-telemetria (Print 3)
````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl apply -f pod-multi.yaml
pod/piloto-com-telemetria created

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get pod
NAME                    READY   STATUS    RESTARTS   AGE
piloto-com-telemetria   2/2     Running   0          8s
piloto-solo             1/1     Running   0          10m
````
- Prova de Comunicação Entre Contêineres (Logs e Exec no Volume Compartilhado):
````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl logs piloto-com-telemetria -c telemetria
17:38:25 volta completada
17:38:30 volta completada
17:38:36 volta completada

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl exec piloto-com-telemetria -c telemetria -- ls -l /trilha
total 4
-rw-r--r-- 1 root root 1352 Sep 20 17:42 telemetria.log
````

## Parte 5 - Análise da Telemetria e Conceitos (Com as Minhas Palavras)
1- Por que o READY do primeiro Pod é 1/1 e o do segundo é 2/2?
  - A notação X/Y representa o número de contêineres prontos e em execução (X) sobre o total de contêineres declarados no Pod (Y). No piloto-solo, havia $1$ contêiner declarado e $1$ rodando; no piloto-com-telemetria, havia $2$ contêineres declarados (piloto e telemetria) e ambos atingiram o estado de prontidão.
2- O que os dois contêineres do piloto-com-telemetria compartilham por estarem no mesmo Pod?
  - Volume de Armazenamento: Ambos compartilham o mesmo volume do tipo emptyDir montado em /trilha, permitindo que o contêiner piloto escreva logs e o contêiner telemetria os leia em tempo real.
  - Rede/Namespace de Network: Eles compartilham o mesmo endereço IP e a mesma interface de rede (se comunicam via localhost e compartilham as mesmas portas).
3- Por que foi preciso sobrescrever o comando com um laço infinito? O que aconteceria se o processo terminasse?
  - O Kubernetes foi projetado para gerenciar aplicações de longa duração e monitora se o processo principal do contêiner está ativo. Se o comando não fizesse um laço infinito e o script/processo finalizasse, o contêiner entraria no estado Completed. O Kubernetes entenderia isso como um encerramento inesperado para uma aplicação e tentaria reiniciar o contêiner repetidamente, colocando o Pod em CrashLoopBackOff.

  - ## Parte 6 - Limpeza dos Recursos

````bash
devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl delete -f pod-multi.yaml
pod "piloto-com-telemetria" deleted from default namespace

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl delete -f pod.yaml
pod "piloto-solo" deleted from default namespace

devops@DESKTOP-22ULELT:~/silvio/fred-gridstart/loja-compose/kind$ kubectl get pods
No resources found in default namespace.
````
- Observação: Como um Pod isolado não possui um controlador (como um Deployment ou ReplicaSet) garantindo o seu estado desejado no cluster, ao deletar o manifesto do Pod, o Kubernetes simplesmente o encerra e não tenta recriá-lo automaticamente.
