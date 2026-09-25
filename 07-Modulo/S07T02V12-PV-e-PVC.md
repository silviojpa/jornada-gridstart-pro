# Atividade Prática - S07T02V12: PV e PVC
Manifestos YAML (Partes 1 e 2)
1. pvc-equipe.yaml (Parte 1.1)

````yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dados-equipe
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "standard"
  resources:
    requests:
      storage: 2Gi
`````
2. pv-arquivo-morto.yaml (Parte 2.2)

````yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-arquivo-morto
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ""
  hostPath:
    path: /mnt/arquivo-morto
````
3. pvc-arquivo-morto.yaml (Parte 2.2)

````yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-arquivo-morto
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ""
  volumeName: pv-arquivo-morto
  resources:
    requests:
      storage: 1Gi
````
4. pvc-quebrado-corrigido.yaml (Parte 3.5)

````yaml
# pvc-quebrado-corrigido.yaml
# PVC 01: StorageClass ajustada para "standard" (existente no Kind)
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: quebrado-01
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "standard"
  resources:
    requests:
      storage: 1Gi
---
# PVC 02: Ajustado para ReadWriteOnce (rancher.io/local-path não suporta RWX)
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: quebrado-02
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "standard"
  resources:
    requests:
      storage: 1Gi
---
# PVC 03: Ajustado tamanho para 1Gi para caber nos recursos de teste
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: quebrado-03
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "standard"
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: consumidor-01
spec:
  containers:
    - name: app
      image: busybox:stable
      imagePullPolicy: IfNotPresent
      command: ["sh", "-c", "sleep 3600"]
      volumeMounts:
        - name: dados
          mountPath: /dados
  volumes:
    - name: dados
      persistentVolumeClaim:
        claimName: quebrado-01
---
apiVersion: v1
kind: Pod
metadata:
  name: consumidor-02
spec:
  containers:
    - name: app
      image: busybox:stable
      imagePullPolicy: IfNotPresent
      command: ["sh", "-c", "sleep 3600"]
      volumeMounts:
        - name: dados
          mountPath: /dados
  volumes:
    - name: dados
      persistentVolumeClaim:
        claimName: quebrado-02
---
apiVersion: v1
kind: Pod
metadata:
  name: consumidor-03
spec:
  containers:
    - name: app
      image: busybox:stable
      imagePullPolicy: IfNotPresent
      command: ["sh", "-c", "sleep 3600"]
      volumeMounts:
        - name: dados
          mountPath: /dados
  volumes:
    - name: dados
      persistentVolumeClaim:
        claimName: quebrado-03
````

- Comandos e Sequência para Prints (Partes 1.4, 2.1 e 2.2)
- Print 1: Prova de Persistência em 3 passos (Parte 1.4)

````bash
# Passo 1: Escrever data e hora
kubectl exec $(kubectl get pods -l app=gridstart -o jsonpath='{.items[0].metadata.name}') -- sh -c 'date > /dados/data-teste.txt'

# Passo 2: Deletar o Pod
kubectl delete pod $(kubectl get pods -l app=gridstart -o jsonpath='{.items[0].metadata.name}')

# Passo 3: Confirmar persistência no Pod novo após recriação pelo Deployment
kubectl exec $(kubectl get pods -l app=gridstart -o jsonpath='{.items[0].metadata.name}') -- cat /dados/data-teste.txt
````

- Print 2: Cenário A - Delete (Antes e Depois) (Parte 2.1)

````bash
# Antes de deletar
docker exec gridstart-lab-control-plane find /var/local-path-provisioner -maxdepth 2

# Exclusão do PVC
kubectl delete pvc dados-equipe

# Depois de deletar (o diretório dinâmico deve sumir do nó)
docker exec gridstart-lab-control-plane find /var/local-path-provisioner -maxdepth 2
````

- Parte 3 — Tabela e Análise de Diagnóstico
- 3.3 — Tabela de Defeitos do pvc-quebrado.yaml

<img width="763" height="359" alt="image" src="https://github.com/user-attachments/assets/2ebae6a6-4cdd-4e26-bc43-cc7d48cb6af2" />

- 3.4 — A Pegadinha
- Qual é o terceiro defeito? O quebrado-03 (storageClassName: em branco).
- Qual era a outra causa que produzia a mesma mensagem? O comportamento normal do pvc-dinamico de aguardar a criação do Pod para realizar o bind vinculativo via politica WaitForFirstConsumer.
- Comando adicional para distinguir: kubectl get pvc quebrado-03 -o jsonpath='{.spec.storageClassName}' (revela que a chave está vazia em vez de conter o padrão "standard").

- 3.5 — Defeito Sem Conserto no Ambiente Local
- Incompatibilidade: O recurso quebrado-02 exige o modo ReadWriteMany (RWX).
- Motivo: O provisionador do Kind (rancher.io/local-path) é focado em nós locais baseados em sistema de arquivos HostPath, suportando estritamente volumes ReadWriteOnce (RWO).
- Solução em Nuvem: Em nuvens como AWS ou GCP, a resolução seria atribuir uma StorageClass suportada por sistemas de arquivos gerenciados em rede (por exemplo, AWS EFS via driver CSI efs.csi.aws.com ou Google Filestore) que fornecem acesso leitura/escrita concorrente a múltiplos nós.

## Documento RESPOSTAS.md
- Parte 1.5 — Localização do PV
- Nome do PV: pvc-c49c83d4-bde3-481d-a5ff-0f07627b9d28
- Caminho no nó: /var/local-path-provisioner/pvc-c49c83d4-bde3-481d-a5ff-0f07627b9d28_default_pvc-dinamico
- nodeAffinity transcrito:

````yaml
nodeAffinity:
  required:
    nodeSelectorTerms:
    - matchExpressions:
      - key: kubernetes.io/hostname
        operator: In
        values:
        - gridstart-lab-control-plane
````
- Parte 2.3 — Reaproveitamento de PV com Política Retain
  - Status do PV: Released.

  - Coluna CLAIM: Continua apontando para default/pvc-arquivo-morto antigo. Isso ocorre porque o atributo spec.claimRef mantém a referência ao PVC que o originou para evitar sobrescrita acidental de dados não apagados.
  - Arquivo no nó: Sim, o arquivo /mnt/arquivo-morto continua íntegro no nó.
  - Tentar acasalar novo PVC: O novo PVC não faz o bind. O describe pvc exibirá a mensagem indicando que não há PVs elegíveis disponíveis.
  - Para tornar o PV reutilizável: É necessário editar o PV manualmente para remover o bloco spec.claimRef (usando kubectl edit pv pv-arquivo-morto ou via kubectl patch), fazendo com que o status mude de Released para Available.

- Parte 2.4 — Análise: Delete vs. Retain
  - A escolha depende da criticidade do dado: Retain é a escolha ideal para bancos de dados de produção e armazenamento corporativo sensível, pois previne perda total caso um operador cometa um equívoco ao deletar o PVC. O custo de manter o Retain é a necessidade de intervenção humana (como a limpeza do claimRef) para reaproveitamento do volume.

- Parte 3.3, 3.4 e 3.5 — Diagnóstico de Defeitos
  - (Vide as tabelas e análises da seção "Parte 3 — Tabela e Análise de Diagnóstico" acima).

- Parte 4 — Entendimento do WaitForFirstConsumer
  - Um PVC em estado Pending com a política WaitForFirstConsumer não indica erro de infraestrutura; representa um diferimento planejado pelo Kubernetes para adiar a criação do volume até a identificação do nó em que o Pod consumidor será alocado. Isso impede que o volume seja criado prematuramente em uma zona de disponibilidade ou nó incompatível com as restrições e requisitos de afinidade do Pod.
