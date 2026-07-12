# Atividade - S06T01V03: Escalabilidade Horizontal vs. Vertical

> "Quando acelerar e quando trocar de marcha"

---

## CENÁRIO 1: Startup de Delivery que Cresceu Rápido

### Pergunta 1a
Qual estratégia você recomendaria? Scale Up ou Scale Out? Por quê?

> **Sua resposta:**  
> [Pergunta 1a: Eu recomendaria o Scale Out. Para um aplicativo de delivery com crescimento acelerado e expansão geográfica, a escalabilidade horizontal oferece elasticidade e melhor custo-benefício. Colocar 3 servidores menores custa a metade do preço (R$ 600/mês vs R$ 1.200/mês) e tem downtime zero. Além disso, as requisições de delivery variam muito conforme horários de pico (almoço/jantar), tornando o modelo distribuído ideal para ligar e desligar instâncias sob demanda.]

### Pergunta 1b
Em 12 meses, a empresa cresceu para 500.000 usuários em 5 cidades. Se tivesse escolhido Scale Up no mês 6, qual seria o problema agora?

> **Sua resposta:**  
> [Pergunta 1b: O problema seria o teto físico limitante e o custo. Como a base de usuários cresceu (de 100k para 500k), o servidor c71.4xlarge voltaria a ficar saturado. Para realizar um novo Scale Up, a empresa enfrentaria mais tempo fora do ar (downtime), além de pagar um valor exponencialmente maior por máquinas gigantescas, aproximando-se do limite máximo de hardware que o provedor consegue oferecer.]

### Pergunta 1c
Se escolheu Scale Out, como você escalaria AGORA (em 12 meses)? Quantos servidores você teria?

> **Sua resposta:**  
> [Pergunta 1c: Para suportar o novo volume de 500.000 usuários, eu simplesmente adicionaria mais instâncias idênticas ao cluster sob o Load Balancer. Como a proporção de crescimento foi de 5 vezes em relação ao mês 6, eu escalaria linearmente de 3 para 15 servidores t3.medium. O Load Balancer distribuiria uniformemente o tráfego entre essas 15 máquinas de forma transparente para o usuário.]

---

## CENÁRIO 2: Banco Que Roda Mainframe

### Pergunta 2a
Qual estratégia você recomendaria? Scale Up (mainframe) ou Scale Out (cloud)? Por quê?

> **Sua resposta:**  
> [Pergunta 2a: Eu recomendaria o Scale Out (Cloud). Embora migrar sistemas financeiros legados seja complexo, a proposta da nuvem com contêineres reduz o custo mensal (R$ 50.000 vs R$ 80.000) e elimina o risco crítico de interrupção de serviço através de uma migração gradual com downtime zero. Manter o modelo de mainframe aprisiona o banco a ciclos caros de atualização de hardware (R$ 5 milhões) e longos tempos de entrega (6 meses).]

### Pergunta 2b
O que é o maior risco de Scale Up neste cenário? (Pense no conceito de SPoF - Ponto Único de Falha).

> **Sua resposta:**  
> [Pergunta 2b: O maior risco é a consolidação de um SPoF (Ponto Único de Falha) catastrófico. Concentrar 5 milhões de transações diárias em um único mainframe físico significa que qualquer falha grave de hardware, desastre na sala do datacenter ou erro crônico de sistema derrubará a operação financeira do banco inteiro. A recuperação desse tipo de equipamento centralizado costuma ter um tempo de restauração muito elevado.]

### Pergunta 2c
Se o banco escolhe Scale Out e migra pro cloud, qual é a vantagem ALÉM de escalabilidade? (Dica: pense em confiabilidade + tolerância a falhas).

> **Sua resposta:**  
> [Pergunta 2c: A grande vantagem além de escalar é a Alta Disponibilidade (HA) e a Tolerância a Falhas. Ao rodar em contêineres distribuídos na nuvem através de múltiplas zonas de disponibilidade, se um servidor ou até mesmo um datacenter inteiro falhar, o Load Balancer redireciona o tráfego para as instâncias remanescentes instantaneamente. O sistema se torna resiliente a falhas isoladas sem interromper as transferências dos correntistas.]

---

## CENÁRIO 3: Processamento de Imagens (Batch)

### Pergunta 3a
Qual estratégia você recomendaria? Scale Up ou Scale Out? Por quê?

> **Sua resposta:**  
> [Pergunta 3a: Eu recomendaria o Scale Out. O processamento de imagens (filtros, redimensionamento) é o exemplo perfeito de uma tarefa altamente paralela. Dividir o lote em 100 servidores pequenos entrega o resultado 5 vezes mais rápido (6 minutos vs 30 minutos) por uma fração do preço (R$ 5.000/mês vs R$ 30.000/mês), eliminando o risco de ociosidade e falha total de um único servidor gigante.]

### Pergunta 3b
Compare o tempo de processamento: Scale Up (30 min) vs Scale Out (6 min). Por que Scale Out é tão mais rápido?

> **Sua resposta:**  
> [Pergunta 3b: O Scale Out é mais rápido porque ele substitui o processamento sequencial/concorrente em gargalo por um paralelismo distribuído real. Em um único servidor (Scale Up), as threads dividem os mesmos recursos de barramento de memória, disco e CPU. No Scale Out, cada um dos 100 servidores possui seu próprio hardware isolado para processar apenas 100 fotos; as 10.000 imagens são digeridas simultaneamente sem disputar os mesmos componentes físicos.]

### Pergunta 3c
Se a startup crescer e precisar processar 1 MILHÃO de fotos/dia, qual seria o problema com Scale Up? E como você resolveria com Scale Out?

> **Sua resposta:**  
> [Pergunta 3c: Com o Scale Up, o sistema encontraria o limite físico intransponível do hardware: não existem servidores comerciais com poder de processamento suficiente para linearizar 1 milhão de fotos em menos de uma hora de forma centralizada. Com o Scale Out, o problema é resolvido apenas alterando um parâmetro de escala: basta aumentar a frota de 100 para 1.000 ou mais instâncias pequenas temporariamente em modelo batch, distribuindo a carga massiva horizontalmente.]

---

## CENÁRIO 4 (BÔNUS): Escolha Você

### 1. O cenário:  
[1. O cenário: Um microsserviço de processamento e auditoria de logs de streaming de vídeo de uma plataforma de telecomunicações atende a 80.000 requisições simultâneas em horários de grandes transmissões ao vivo. O servidor centralizado sofre com esgotamento de memória e gargalo de rede durante os picos do evento.]

### 2. A decisão:  
[2. A decisão: Scale Out (Escalabilidade Horizontal).]

### 3. A justificativa:  
[3. A justificativa: Trata-se de uma carga de trabalho web com picos acentuados e sazonais de tráfego. Adicionar instâncias atrás de um balanceador de carga permite criar políticas de auto-scaling baseadas no uso de CPU e banda de rede. Isso garante que novos contêineres sejam provisionados apenas enquanto durar o evento de streaming ao vivo, reduzindo os custos operacionais (OPEX) e mantendo a alta disponibilidade sem desperdiçar dinheiro com servidores superdimensionados nos momentos ociosos da madrugada.]
