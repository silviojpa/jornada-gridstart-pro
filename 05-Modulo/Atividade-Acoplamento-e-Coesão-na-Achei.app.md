# Atividade - Acoplamento e Coesão na Achei.app

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar os conceitos de coesão (vídeo de hoje) e acoplamento (vídeo de hoje) para diagnosticar três cenários de divisão de serviço já feitos na Achei.app — identificando quais estão bem desenhados e quais escondem o início de um monolito distribuído[cite: 13].  
**Tipo:** Diagnóstico + justificativa escrita — sem terminal, sem script[cite: 13].  
**Tempo estimado:** 10-15 minutos[cite: 13]  
**Entrega:** Respostas escritas às três questões abaixo[cite: 13].

---

## Contexto (cenário fictício)

A Achei.app já dividiu o sistema em 5 microsserviços (V03): Identidade, Catálogo, Carrinho, Pagamento e Notas Fiscais[cite: 13]. Agora o time quer ir além e está avaliando três decisões de divisão, propostas por três engenheiros diferentes[cite: 13]. Sua tarefa é avaliar cada uma usando coesão e acoplamento[cite: 13].

*   **Cenário A (proposta do Engenheiro 1):** Criar um serviço novo, chamado "Frete", que só calcula o valor do frete com base no CEP e no peso do produto, consultando uma tabela própria de regras de frete[cite: 13]. Quando o Carrinho precisa saber o valor do frete, ele faz uma chamada simples ao serviço de Frete e segue o próprio fluxo normalmente, mesmo que essa chamada demore ou falhe (esse caso já tem um tratamento previsto)[cite: 13].
*   **Cenário B (proposta do Engenheiro 2):** Juntar, num único serviço chamado "Checkout", toda a lógica de: validar o carrinho, calcular o frete, processar o pagamento e emitir a nota fiscal — tudo numa mesma base de código, com as tabelas de carrinho, pagamento e nota fiscal dentro do mesmo banco de dados, sem nenhuma separação interna entre essas quatro responsabilidades[cite: 13].
*   **Cenário C (proposta do Engenheiro 3):** Para concluir uma cobrança mais rápido, o serviço de Pagamento vai acessar diretamente o banco de dados interno do serviço de Notas Fiscais — sem passar por nenhuma interface ou contrato entre os dois porque "assim economiza uma etapa"[cite: 13].

---

## Questões

### 1. Cenário A
Avalie a coesão e o acoplamento do serviço de Frete proposto[cite: 13]. Ele está bem desenhado? Justifique usando os dois conceitos do vídeo[cite: 13].

> [Trazer essa funcionalidade para camada de carrinho e conulta a tabela poder ser uma ideia boa desde que consiga realmente trazer o resultado esperado, caso não seja possivel será cum coesão na finalização do compra.]

### 2. Cenário B
Identifique o problema de coesão no serviço "Checkout" proposto pelo Engenheiro 2[cite: 13]. Proponha como você dividiria essa lógica de volta em serviços coesos, e justifique cada divisão pelo critério de contexto de negócio (visto no vídeo anterior, S05T03V03)[cite: 13].

> [Juntar todas os STEPs em uma camada de seria uma questão arriscada porque na falta de uma funcionalidade não seria possivel finalizar a compra e gera frustação ao cliente final.]

### 3. Cenário C
Mesmo sendo dois serviços tecnicamente separados, por que a proposta do Engenheiro 3 é um sintoma de monolito distribuído?[cite: 13] Identifique o tipo de problema (coesão ou acoplamento) e explique, em termos de princípio — sem entrar em qual ferramenta ou protocolo usar — o que deveria acontecer no lugar dessa chamada direta ao banco de dados de outro serviço[cite: 13].

> [Princípio a aplicar: nenhum serviço deve acessar os dados ou o código interno de outro serviço diretamente. Cada serviço deve expor, por fora, uma forma própria e estável de ser "conversado" — e é só por essa forma
exposta que outros serviços devem interagir com ele, nunca por dentro.]

---

**Dica de pit stop:** Se a justificativa de uma divisão for "porque é mais rápido assim" ou "porque já existe ali", desconfie — isso, quase sempre, é acoplamento se infiltrando disfarçado de atalho[cite: 13].
