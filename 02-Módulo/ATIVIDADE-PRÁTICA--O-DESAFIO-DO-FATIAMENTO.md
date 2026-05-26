### O CENÁRIO:
1- Imagine que você foi contratado para construir um aplicativo completo de delivery de comida — do zero. O cliente quer tudo:
- cadastro de usuário, cardápio, carrinho, pagamento, rastreamento de pedido e avaliação com estrelinhas.

````
Tentar entregar esse app inteiro de uma só vez seria um Big Bang Deploy clássico. Se algo der errado na virada, você não sabe onde está
o problema.
````

* **O QUE FAZER:**
Divida esse app em 3 lotes (fatias) menores que pudessem ser colocados em produção um de cada vez — gerando valor e testando o ambiente com segurança.

---

- **LOTE 1**
  - *O que vai nessa primeira fatia? Por que primeiro?*
  - **Resposta:** A página com a apresentação do cardápio e toda a estrutura com os produtos que serão visualizados nos pedidos na plataforma, contendo fotos, descrições e a avaliação com estrelinhas.

---

- **LOTE 2**
  - *O que vai no segundo lote? O que ele depende do Lote 1?*
  - **Resposta:** Criação do banco de dados que possa alocar a base de usuários (com login e senha), criação de um banco de dados NoSQL para o armazenamento das fotos dos produtos e a estruturação do app com a funcionalidade de destacar os produtos no carrinho.

---

- **LOTE 3**
  - *O que fecha a entrega? O que só faz sentido depois dos dois anteriores?*
  - **Resposta:** Implementar o sistema de pagamento, a proteção de dados sensíveis dos usuários com base na lei da LGPD e o sistema de autenticação de pagamento. Também serão atribuídas as funcionalidades que melhoram a interação do app, como:
    - API de rastreio da encomenda em tempo real;
    - Ressarcimento de valores indevidos ou falta do produto, caso seja a escolha do cliente;
    - Vouchers de desconto sob demanda para clientes fiéis (fidelidade).
"""
