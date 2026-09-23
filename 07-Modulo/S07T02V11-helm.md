1. boxes.yaml

````yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: equipe-boxes
  labels:
    app: boxes
spec:
  replicas: 2
  selector:
    matchLabels:
      app: boxes
  template:
    metadata:
      labels:
        app: boxes
    spec:
      containers:
      - name: boxes
        image: meu-primeiro-dockerfile:v2
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080
          name: http
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
---
apiVersion: v1
kind: Service
metadata:
  name: boxes-interno
spec:
  selector:
    app: boxes
  ports:
  - port: 80
    targetPort: http
````
2. boxes-ingress.yaml

````yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: boxes-ingress
spec:
  ingressClassName: traefik
  rules:
  - host: boxes.gridstart.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: boxes-interno
            port:
              number: 80
````

3. boxes-route.yaml

````yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: boxes-route
spec:
  parentRefs:
  - name: portaria
    namespace: traefik
  hostnames:
  - "boxes.gridstart.local"
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: boxes-interno
      port: 80
````

4. httproute-quebrado.yaml (Versão Corrigida)

````yaml
# ATIVIDADE S07T02V11 - Versão Corrigida
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: quebrado-um
spec:
  parentRefs:
  - name: portaria
    namespace: traefik
  hostnames: ["um.gridstart.local"]
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: boxes-interno
      port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: quebrado-dois
spec:
  parentRefs:
  - name: portaria
    namespace: traefik
  hostnames: ["dois.gridstart.local"]
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: boxes-interno
      port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: quebrado-tres
spec:
  parentRefs:
  - name: portaria
    namespace: traefik
  hostnames: ["tres.gridstart.local"]
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: boxes-interno
      port: 80
````
````
# Respostas da Atividade - S07T02V11

## Parte 1.5 - Escolha de Exposição
Manteria a **HTTPRoute**, pois o Gateway API desacopla a infraestrutura de borda (gerenciada via Gateway/GatewayClass) das regras de roteamento das aplicações, além de oferecer um status nativo rico e padronizado para diagnóstico direto via `kubectl`.

---

## Parte 2.4 - Tabela de Diagnóstico

| Rota | Qual é o defeito | Qual comando revelou | Sintoma HTTP | A correção |
| :--- | :--- | :--- | :--- | :--- |
| **quebrado-um** | Aponta para um Gateway inexistente (`gateway-principal` em vez de `portaria`). | `kubectl get httproute quebrado-um -o jsonpath='{.status.parents}'` | 404 Not Found | Alterar o `parentRefs.name` para `portaria`. |
| **quebrado-dois** | Aponta para a porta do Pod (`8080`) e não para a porta exposta pelo Service (`80`). | `kubectl describe httproute quebrado-dois` (ou inspecionando o status de `ResolvedRefs`) | 500 Internal Server Error | Alterar `backendRefs[0].port` de `8080` para `80`. |
| **quebrado-tres** | O casamento de caminho foi definido como `Exact: /pitstop`, rejeitando rotas derivadas ou requisições na raiz. | `curl -s -o /dev/null -w "%{http_code}\n" http://tres.gridstart.local/pitstop` vs sem o path, e `kubectl get httproute quebrado-tres -o yaml` | 404 Not Found (ao acessar `/`) | Mudar o tipo do path de `Exact` para `PathPrefix` com o valor `/` (para cobrir qualquer requisição sob `/pitstop`). |

---

## Parte 3 - Regras Órfãs no Gateway API
Uma `HTTPRoute` que aponta para um Gateway inexistente não gera erro ao ser criada porque a API do Kubernetes valida apenas a sintaxe do manifesto, enquanto o controle de adoção depende de um controller ativo declarando posse sobre ela. No Gateway API isso incomoda muito menos que no Ingress porque a rota expõe seu ciclo de vida no bloco `.status.parents`, indicando explicitamente se foi ou não aceita por algum Gateway.
````

- Passos de Verificação do Terminal
- Adicionar os hostnames no /etc/hosts:

````bash
echo "127.0.0.1 boxes.gridstart.local um.gridstart.local dois.gridstart.local tres.gridstart.local" | sudo tee -a /etc/hosts
````

- Validação do Passo 1.4:
````bash
for h in gridstart.local gridstart.local/rival boxes.gridstart.local; do
  echo -n "$h -> "; curl -s -o /dev/null -w "%{http_code}\n" "http://$h"
done
````
-Saída esperada:
````
gridstart.local -> 200
gridstart.local/rival -> 200
boxes.gridstart.local -> 200
````
- Validação do Passo 2.5:

````
for h in um dois tres; do
  echo -n "$h -> "; curl -s -o /dev/null -w "%{http_code}\n" "http://$h.gridstart.local/pitstop"
done
````
- Saída esperada:

````
um -> 200
dois -> 200
tres -> 200
````
