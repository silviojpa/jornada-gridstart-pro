# Atividade - S06T02V04: Instâncias Spot e Resiliência de Infraestrutura
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 13 de julho de 2026  

---

## Parte 1 - Verdadeiro ou Falso (V / F)

1. (**V**) Uma Instância Spot possui a mesma performance computacional que uma instância On-Demand do mesmo tipo[cite: 15].
2. (**F**) *O aviso de interrupção (Spot Interruption Notice) dá ao usuário apenas **2 minutos** (e não 15 minutos) para salvar o estado e finalizar os processos de forma limpa.*[cite: 15]
3. (**F**) *O preço de uma Instância Spot é extremamente dinâmico, flutuando constantemente de acordo com a oferta de capacidade ociosa e a demanda em tempo real do provedor.*[cite: 15]
4. (**V**) Ao utilizar uma Spot Fleet com múltiplos tipos de instância, a resiliência do workload aumenta em relação ao uso de um único tipo[cite: 15].
5. (**F**) *Bancos de dados relacionais de produção exigem persistência estrita e não toleram interrupções abruptas ou perda de nós, sendo péssimos candidatos para Spot.*[cite: 15]
6. (**V**) O Spot Instance Advisor no console AWS mostra a frequência histórica de interrupção por tipo de instância e região[cite: 15].
7. (**V**) O Karpenter é um autoscaler de nodes para Kubernetes que prioriza instâncias Spot quando disponíveis e faz fallback para On-Demand[cite: 15].
8. (**V**) Workloads que utilizam filas de mensagens (SQS, Kafka) são ideais para Spot porque o sistema de retry garante que nenhuma mensagem seja perdida mesmo em caso de interrupção[cite: 15].
9. (**F**) *As interrupções de Instâncias Spot ocorrem de forma imprevisível a qualquer hora do dia ou da noite, sempre que a demanda por instâncias On-Demand naquele pool de capacidade específico aumentar.*[cite: 15]
10. (**V**) Treinamento de modelos de Machine Learning com checkpointing é um caso de uso válido e comum para Spot Instances[cite: 15].

---

## Parte 2 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **Questão 1** | **b** | Os provedores reduzem as tarifas em até 90% para monetizar e dar vazão à capacidade física ociosa em seus datacenters[cite: 15]. |
| **Questão 2** | **b** | O pipeline é idempotente e de curta duração (8 min), salvando o progresso de cada arquivo isoladamente no S3, tornando-o ideal para Spot[cite: 15]. |
| **Questão 3** | **b** | O runner do GitHub Actions falha e a plataforma lida com o retry do Job em outra instância disponível de maneira nativa[cite: 15]. |
| **Questão 4** | **b** | Spot Request foca em um recurso individual, enquanto a Spot Fleet gerencia de forma inteligente pools e diversificação de recursos[cite: 15]. |
| **Questão 5** | **b** | A baixa taxa histórica de interrupção do tipo c5.xlarge mostra que há ampla capacidade ociosa disponível desse tipo de hardware na região[cite: 15]. |

---

## Parte 3 - Análise de Cenário (DataFlux)

### 3.1 Classificação de Recomendação dos Sistemas:

*   **API de Vendas (X - Não Recomendado):** Exige alta disponibilidade contínua (99,9%) e baixíssima latência para transações em tempo real dos clientes[cite: 15]. Interrupções abruptas de nós causariam falhas diretas nas compras dos usuários.
*   **Banco de Dados PostgreSQL (X - Não Recomendado):** Sistemas de armazenamento de dados relacionais necessitam de integridade transacional estrita e persistência de disco sem interrupções não planejadas, o que poderia corromper dados[cite: 15].
*   **Worker de Processamento de Relatórios (A - Pode ser com ajustes):** Embora o SLA seja de melhor esforço, um processo monolítico de 30 minutos sem pontos de parada será totalmente perdido se for desligado no minuto 29[cite: 15].
*   **Pipeline de ML (R - Recomendado):** O processo é nativamente adaptável a Spot e possui mecanismo de checkpoint de 10 em 10 minutos, garantindo que no máximo 9 minutos de progresso sejam perdidos caso ocorra um despejo[cite: 15].
*   **Fila de Envio de E-mails (R - Recomendado):** O uso do SQS (fila de mensagens) garante o desacoplamento; se um worker Spot cair ao processar um e-mail, a mensagem volta à fila (*visibility timeout*) para ser consumida por outro nó saudável[cite: 15].

