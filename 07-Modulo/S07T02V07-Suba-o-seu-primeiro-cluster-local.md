# Atividade Prática - S07T02V07: Suba o seu primeiro cluster local (Mão na Massa)

Relatório de execução prática do laboratório local utilizando **Kind** e **kubectl**, com validação de nós, pods de sistema e interpretação de telemetria.

---

## Parte 1 & 2 - Instalação, Criação e Validação do Cluster

### **1. Execução do Laboratório no Terminal**

```bash
devops@DESKTOP-22ULELT:~$ kind create cluster --name gridstart-lab
Creating cluster "gridstart-lab" ...
 ✓ Ensuring node image (kindest/node:v1.36.1) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-gridstart-lab"
You can now use your cluster with:

kubectl cluster-info --context kind-gridstart-lab

Have a nice day! 👋
````

2. Validação dos Nós (kubectl get nodes)

````bash
devops@DESKTOP-22ULELT:~$ kubectl get nodes
NAME                          STATUS   ROLES           AGE     VERSION
gridstart-lab-control-plane   Ready    control-plane   1m12s   v1.36.1
````

3. Validação dos Pods do Sistema (kubectl get pods -A)

````Bash
devops@DESKTOP-22ULELT:~$ kubectl get pods -A
NAMESPACE           NAME                                                  READY   STATUS    RESTARTS   AGE
kube-system         coredns-589f44dc88-ftqkc                              1/1     Running   0          50s
kube-system         coredns-589f44dc88-qwzmq                              1/1     Running   0          50s
kube-system         etcd-gridstart-lab-control-plane                      1/1     Running   0          59s
kube-system         kindnet-db6lb                                         1/1     Running   0          50s
kube-system         kube-apiserver-gridstart-lab-control-plane            1/1     Running   0          59s
kube-system         kube-controller-manager-gridstart-lab-control-plane   1/1     Running   0          59s
kube-system         kube-proxy-xr4jm                                      1/1     Running   0          50s
kube-system         kube-scheduler-gridstart-lab-control-plane            1/1     Running   0          59s
local-path-storage  local-path-provisioner-855c7b7774-czq55               1/1     Running   0          50s
````

## Parte 3 - Leitura da Telemetria
- Significado do Status Ready no kubectl get nodes:

  - O status Ready confirma que o nó está plenamente operacional, com a rede e os componentes base inicializados e aptos a receber workloads do Kubernetes.  
  - Componente responsável: A peça responsável por emitir esse relatório é o Kubelet. Ele roda como o capataz da máquina, verifica constantemente a integridade local e envia os relatórios de saúde (heartbeats) diretamente para o API Server.
 
## Identificação e Papel dos Pods de Sistema (kube-system):
1- kube-apiserver: 
- É a porta de entrada única do cluster. Valida e autentica todas as requisições e é a única peça que conversa diretamente com a base de dados (etcd).
2- etcd:
- É o banco de dados chave-valor que armazena a fonte única da verdade. Guarda tanto o estado desejado quanto o estado atual de todos os objetos do cluster.
3- kube-scheduler:
- É o estrategista de alocação. Filtra e pontua os nós disponíveis para decidir em qual máquina cada novo Pod deve ser executado.
4- kube-controller-manager:
- É o motor que executa os controladores do loop de reconciliação. Compara continuamente o estado real com o desejado para realizar correções automáticas.
5- kube-proxy:
- É o guardião de rede em cada nó. Mantém as regras de roteamento (ex.: iptables) para permitir a comunicação entre Pods e o acesso estável via Services.

## Parte 4 - Limpeza do Ambiente   
  - Comando executado para remover o cluster e liberar os recursos da máquina:

````Bash
devops@DESKTOP-22ULELT:~$ kind delete cluster --name gridstart-lab
Deleting cluster "gridstart-lab" ...
Deleted nodes: ["gridstart-lab-control-plane"]
````
