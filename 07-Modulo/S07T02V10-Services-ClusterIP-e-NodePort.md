## Estrutura de Arquivos para Entrega

<img width="341" height="161" alt="image" src="https://github.com/user-attachments/assets/c4f4411e-5cf3-4e31-a62c-6907ed31ffa9" />

## Parte 1 — Manifestos YAML (Subindo a Equipe Rival)
1. deployment-rival.yaml
````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: equipe-rival
spec:
  replicas: 2
  selector:
    matchLabels:
      app: rival
  template:
    metadata:
      labels:
        app: rival
    spec:
      containers:
        - name: piloto
          image: meu-primeiro-dockerfile:v2
          imagePullPolicy: IfNotPresent
          ports:
            - name: http
              containerPort: 8080
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
          command: ["sh", "-c"]
          args:
            - while true; do echo "<h1>Equipe Rival</h1><p>Servido pelo Pod: $POD_NAME</p>" > index.html && python3 -m http.server 8080; done
````
2. service-rival-interno.yaml
````yaml
apiVersion: v1
kind: Service
metadata:
  name: rival-interno
spec:
  type: ClusterIP
  selector:
    app: rival
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: http
````
3. service-rival-externo.yaml
````yaml
apiVersion: v1
kind: Service
metadata:
  name: rival-externo
spec:
  type: NodePort
  selector:
    app: rival
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: http
      nodePort: 30081
````
## Comandos para Execução e Provas da Parte 1
- Execute os comandos abaixo no seu terminal para aplicar os recursos:
````bash
# 1. Aplicar a nova aplicação e seus serviços
kubectl apply -f deployment-rival.yaml
kubectl apply -f service-rival-interno.yaml
kubectl apply -f service-rival-externo.yaml

# 2. Prova 1: Conferir todos os Pods e suas Labels (3 gridstart + 2 rival)
kubectl get pods --show-labels

# 3. Prova 2: Conferir todos os Services ativos
kubectl get svc

# 4. Prova 3: Verificar que rival-interno tem exatamente 2 endpoints
kubectl describe svc rival-interno

# 5. Prova 4: Verificar que gridstart-interno continua isolado com exatamente 3 endpoints
kubectl describe svc gridstart-interno

# 6. Prova 7: Testar conectividade de dentro do cluster via curl
kubectl run curl-teste --rm -it --image=curlimages/curl:8.15.0 --restart=Never -- sh
# Dentro do pod de testes execute:
curl http://rival-interno
curl http://gridstart-interno
exit
````
- Para os itens 5 e 6 das provas (Navegador), abra no seu navegador local http://localhost:30080 (GridStart) e http://localhost:30081 (Equipe Rival).

## Documento RESPOSTAS.md (Partes 2 e 3)
- Você pode salvar o conteúdo abaixo diretamente no seu arquivo
````
# Respostas da Atividade Prática - S07T02V10

## PARTE 2 — Diagnóstico do Service Defeituoso

O manifesto `service-rival-defeituoso.yaml` apresenta os três erros abaixo:

### Defeito 1: `nodePort: 8081` (Porta inválida / Fora da faixa permitida)
* **Localização:** Linha do campo `nodePort`.
* **Sintoma:** **Erro no momento da criação/aplicação.** O Kubernetes rejeita a criação do objeto imediatamente ao executar `kubectl apply -f service-rival-defeituoso.yaml`. O comando falha com uma mensagem do API Server informando que a porta `8081` está fora da faixa padrão de NodePorts (`30000-32767`).
* **Correção:** Alterar `nodePort: 8081` para uma porta válida no range padrão, como `nodePort: 30081`.

### Defeito 2: `selector: app: rivais` (Selector com valor incorreto)
* **Localização:** Linha do campo `selector`.
* **Sintoma:** O Service **é criado com sucesso**, mas fica **inoperante silenciosamente**. Ao rodar `kubectl describe svc rival-defeituoso`, o campo `Endpoints` exibirá `<none>`. O tráfego direcionado ao Service resultará em *Timeout* ou erro de conexão, pois o Kubernetes não encontra Pods com a label `app=rivais` (já que a label correta nos Pods é `app=rival`).
* **Correção:** Alterar `app: rivais` para `app: rival`.

### Defeito 3: `targetPort: 80` (Porta de destino errada no contêiner)
* **Localização:** Linha do campo `targetPort`.
* **Sintoma:** O Service **é criado** e mapeia os Endpoints dos Pods na porta 80 (ex: `10.244.0.X:80`), mas as requisições falham com `Connection Refused`. Ao inspecionar os Endpoints com `kubectl describe svc rival-defeituoso`, nota-se que os IPs aparecem preenchidos, porém apontam para a porta 80 do Pod, enquanto a aplicação Python/HTTP escuta e roda na porta `8080`.
* **Correção:** Alterar `targetPort: 80` para `targetPort: http` (ou numericamente `targetPort: 8080`).

---

## Versão Corrigida: `service-rival-defeituoso.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: rival-defeituoso
spec:
  type: NodePort
  selector:
    app: rival
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: http
      nodePort: 30081
````
## PARTE 3 — Escrita Curta

- Q1. Diferença entre port, targetPort e nodePort
  - port: É a porta interna exposta pelo próprio Service dentro do cluster. É onde outros Pods/Services farão requisições ao chamarem o DNS do Service.

  - targetPort: É a porta real em que o contêiner dentro do Pod está escutando a aplicação.

  - nodePort: É a porta aberta na interface de rede de cada nó físico/virtual do cluster, permitindo que tráfego externo acesse o Service vindo de fora do Kubernetes.

- A frase do colega confunde a porta em que a aplicação escuta no contêiner (targetPort) com a porta de abstração virtual apresentada pelo Service (port).

- Q2. Recriação de Pods, IP do Service e Endpoints
- Ao deletar os Pods e deixá-los recriar:

  - O ClusterIP do Service NÃO muda: Ele é um IP virtual estático e estável alocado pelo Kube-Proxy/API Server no momento em que o Service é criado, durando até sua exclusão.

  - Os Endpoints MUDAM: Os novos Pods recebem IPs epêmeros novos da rede do cluster. O objeto Endpoint/EndpointSlice é atualizado automaticamente pelo Kubernetes Control Plane assim que os novos Pods entram em estado Running e passam nos testes de prontidão.
 
- Q3. Vantagem de usar targetPort pelo Nome (http) em vez do Número (8080)
  - A abstração por nome desacopla a definição de rede do Service da implementação do contêiner.
  - Cenário concreto: Se a equipe de desenvolvimento atualizar a imagem da aplicação alterando a porta interna de 8080 para 9000, basta atualizar a declaração containerPort: 9000 (nome: http) no deployment.yaml. Todos os Services que utilizam targetPort: http continuarão funcionando perfeitamente sem precisar de nenhuma alteração nos seus arquivos de manifesto YAML.

- Q4. Motivos para NÃO expor 12 microsserviços via NodePort
  - Gargalo de Gerenciamento de Portas: O intervalo de NodePorts é restrito (30000-32767), gerando rápido esgotamento e riscos de conflito de portas entre aplicações.

  - Segurança e Exposição Desnecessária: Cada NodePort abre a porta indicada em todos os nós do cluster, aumentando drasticamente a superfície de ataque exposta à rede.

  - Complexidade de DNS e Roteamento Externo: Clientes externos teriam que memorizar portas não padrão para cada serviço (ex: app1.com:30001, app2.com:30002), além de exigir regras manuais de firewall e Load Balancer externo para cada novo serviço adicionado.
