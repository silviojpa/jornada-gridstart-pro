# Atividade - Diagnosticando o Problema que os Containers Resolvem na Achei.app

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Diagnosticar, sem usar nenhum comando ou ferramenta real, por que empacotar cada microsserviço numa máquina virtual completa não resolve o problema de portabilidade entre serviços escritos em linguagens diferentes, e descrever conceitualmente os requisitos de uma unidade de empacotamento ideal — usando a analogia do contêiner marítimo vista no vídeo[cite: 15].  
**Tipo:** Diagnóstico + reflexão escrita — sem terminal, sem comando Docker[cite: 15].  
**Tempo estimado:** 10-15 minutos[cite: 15]  
**Entrega:** Respostas escritas às três questões abaixo[cite: 15].

---

## Contexto (cenário fictício)

A Achei.app está com seus cinco microsserviços (Identidade, Catálogo, Carrinho, Pagamento e Notas Fiscais) já divididos desde V03, rodando em escala desde V05[cite: 15]. Agora, imagine que o time decidiu escrever cada serviço na linguagem que melhor resolve o problema dele[cite: 15]:

*   **Identidade:** Java[cite: 15]
*   **Catálogo:** Python[cite: 15]
*   **Carrinho:** Node.js[cite: 15]
*   **Pagamento:** Java[cite: 15]
*   **Notas Fiscais:** Python[cite: 15]

O time de operações precisa decidir como empacotar e rodar cada um desses serviços, em cada uma das centenas de instâncias que a Achei.app já roda desde V05[cite: 15].

---

## Questões

### 1. Por que a máquina virtual completa vira um problema aqui?
Considerando que cada serviço tem sua própria linguagem, versão e dependências, explique por que rodar uma máquina virtual completa pra cada instância — abordagem possível com poucas instâncias — se torna inviável quando você soma a multiplicação de instâncias vista em V05 com a diversidade de linguagens deste cenário[cite: 15].

> [O mais provável que vai acontecer é site nem rodar por causa das liguagem que atuam de forma forma e funções diferente vá quebrar for falta de compartibilidade e comunição]

### 2. Aplique a analogia do contêiner marítimo
No vídeo, o contêiner marítimo padroniza a interface de transporte (tamanho, encaixe), não o conteúdo (o que está sendo transportado)[cite: 15]. Usando essa mesma lógica, descreva — em linguagem conceitual, sem citar nenhuma ferramenta ou comando — o que precisaria ser padronizado para que o time de operações pudesse tratar o serviço de Identidade (Java) e o de Catálogo (Python) exatamente da mesma forma, sem precisar saber o que tem "dentro" de cada um[cite: 15].

> [Com os serviços rodando em containes separado e funcional, é fazer com que eles se comunique internamente com ip interno nos serviços]

### 3. Conecte com a Filosofia Unix
O vídeo conecta a ideia de empacotamento isolado com a Filosofia Unix ("uma coisa só, bem feita") já usada em V04 para coesão e acoplamento, e em V05 para automação[cite: 15]. Explique, com suas palavras, por que misturar vários microsserviços dentro da mesma máquina virtual — só para "economizar uma VM" — recria, na infraestrutura, o mesmo problema de acoplamento que o time já evitou no design dos serviços[cite: 15].

> [Fazendo dessa forma, estaremos voltando para o mesmo problema de dependência de todas as areias ter parar pouca de uma determinado problema ou implementação em uma camada. ]
---

**Dica de pit stop:** Pensa sempre nos dois lados separados: o que muda de serviço pra serviço (a linguagem, o código, as dependências) e o que precisa ser igual pra todo mundo, não importa o serviço (o jeito de empacotar, mover e rodar)[cite: 15]. O contêiner marítimo nunca tenta padronizar a carga — só o transporte[cite: 15].
