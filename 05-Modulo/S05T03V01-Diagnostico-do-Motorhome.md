# Atividade - Diagnóstico do Motorhome

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar o conceito de arquitetura monolítica visto no vídeo a um cenário fictício, identificando o que está empacotado junto e levantando uma hipótese — não a resposta final — sobre onde nasce o primeiro ponto de atrito conforme o sistema cresce.  
**Tipo:** Diagnóstico + hipótese escrita sem terminal, sem script.  
**Entrega:** Respostas escritas às três questões abaixo.

---

## Contexto (cenário fictício)

A startup Achei.app lançou um aplicativo de busca de produtos em lojas locais. Hoje, toda a aplicação roda como um único pacote: o site que o usuário acessa, a lógica que busca produtos no banco de dados, o sistema de login e o processamento de pagamento via cartão tudo no mesmo código-fonte, deployado de uma vez só, num único servidor.

A empresa tem 3 desenvolvedores. O app tem 800 usuários ativos por mês.

---

## Questões

### 1. O que está empacotado junto?
Liste, com base na descrição acima, quais partes da aplicação Achei.app estão vivendo dentro do mesmo "motorhome" (mesmo pacote/deploy/processo).

> [A empresa sustenta 3 ações dentro da aplicação, 1- Consulta de informações dentro do banco de dados, 2- Sistema de login das informações de metadado pessoas e 3- Checkin de dados sensiveis dentro de uma banco de dados especifico.]

### 2. Qual vantagem do monolito se aplica aqui e por quê?
Das duas vantagens reais do monolito vistas no vídeo (**simplicidade de deploy** ou **facilidade de teste**), escolha uma e explique, usando os números do cenário (3 devs, 800 usuários), por que ela faz sentido pro tamanho atual da Achei.app.

> [Para esse cenário a aplicação pode funcionar de forma sustentável, porque a capacidade de users são moderada pra pequena e con isso se torna mais fácil de da um stop ou migrar pra backup cado seja necessário.]

### 3. Hipótese: onde nasce o primeiro atrito?
Sem resolver o problema ainda — só levantando hipótese — em qual situação futura você imagina que esse modelo de "tudo junto" pode começar a incomodar a equipe da Achei.app? *(Pense em crescimento de usuários, de equipe, ou de funcionalidades.)*

> [Em um 1-cenário que possa acontencer uma falha no sistema de GET ou POST o DB trava e para de trazer as informações do banco de dados, será necessário para toda aplicação para verificar o corrido.
> 2-cenário uma nova função foi implementado para consultar via API outra loja que fez ampliar a quantidade de produtos na busca para de retornar o REQUEST ou muda o PATH de origem, será necessário para todo serviçao para analisar o ocorrido.]

---

**Dica de pit stop:** Não existe resposta errada na questão 3 — o ponto da atividade é praticar o raciocínio de "onde o motorhome aperta", não adivinhar o conteúdo do próximo vídeo.
