# Atividade Teórica - S06T01V02: Identificando SPoF e Propondo Redundância

> "Confiabilidade é construída, não é sorte."

---

## CENÁRIO 1: Identifique o SPoF

### Pergunta 1a:
Qual é o Ponto Único de Falha (SPoF) nessa arquitetura? (Dica: O que, se falhar, derruba o serviço inteiro?)

> **Sua resposta:** 
> [Pergunta 1a: O único servidor EC2 é o SPoF absoluto desta arquitetura. Como ele centraliza o Banco de Dados, a API e o próprio site, qualquer pane de hardware, estouro de memória ou reinicialização desliga todos os componentes essenciais simultaneamente.]

### Pergunta 1b:
O que o usuário final experimenta durante os 5 minutos de reinicialização do servidor?

> **Sua resposta:** 
> [Pergunta 1b: O usuário final experimentará uma queda total de serviço. Ele verá erros de conexão no navegador (como 502 Bad Gateway, 504 Gateway Timeout ou Connection Refused) e ficará completamente impossibilitado de interagir com o e-commerce durante esses 5 minutos.]

### Pergunta 1c:
Se a empresa quer manter um SLA de 99.5% de uptime (ou seja, máximo ~3.6 horas de downtime por mês), essa arquitetura consegue? (Dica: Downtime atual = 5 min/mês devido aos patches).

> **Sua resposta:** 
> [Pergunta 1c: Sim, matematicamente consegue. O SLA de 99.5% permite até 3,65 horas (cerca de 219 minutos) de indisponibilidade por mês. Como a reinicialização planejada consome apenas 5 minutos mensais, a empresa opera bem abaixo do limite tolerável. Contudo, vale o aviso técnico: essa arquitetura não possui margem para falhas imprevistas; se o servidor quebrar fora do planejado, o SLA será facilmente estourado.]

---

## CENÁRIO 2: Construindo Alta Disponibilidade

### Pergunta 2a:
Se um servidor cai às 14:35, em quanto tempo o Load Balancer redireciona TODO o tráfego pro servidor vivo? (Considere o intervalo de health checks mencionado de 5 segundos).

> **Sua resposta:** 
> [Pergunta 2a: O Load Balancer levará pelo menos 5 segundos (o tempo do próximo ciclo de health check) para detectar a queda. Na prática de mercado, as ferramentas costumam exigir de 2 a 3 falhas consecutivas para marcar uma instância como unhealthy, o que poderia estender o redirecionamento total para algo entre 5 e 10 segundos.]

### Pergunta 2b:
Durante esse tempo de transição, o usuário final percebe algo? O que ele vê?

> **Sua resposta:** 
> [Pergunta 2b: Sim, os usuários cujas requisições caíram exatamente no servidor afetado no segundo exato da pane notarão lentidão ou uma falha de carregamento (como um erro 500 ou timeout). Como não há backup automático de sessão nessa fase, quem estava no meio de um fluxo (compras no carrinho, por exemplo) precisará atualizar a página e poderá perder dados temporários de estado.]

### Pergunta 2c:
Qual é o novo SPoF nessa arquitetura? (Dica: Pensa em cada componente: Servidor A, Servidor B, Load Balancer, Banco de Dados. Qual, se cair, derruba TUDO?)

> **Sua resposta:** 
> [Pergunta 3c: O novo SPoF passa a ser o Banco de Dados RDS. Embora os servidores web estejam duplicados e o Load Balancer seja um serviço gerenciado de alta resiliência, existe apenas uma única instância de banco de dados. Se ela cair, ambas as instâncias da API perderão a capacidade de persistir e ler dados, derrubando a aplicação.]

---

## CENÁRIO 3: Adicionando Tolerância a Falhas

### Pergunta 3a:
O que mudou em relação ao Cenário 2? (Liste os mecanismos novos que foram adicionados).

> **Sua resposta:** 
> [Pergunta 3a: Foram adicionados três mecanismos fundamentais de resiliência ativa: um Cache em memória (Redis) para dados frequentes e gerenciamento de estado/sessão, políticas de Retry automático (até 3 tentativas de reconexão automática em falhas) e um mecanismo de Fallback de degradação controlada (busca no cache se o banco falhar ou entrega de página estática em última instância).]

### Pergunta 3b:
Quando o banco de dados RDS cai por 2 minutos, qual experiência o usuário final tem? (Será que ele vê erro? Será que ele consegue usar a app?)

> **Sua resposta:** 
> [Pergunta 3b: O usuário final continuará navegando e conseguirá usar a aplicação na maior parte do tempo, sem ver telas de erro fatais. Como o sistema faz o fallback para o Redis, o cliente poderá visualizar produtos e navegar pelas páginas consumindo dados em cache (que podem estar até 5 minutos defasados). Ele só enfrentará um bloqueio se tentar realizar uma operação de escrita que dependa do banco transacional ao vivo (como fechar um pagamento).]

### Pergunta 3c:
Qual é o trade-off (troca) aqui? O que você GANHA? O que você PERDE?

> **Sua resposta:**  
> **Ganho:** [Continuidade de negócios e resiliência extrema. O sistema não sai do ar em momentos críticos e o usuário não se depara com interrupções abruptas (degradação graciosa).]  
> **Perda:** [Consistência imediata dos dados (eventualidade de exibir informações defasadas por até 5 minutos) e um aumento expressivo na complexidade do código e custos de infraestrutura (manutenção de Redis, lógicas de fallback).]

### Pergunta 3d:
Por que isso é chamado de "Tolerância a Falhas" e não só "HA"? (Qual é a diferença conceitual entre os dois?)

> **Sua resposta:** 
> [Pergunta 3d: A Alta Disponibilidade (HA) foca em redundância estrutural para evitar indisponibilidade (ex: ter duas máquinas para que uma assuma o lugar da outra). A Tolerância a Falhas vai além: ela define como o software se comporta inteligentemente quando as coisas quebram, permitindo que a aplicação continue funcionando de forma parcial e degradada mesmo quando uma peça crucial (como o banco de dados) está completamente fora do ar.]
