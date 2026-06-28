# Atividade - Lendo a Resistência por Trás do "Sempre Fizemos Assim"

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar o raciocínio do vídeo sobre DevOps de palco vs. realidade, cópia de modelo de empresa referência e resistência passivo-agressiva a um cenário realista de empresa tradicional.  
**Tipo:** Reflexão escrita — sem terminal, sem script.  
**Entrega:** Respostas escritas às quatro questões abaixo. Não existe resposta de uma linha só — justifique com base no que foi visto no vídeo.

---

## Cenário

Você acaba de entrar como responsável técnico numa empresa de logística com 12 anos de operação. O sistema de rastreamento de cargas é um monólito que roda desde a fundação da empresa e nunca pode ficar fora do ar durante o horário comercial.

Você propõe um pipeline de CI simples, só para o módulo de relatórios — a parte menos crítica do sistema, isolada do resto. A ideia é rodar os testes automaticamente antes de qualquer deploy desse módulo.

Marcos, desenvolvedor sênior que mantém esse sistema desde o início, reage na reunião:

*"Não precisa disso. Eu testo na mão antes de subir, faço isso há dez anos e nunca deu problema grande. Vamos perder tempo configurando ferramenta pra um módulo que já funciona."*

Ninguém mais no time se manifesta. Na conversa de corredor depois da reunião, dois desenvolvedores juniores comentam, baixinho, que *"seria bom ter os testes automáticos, mas ninguém quer contrariar o Marcos"*.

---

## Questões

### 1. DevOps de palco ou DevOps real?
A proposta de CI só para o módulo de relatórios é um exemplo de DevOps de palco ou de DevOps real, considerando o que foi visto no vídeo sobre trocar o pneu com o motor rodando? Justifique citando o critério usado no vídeo (não baseie a resposta apenas na opinião pessoal).

> [Trazer uma modalidade ou função nova mesmo que seja para diminuir o esforço ou serviço manual requer sempre o apoio de todos e quando precisa fazer iiso com sistema rodando sem poder parar, aí gera o medo de não poder funcionar de novo, mexer no que está quieto e pensamento
> que talvez venha pensamentos mesmo que seja óbvio que vá mehorar , pessoas com mais tempo de empresa pode sentir vai tirar o trabalho dela. ]

### 2. Identificando a resistência
A frase do Marcos (*"não precisa disso... nunca deu problema grande"*) é resistência passivo-agressiva clássica. Segundo o raciocínio do vídeo, qual é a diferença entre o problema que ele declara (a ferramenta é desnecessária) e o problema real provável por trás da fala dele? Aponte pelo menos uma hipótese concreta de medo ou incentivo.

> [Com base no resultado de Marco, se passa um cenário que talvez na cabeça dele fazer isso pode tirar umas de suas funções ou atribuir atividades que ele não quer sair da zona de conforto e implementar pode levar a propagação do medo e não o desafio de mudanças.]

### 3. O erro de copiar modelo de fora
Se você decidisse resolver essa resistência simplesmente anunciando *"a partir de agora todo módulo usa CI, porque é assim que [empresa de referência] faz"*, por que essa abordagem provavelmente falharia, segundo o ponto do vídeo sobre copiar modelo de empresa referência?

> [Coforme foi apresentado, usar toda uma refenrência de empresa grande e trazer como meta, é trazer a possibilidade de falhar, mas quando se traz o conceito usado e implementar de forma coordenado nas reais necessidades terá possibilidades melhores de dár certo.]

### 4. Conduzindo a mudança
Com base no que o vídeo sugeriu sobre trazer a pessoa pro processo de desenho da mudança (em vez de só pro anúncio dela), descreva em 3 a 5 frases uma abordagem concreta para conduzir essa conversa com o Marcos, sem ignorar a experiência dele nem deixar a decisão técnica na mão dele.

> [Mostrar as possibilidades do quanto isso se faz necessário com ponto positivos e se caso negativo introduzir as idéias com ele outros sem tirar o mérito de sua experiências de anos com o sistema.]

---

**Dica de pit stop:** Releia a pergunta 2 antes de responder a pergunta 4. Quem nomeia o medo real primeiro geralmente escreve uma resposta de condução de mudança bem mais específica e menos genérica na pergunta 4.
