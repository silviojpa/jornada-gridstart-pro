# Atividade - Comprar o Carro ou Alugar por Minuto? O Diagnóstico Financeiro da Nuvem

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar os conceitos de CAPEX, OPEX e provisionamento por adivinhação, vistos no vídeo, a um cenário fictício, decidindo e justificando o melhor caminho de infraestrutura para uma empresa.  
**Tipo:** Diagnóstico + reflexão escrita — sem terminal, sem comando real.  
**Tempo estimado:** 10-15 minutos  
**Entrega:** Respostas escritas às três questões abaixo.

---

## Contexto (cenário fictício)

A Brechó Boutique é um e-commerce de roupas de segunda mão que está crescendo rápido. Hoje, o site roda em um único servidor alugado por mês, e a fundadora está decidindo o próximo passo de infraestrutura para os próximos dois anos. Ela recebeu duas propostas:

*   **Proposta A (Datacenter próprio):** comprar um conjunto de servidores físicos, hospedados numa sala alugada com ar-condicionado dedicado. O pagamento principal é feito uma única vez, na compra do hardware, e depois disso a empresa precisa manter uma pequena equipe de manutenção e pagar energia e aluguel da sala todo mês — esteja o tráfego do site alto ou baixo.
*   **Proposta B (Provedor de nuvem):** contratar capacidade computacional por hora de uso, sem comprar nenhum hardware, com a possibilidade de aumentar ou reduzir essa capacidade a qualquer momento.

**Um detalhe importante do negócio:** a Brechó Boutique tem um pico de vendas enorme no Dia das Mães e na Black Friday — nesses períodos, o tráfego do site chega a ser muitas vezes maior do que no resto do ano, que tem um movimento estável e bem mais baixo.

---

## Questões

### 1. CAPEX ou OPEX?
Classifique a Proposta A e a Proposta B usando os conceitos de CAPEX (*capital expenditure*) e OPEX (*operational expenditure*) vistos no vídeo. Explique, em poucas frases, por que cada proposta se encaixa no modelo que você escolheu — cite especificamente o que acontece com o dinheiro da empresa em cada uma, antes e depois da contratação.

> [A Proposta A é classificada como CAPEX, pois exige que a empresa invista um grande capital inicial de uma única vez para adquirir bens físicos permanentes (os servidores). O dinheiro fica imobilizado no hardware antes mesmo do site gerar qualquer retorno com o tráfego novo. A Proposta B é classificada como OPEX, transformando o custo em despesa operacional recorrente. Não há gasto inicial com hardware; o dinheiro da empresa sai de forma gradual e controlada mês a mês, sendo pago apenas pelo uso operacional real da capacidade contratada.]

### 2. O problema do pico
Considerando o pico de vendas no Dia das Mães e na Black Friday, explique os dois riscos que a Brechó Boutique correria se escolhesse a Proposta A (datacenter próprio) e precisasse decidir, hoje, o tamanho exato dos servidores a comprar para os próximos dois anos. Qual desses dois riscos te parece mais grave para o negócio de um e-commerce, e por quê?

> [Ao escolher a Proposta A, a empresa cai no "provisionamento por adivinhação" e corre dois riscos simétricos:]
> [1-Subdimensionamento (comprar de menos): Se estimar a carga por baixo, o servidor não aguentará o tráfego massivo do Dia das Mães ou da Black Friday, fazendo o site sair do ar justamente no momento de maior faturamento.]
> [2-Superdimensionamento (comprar de mais): Se comprar hardware gigante para suportar com folga os picos, a empresa gastará uma fortuna inicial por um servidor que passará 95% do ano operando com 5% de sua capacidade, gerando um enorme desperdício de dinheiro parado.]

### 3. Conectando com a Proposta B
Sem entrar no mecanismo técnico (isso é assunto de um vídeo futuro), explique, com suas próprias palavras, por que a Proposta B lida melhor com o padrão de tráfego da Brechó Boutique do que a Proposta A. Depois, proponha um cenário diferente de outra empresa fictícia, com um padrão de uso bem mais constante e previsível ao longo do ano em que a Proposta A (datacenter próprio) poderia, ainda assim, fazer sentido financeiro. Justifique.

> [A Proposta B lida muito melhor com o cenário da Brechó Boutique porque ela desvincula a capacidade do desperdício: a empresa pode operar o ano todo pagando apenas por uma infraestrutura modesta e barata, e elevar essa capacidade sob demanda apenas nos dias específicos dos picos (Black Friday e Dia das Mães), voltando ao tamanho normal assim que o evento acabar.]

---

**Dica de pit stop:** A pergunta 3 não tem uma resposta de "nuvem sempre ganha". O vídeo te mostrou o motivo pelo qual a nuvem resolve bem o problema específico da Brechó Boutique — um padrão de uso com picos imprevisíveis. Pensa em que tipo de carga de trabalho tem o comportamento oposto: uso constante, alto e previsível, o tempo todo, sem picos sazonais.
