# Atividade - Qual Decisão de Pipeline Evita o Caos Operacional?

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Analisar três decisões diferentes de como a Achei.app estrutura o CI/CD dos seus microsserviços e apontar qual delas evita o problema de automação manual e divergente descrito no vídeo, aplicando o critério de padronização de esteira (pipeline como modelo reutilizável, não como artefato criado do zero a cada serviço)[cite: 17].  
**Tipo:** Diagnóstico + reflexão escrita — sem terminal, sem comando real, sem nome de ferramenta de CI/CD específica[cite: 17].  
**Tempo estimado:** 10-15 minutos[cite: 17]  
**Entrega:** Respostas escritas às três questões abaixo[cite: 17].

---

## Contexto (cenário fictício)

A Achei.app já tem seus cinco microsserviços rodando de forma independente (Identidade, Catálogo, Carrinho, Pagamento e Notas Fiscais — V07 e V08), cada um com sua própria esteira de entrega[cite: 17]. O time de Ops está revisando como cada uma dessas cinco esteiras foi criada, porque um sexto serviço está a caminho e alguém precisa decidir como ele vai entrar nessa estrutura[cite: 17].

---

## Questões

### 1. A esteira do "copia e ajusta"
Quando o serviço de Carrinho foi criado, o time copiou a esteira que já existia para o Catálogo e ajustou manualmente os nomes de pasta, a porta e o comando de teste[cite: 17]. Quando o serviço de Pagamento foi criado depois, o time repetiu o processo — copiou a esteira do Carrinho e ajustou de novo, na mão[cite: 17]. Hoje, as cinco esteiras existentes têm pequenas diferenças de estrutura entre si, e não existe nenhum documento explicando por que cada uma é como é[cite: 17]. Considerando o critério visto no vídeo, essa forma de criar esteiras representa o problema descrito (automação manual e divergente) ou a solução (padronização)? Justifique[cite: 17].

> **Resposta fictícia:** Essa abordagem representa perfeitamente o problema da **automação manual e divergente**[cite: 17]. Embora o time esteja usando ferramentas de automação para rodar o pipeline, o processo de *construção* e *manutenção* dessas esteiras ainda é artesanal e manual[cite: 17]. Copiar, colar e ajustar configurações na mão inevitavelmente gera mutações de código ("drift"), fazendo com que cada microsserviço tenha uma esteira ligeiramente diferente e irreprodutível[cite: 17]. No longo prazo, isso cria um pesadelho de manutenção, pois uma correção global ou melhoria na esteira exigiria alterar manualmente os cinco (ou mais) arquivos individuais, recriando o mesmo caos operacional de scripts espalhados[cite: 17].

### 2. O modelo único com parametrização
O time de Ops, antes de criar a esteira do sexto serviço, decide parar e construir um modelo único de pipeline: um padrão comum de build, teste e deploy que qualquer serviço novo usa, alterando apenas alguns parâmetros específicos dele (qual comando builda, qual comando testa, qual caminho de deploy)[cite: 17]. As cinco esteiras antigas ainda não foram migradas para esse modelo, mas todo serviço novo a partir de agora nasce a partir dele[cite: 17]. Considerando o mesmo critério, essa decisão resolve o problema descrito no vídeo? Ela resolve completamente, ou só parcialmente? Justifique[cite: 17].

> **Resposta fictícia:** Esta decisão resolve o problema **apenas parcialmente**[cite: 17]. A estratégia está conceitualmente correta ao introduzir a padronização e o reaproveitamento por meio de templates parametrizáveis (tratando o pipeline como um modelo reutilizável)[cite: 17]. No entanto, a resolução é parcial porque o ecossistema da Achei.app agora ficou "híbrido" e legado: as cinco esteiras antigas continuam divergentes e operando no modelo antigo de risco[cite: 17]. O problema só será completamente mitigado quando o time definir um plano para migrar e refatorar as esteiras dos serviços antigos para que consumam este novo modelo parametrizado[cite: 17].

### 3. O pipeline único "inteligente"
Uma alternativa proposta por outro membro do time é manter um único pipeline central, só que mais sofisticado: ele detecta automaticamente qual pasta do repositório mudou e decide, internamente, qual dos seis serviços precisa ser buildado e publicado naquela execução[cite: 17]. Não existem seis esteiras — existe uma esteira só, com lógica condicional para decidir o que publicar[cite: 17]. Essa proposta entrega o mesmo ganho de deploy independente, frequente e de blast radius reduzido que o vídeo descreveu para esteiras separadas por serviço? Justifique, comparando com o que foi visto sobre blast radius em V02 e neste vídeo[cite: 17].

> **Resposta fictícia:** Não, essa proposta quebra o princípio de manter um **blast radius reduzido** e o deploy verdadeiramente independente[cite: 17]. Ao centralizar a inteligência e as condicionais de todos os microsserviços em um único pipeline monolítico, o time cria um ponto único de falha crítico (Single Point of Failure). Se alguém cometer um erro de sintaxe ou de lógica condicional nessa esteira centralizada enquanto altera o fluxo do serviço de Catálogo, por exemplo, o *blast radius* se estende a todos os outros serviços, travando os deploys de Identidade, Carrinho e Pagamento instantaneamente. O ideal é que cada serviço tenha o seu próprio ciclo de execução isolado, mesmo que eles reutilizem um modelo padronizado sob o capô[cite: 17].

---

**Dica de pit stop:** A pergunta central de hoje não é "existe um pipeline?" — é "esse pipeline é reaproveitável ou foi reinventado na mão?"[cite: 17]. Releia o trecho do vídeo sobre o script shell copiado e ajustado manualmente de máquina em máquina antes de responder, e aplique o mesmo raciocínio às três situações acima[cite: 17].
