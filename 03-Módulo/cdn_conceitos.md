# Parte 1 — Fixação de conceitos (responda com suas próprias palavras)

1. O que é RTT e por que ele é a métrica central para entender o problema que a CDN resolve?
* **Resposta** -> 
2. Explique a diferença entre origin server e edge server. Qual o papel de cada um no fluxo de uma
requisição com CDN?
* **Resposta** -> 
3. O que é um PoP (Point of Presence)? Por que CDNs têm centenas de PoPs enquanto as regiões cloud
são dezenas?
* **Resposta** -> 

4. Descreva com suas palavras o que acontece em um cache hit e o que acontece em um cache miss. Qual dos dois você quer que aconteça na maioria das requisições?
* **Resposta** ->

# Parte 2 — Análise de cenário

5. Uma startup brasileira tem todos os seus servidores em sa-east-1 (São Paulo). O produto está
crescendo e chegando usuários da Europa e Sudeste Asiático. Os usuários europeus reclamam que a
aplicação está lenta.
* **Resposta** -> 

* Qual é a causa raiz do problema?
* **Resposta** -> 
* Como uma CDN ajudaria?
* **Resposta** -> 
* O que a CDN não resolve nesse cenário? (pense no que não pode ser cacheado)
* **Resposta** -> 

6. Um desenvolvedor diz: "CDN é só pra grandes empresas. Meu sistema tem 500 usuários, não preciso
disso."
Você concorda ou discorda? Justifique sua resposta com base no que foi visto nesta aula.
* **Resposta** ->
  
# Parte 3 — Relacionando com cloud

7. Preencha a tabela abaixo identificando o papel de cada camada da infraestrutura cloud:
Camada Para que serve

Availability Zone sa-east-1a

| Camada | Exemplo na AWS | Para que serve |
| :--- | :---: | ---: |
| Região sa-east-1 | | |
| Availability Zone sa-east-1a | | |
| Edge Location — | | |

 
8. Por que uma empresa não substitui suas regiões e AZs por edge locations, já que existem muito mais
edge locations no mundo?