---

### 3.2 Problemas e Soluções para o Worker de Relatórios:

*   **Problema 1 (Longa Duração Monolítica):** O processo de geração leva 30 minutos em um único ciclo ininterrupto. Se a instância sofrer despejo aos 25 minutos, todo o processamento e computação serão perdidos, gerando frustração e desperdício[cite: 15].
    *   *Solução:* **Modularização do Pipeline (Batching/Checkpointing).** Dividir o processamento do relatório em pequenos lotes (ex: a cada 5 minutos de processamento, salvar o estado parcial no S3 ou banco) para permitir que o worker reinicie a partir do último progresso salvo.
*   **Problema 2 (Falta de Desacoplamento):** Se o worker processar as solicitações de forma síncrona diretamente ligada à API ou banco, a interrupção causará a perda total do rastreamento de quem solicitou o relatório[cite: 15].
    *   *Solução:* **Desacoplamento por Fila (SQS).** Inserir as solicitações de relatórios em uma fila SQS. Caso o worker caia no meio da geração, a mensagem não é deletada do SQS e, após o tempo de visibilidade expirar, outro worker assume o processamento do zero ou do último checkpoint de forma transparente.

---

### 3.3 Passos para Tornar o Pipeline de ML Resiliente a Interrupções:

1.  **Configurar Checkpointing Frequente e Armazenamento Externo:** Garantir que o script de Machine Learning faça o salvamento de checkpoints do modelo (ex: pesos das épocas, variáveis globais) a cada 10 minutos ou menos[cite: 15] e persista esses arquivos diretamente em um local resiliente, como o Amazon S3.
2.  **Habilitar o Script de Auto-Retomada:** Desenvolver a lógica do pipeline para que, ao iniciar, ele varra a pasta de checkpoints do bucket S3. Caso encontre um estado válido, o treinamento é retomado automaticamente daquele ponto em diante; caso contrário, inicia do zero.
3.  **Criar um Grupo de Auto Scaling com Diversificação de Instâncias (Spot Fleet):** Configurar um ASG ou Spot Fleet mapeando múltiplos tipos de instâncias que atendam aos requisitos mínimos de GPU/CPU (ex: g4dn.xlarge, g5.xlarge, p3.2xlarge) em vez de focar em apenas uma família[cite: 15], reduzindo a vulnerabilidade à falta de capacidade de um pool específico.
4.  **Tratar o Sinal de Interrupção via Metadata (Instance Metadata Service - IMDS):** Implementar um script daemon que escute o aviso de interrupção de 2 minutos (`/latest/meta-data/spot/termination-time`) para realizar um checkpoint final "de emergência", liberar conexões abertas de forma segura e fazer o *drain* ordenado do processo[cite: 15].

---

## Parte 4 - Reflexão Técnica (Redis em Spot)

**A proposta do colega é perigosa e incorreta.** Embora o Redis reinicie rápido, sua utilização como cache de sessões de usuário sob instâncias Spot trará sérios problemas de experiência. 

A queda abrupta da instância fará com que todos os usuários ativos conectados no momento percam instantaneamente suas sessões (sendo deslogados das contas)[cite: 15]. Além disso, a perda imediata do cache gerará uma avalanche de requisições diretas ao banco de dados principal de produção (*Cache Stampede* / *Cache Avalanche*) para recriar as sessões, o que pode derrubar o banco de dados principal. 

**Alternativa Recomendada:** Manter o Redis em instâncias de modelo **On-Demand** utilizando tamanhos menores (ex: família `t3` ou `t4g`) em arquitetura de replicação (Multi-AZ de baixo custo), ou contratar o serviço gerenciado (Amazon ElastiCache Serverless / Redis Enterprise) para delegar a alta disponibilidade sem comprometer a estabilidade do fluxo de login e sessão dos clientes[cite: 15].
