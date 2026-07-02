# Atividade - Onde Está o Custo Oculto? Auditando a Comunicação da Achei.app

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Analisar três decisões de comunicação entre os microsserviços da Achei.app e apontar qual delas representa maior risco de custo oculto, aplicando o critério visto no vídeo: a nova unidade de cobrança (tempo de execução + volume de rede), o tráfego entre serviços (Data Egress) e a frequência de chamadas a banco de dados[cite: 16].  
**Tipo:** Diagnóstico + reflexão escrita — sem terminal, sem comando real, sem console de cloud[cite: 16].  
**Tempo estimado:** 10-15 minutos[cite: 16]  
**Entrega:** Respostas escritas às três questões abaixo[cite: 16].

---

## Contexto (cenário fictício)

A Achei.app já tem seus cinco microsserviços rodando (Identidade, Catálogo, Carrinho, Pagamento e Notas Fiscais), cada um com seu próprio banco e se comunicando por API e mensageria (V07 e V08)[cite: 16]. O time de arquitetura já decidiu, no vídeo passado, onde usar Serverless[cite: 16]. Agora a mesma equipe está revisando três decisões de comunicação entre serviços, procurando risco de custo oculto antes de ir para produção[cite: 16].

---

## Questões

### 1. Catálogo chama Identidade em toda visualização de produto
Toda vez que qualquer visitante — logado ou não — abre a página de um produto no Catálogo, o serviço de Catálogo faz uma chamada de rede ao serviço de Identidade só para validar o token de sessão, mesmo quando o visitante está navegando como anônimo e essa validação não muda o conteúdo exibido[cite: 16]. A Achei.app recebe um volume alto de visualizações de produto por dia[cite: 16]. Considerando o critério visto no vídeo (unidade de cobrança e frequência de chamada), essa decisão representa risco de custo oculto? Justifique[cite: 16].

> **Resposta:** Sim, representa um altíssimo risco de custo oculto. O fator crítico aqui é a frequência de chamadas desnecessárias ativando a unidade de cobrança em um ambiente de alto tráfego. Se o usuário é anônimo e o resultado da validação não altera a página, o sistema está desperdiçando poder computacional e gerando custos de rede bilionários à toa. Para mitigar isso, a validação de sessão deveria acontecer apenas em rotas autentic.

### 2. Pagamento aciona Notas Fiscais só na compra finalizada
O serviço de Pagamento dispara uma única chamada ao serviço de Notas Fiscais exatamente no instante em que uma compra é confirmada, para gerar o PDF da nota[cite: 16]. Não existe nenhuma chamada entre os dois serviços fora desse evento específico, e o volume de compras finalizadas por dia é uma fração pequena do volume de visualizações de produto[cite: 16]. Considerando o mesmo critério da questão anterior, essa decisão representa risco de custo oculto? Justifique[cite: 16].

> **Resposta:** Não, o risco de custo oculto aqui é pequeno. Este cenário representa o uso ideal da infraestrutura distribuída: a comunicação possui baixa frequência e está diretamente atrelada a um evento de negócio de alto valor.

### 3. Catálogo em uma região, Carrinho em outra
Por uma decisão histórica de infraestrutura, o serviço de Catálogo está hospedado em uma região de nuvem diferente da região onde o Carrinho está hospedado[cite: 16]. Toda vez que um cliente adiciona um produto ao carrinho, o Carrinho busca no Catálogo os dados completos do produto incluindo as imagens em alta resolução para exibir no resumo do carrinho, em vez de buscar apenas os campos de texto necessários (nome, preço, ID)[cite: 16]. Considerando o critério visto no vídeo (volume de rede e Data Egress entre regiões), essa decisão representa risco de custo oculto? Justifique[cite: 16].
- Obs: Resposta da IA
> **Resposta:** Sim, representa um risco crítico e silencioso de custo oculto focado no volume de dados. Provedores de nuvem cobram taxas caras de transferência de dados para fora de uma região (Data Egress entre regiões diferente)[cite: 16]. Trafegar binários pesados, como imagens em alta resolução, de uma ponta geográfica para a outra a cada adição de item no carrinho vai inflar a fatura de rede rapidamente. O correto seria o Carrinho requisitar apenas metadados textuais leves (ID, nome, preço) e deixar o cliente carregar as imagens diretamente de uma rede de distribuição de conteúdo (CDN) ou de um bucket público local.

---

**Dica de pit stop:** O critério de hoje tem duas faces, não uma só: frequência da chamada (quantas vezes isso acontece) e volume de dados por chamada (quanto peso cada chamada carrega)[cite: 16]. Releia o trecho do vídeo sobre Egress entre serviços e sobre chamadas excessivas a banco antes de responder e preste atenção em qual das duas faces cada cenário ativa.
