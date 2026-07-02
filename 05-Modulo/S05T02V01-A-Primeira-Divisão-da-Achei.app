# Atividade - A Primeira Divisão da Achei.app

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar o critério de divisão por contexto de negócio (visto no vídeo) a um cenário concreto, propondo uma primeira divisão da Achei.app em microsserviços e justificando por que o critério usado é de negócio, e não de camada técnica[cite: 12].  
**Tipo:** Proposta de divisão + justificativa escrita — sem terminal, sem script[cite: 12].  
**Tempo estimado:** 10-15 minutos[cite: 12]  
**Entrega:** Respostas escritas às três questões abaixo[cite: 12].

---

## Contexto (cenário fictício)

A Achei.app continua crescendo[cite: 12]. Hoje, ela ainda roda como um único monolito, mas o time já decidiu: vai migrar para microsserviços[cite: 12]. Antes de qualquer ferramenta ou infraestrutura, alguém precisa responder uma pergunta simples — mas decisiva: em quantos pedaços dividir, e quais são eles?[cite: 12]

As funcionalidades atuais da Achei.app são[cite: 12]:
1. Busca e listagem de produtos (catálogo)[cite: 12]
2. Carrinho de compras do usuário[cite: 12]
3. Login e cadastro de usuários[cite: 12]
4. Processamento de pagamento via cartão[cite: 12]
5. Emissão de nota fiscal após a compra[cite: 12]

---

## Questões

### 1. Proposta de divisão
Com base nas 5 funcionalidades listadas, proponha quantos microsserviços a Achei.app deveria ter e dê um nome de negócio para cada um (ex: "serviço de Catálogo")[cite: 12]. Você pode juntar funcionalidades no mesmo serviço se elas representarem a mesma responsabilidade de negócio — mas justifique cada agrupamento[cite: 12].

> [1- Seviço de catalogo e carrinho de compras do usuário com frontend juntando a buscar com função GET e uma page de lista de produtos no carrinho. 2- Um banco de dados Postgres para alocar os metadados
dos usuário e check de ligon para acesso ao portal de produtos. 3- Uma page de front com funcionalidade de check de validação de cartão e armazenamento de dados sensiveis com a lei LGPD. 4- Uma função de emição
de nota ficais e log de dados referente as compras.]

### 2. Por que não é divisão por camada técnica?
Escolha um dos serviços que você propôs na questão 1 e explique, em poucas frases, por que ele representa uma responsabilidade de negócio completa (com lógica e dados próprios) — e não apenas uma fatia técnica (como "banco de dados" ou "interface") de algo maior[cite: 12].

> [Com a divisão dos microsseviços toda mudança realizada naquele serviço não impacta os demais de funcionar trazendo um individualidade de competência em cada camada sem prejuizo nos demais.]

### 3. Teste do "dono"
Pegue o serviço de Login/Cadastro de usuários[cite: 12]. Se ele cair completamente por algumas horas, quais das outras funcionalidades (catálogo, carrinho, pagamento, nota fiscal) você espera que continuem funcionando, e quais não?[cite: 12] Justifique com base no conceito de "cada serviço é dono do seu próprio pedaço"[cite: 12].

> [O que ficaria funcionando sem impacto seria o catálogo sem o login, mas os demais precisam de login paa ter acesso ao carrinho, pagamento e nota fical, porque depende de auteticação para realização dos demais serviços.]

---

**Dica de pit stop:** Se você sentir vontade de criar um serviço chamado "banco de dados" ou "API", pare e pergunte: "que responsabilidade de negócio esse nome representa?"[cite: 12] Se a resposta for "nenhuma, é só uma camada técnica", você está dividindo do jeito errado — volte e pense em termos do que aquele pedaço faz pelo negócio[cite: 12].
