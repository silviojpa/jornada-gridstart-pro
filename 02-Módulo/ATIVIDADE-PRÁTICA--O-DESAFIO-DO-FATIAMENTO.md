### O CENÁRIO:
1- Imagine que você foi contratado para construir um aplicativo completo de delivery de comida — do zero. O cliente quer tudo:
- cadastro de usuário, cardápio, carrinho, pagamento, rastreamento de pedido e avaliação com estrelinhas.

````
Tentar entregar esse app inteiro de uma só vez seria um Big Bang Deploy clássico. Se algo der errado na virada, você não sabe onde está
o problema.
````

* **O QUE FAZER**
Divida esse app em 3 lotes (fatias) menores que pudessem ser colocados em produção um de cada vez — gerando valor e testando
o ambiente com segurança.

- LOTE 1
  - O que vai nessa primeira fatia? Por quê primeiro?
* **resposta** A página com a apresentção do cardápio e toda estrutura com todos os produtos que serão visualizada nos pedidos na plataforma com fotos, descrisções e avaliação com estrelinhas. 

--- 
- LOTE 2
 - O que vai no segundo lote? O que ele depende do Lote 1?
* **resposta** Criação de DB que possa alocar a base de users com (login e senha), Criação DB NoSQL para armazenamento das fotos dos produtos e estruturar app com a funcionalidade de destacar os produtos no carrinho.

---
- LOTE 3
 - O que fecha a entrega? O que só faz sentido depois dos dois anteriores?
* **resposta** Implementar o sistema de pagamento e dados sensiveis do users na lei de LGPD e sistema de autenticação de pagamento, atribuir as fucionalidades que melhora a interação do app.
* como: API de rastreio da escomenda em tempo real, ressarcimento de valores indevido ou falta do produto caso seja escolha do cliente, voucher de desconto sob demanda de comprar do mesmo cliente com fidelidade.
