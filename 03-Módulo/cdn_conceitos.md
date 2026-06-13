# Parte 1 — Fixação de conceitos (responda com suas próprias palavras)

1. O que é RTT e por que ele é a métrica central para entender o problema que a CDN resolve?
* **Resposta** -> RTT (Round Trip Time) o tempo que pacote leva para sair, chegar no destino e o retorno da resposta até origem.
2. Explique a diferença entre origin server e edge server. Qual o papel de cada um no fluxo de uma
requisição com CDN?
* **Resposta** -> Origin server é o local que é hospedado o objeto e edge server é servidor alocado em multi regiões que aloca cache de cópia do objeto, dominuindo o tempo de fluxo.
3. O que é um PoP (Point of Presence)? Por que CDNs têm centenas de PoPs enquanto as regiões cloud
são dezenas?
* **Resposta** -> PoP é o local físico onde ficam os edge servers de uma CDN e quantos mais POPs cada região estiver menor é latência para user final. Regiões cloud
são dezenas porque é caro manter o data center com infra conpleta, então pops em regiões se torna melhor para entrega do serviço. 

4. Descreva com suas palavras o que acontece em um cache hit e o que acontece em um cache miss. Qual dos dois você quer que aconteça na maioria das requisições?
* **Resposta** ->cache hit são cópias do objeto em determoinadas regiões para diminiur a latência da requisição e cache miss é quando não é encontrado uma cópia do objeto na região e é neessário buscar na origin place.

# Parte 2 — Análise de cenário

5. Uma startup brasileira tem todos os seus servidores em sa-east-1 (São Paulo). O produto está
crescendo e chegando usuários da Europa e Sudeste Asiático. Os usuários europeus reclamam que a
aplicação está lenta.
* **Resposta** -> Devido a distância o tempo de retorno ficam maior acima dos 200ms, sendo necessário um cache hit com edge sever mais próximo da região para poder diminuir o tempo de resposta. Requisições Dinâmicas e Processamento no Banco de Dados: A CDN não consegue resolver a lentidão de dados que mudam em tempo real. 

6. Um desenvolvedor diz: "CDN é só pra grandes empresas. Meu sistema tem 500 usuários, não preciso
disso."
Você concorda ou discorda? Justifique sua resposta com base no que foi visto nesta aula.
* **Resposta** -> Descordo, porque no cenário atual a sua necessidade ao ponto de vista dele é considerado funcional, sendo que, em um cenário com aumento de users em outras regiões, vai aumentar a latência no requests e sendo a necessário o uso de CDN. 
  
# Parte 3 — Relacionando com cloud

7. Preencha a tabela abaixo identificando o papel de cada camada da infraestrutura cloud:
Camada Para que serve

Availability Zone sa-east-1a

| Camada | Exemplo na AWS | Para que serve |
| :--- | :---: | ---: |
| Região  |sa-east-1 |Serve para alocação de data center com disponibilidades de multi zonas com datacenter físicos |
| Availability Zone  |sa-east-1a |Serve para alocação de serviços, app e outras em determinadas zonas dentro da mesma região |
| Edge Location — | Asia|Edge server comtribui para criação de uma cópia em cache hit do serviço dentro das zonas e a regição |

 
8. Por que uma empresa não substitui suas regiões e AZs por edge locations, já que existem muito mais
edge locations no mundo?
* **Resposta** -> Edge locations são otimizadas para cache e entrega de conteúdo e não para executar aplicações, serviços e etc.  
