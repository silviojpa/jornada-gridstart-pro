# Atividade Diagnóstica - S06T01V05: Regiões e Zonas de Disponibilidade (AZs)

> "Elasticidade não é mágica. É matemática."

---

## CENÁRIO 1: Startup de Chat em Tempo Real (Chat App)

### 1. Qual(is) região(ões) você escolheria? Por quê?
> **Sua resposta:**  
> [Região Escolhida: sa-east-1 (São Paulo). A escolha é obrigatória por motivos de compliance, já que a LGPD exige dados armazenados em solo brasileiro. Além disso, como 70% dos usuários estão no Brasil e a latência de chat é crítica (<100ms), o tráfego local se beneficia de uma latência baixíssima (<5ms na mesma região). Os usuários da Argentina e Colômbia sofrerão uma latência marginalmente maior (20-50ms por estarem no mesmo continente), o que ainda atende perfeitamente ao teto de 100ms estipulado.]

### 2. Quantas AZs dentro dessa região você usaria? (1, 2, 3 ou mais?)
> **Sua resposta:**  
> [Quantidade de AZs: 2 AZs. Como a equipe é minúscula (1-2 pessoas) e o budget é curto, usar 3 ou mais AZs aumentaria desnecessariamente a complexidade de configuração e os custos de tráfego inter-AZ. No entanto, usar apenas 1 AZ violaria o SLA exigido de 99.95%, pois qualquer falha física derrubaria o app. 2 AZs garantem Alta Disponibilidade (HA) mantendo a simplicidade.]

### 3. Como você distribuiria a carga entre as AZs? (Exemplo: 50-50? 33-33-33?)
> **Sua resposta:**  
> [Distribuição de Carga: 50-50 (Ativo-Ativo). A carga da API web deve ser balanceada igualmente entre as duas AZs por um Load Balancer gerenciado. O banco de dados deve rodar em modelo Ativo-Passivo (RDS Multi-AZ), replicando os dados de forma síncrona para a segunda AZ para garantir failover automático rápido se a AZ principal sofrer uma pane.]

### 4. Qual é o maior risco dessa arquitetura? Como você mitigaria?
> **Sua resposta:**  
> [Maior Risco e Mitigação: O maior risco é o estouro de budget, dado que a região sa-east-1 é uma das mais caras da AWS globalmente. A mitigação consiste em otimizar severamente o uso de instâncias (usando tipos eficientes como computação baseada em ARM/Graviton), implementar Auto Scaling agressivo na camada de API e utilizar cache em memória local para evitar transferências excessivas de dados.]

---

## CENÁRIO 2: SaaS de Analytics para E-commerce Global

### 1. Qual estratégia de regiões você usaria? (Single-region, multi-region, multi-cloud?)
> **Sua resposta:**  
> [Estratégia de Regiões: Multi-region (Single-cloud na AWS). A arquitetura exige a divisão de dados por questões estritas de regulação governamental (EUA, União Europeia e Brasil). Portanto, o SaaS deve implantar infraestruturas paralelas isoladas em us-east-1 (EUA), eu-west-1 (Europa) e sa-east-1 (Brasil). Para a Ásia (20% dos clientes), pode-se adotar ap-northeast-1 (Tóquio) ou ap-south-1 (Mumbai), dependendo de onde o maior volume asiático estiver concentrado.]

### 2. Como você garantiria latência <2s para usuários em diferentes continentes?
> **Sua resposta:**  
> [Garantia de Latência (<2s): Através do roteamento inteligente baseado em geolocalização na camada de DNS (como o Route 53). O cliente de e-commerce é automaticamente direcionado para o cluster regional mais próximo geograficamente, processando os dados e renderizando o dashboard localmente sem cruzar oceanos, mantendo o tempo de resposta abaixo de 2 segundos.]

### 3. Qual é o impacto de custo dessa estratégia multi-região? Como você controlaria?
> **Sua resposta:**  
> [Impacto de Custo e Controle: O impacto financeiro será altíssimo, pois manter ambientes replicados em 3 ou 4 continentes multiplica os custos fixos de banco de dados e gerencia de serviços. Como a empresa é consolidada e possui budget alto, isso é sustentável. O controle deve ser feito padronizando a infraestrutura como código (IaC) para evitar desperdício de recursos ociosos e contratando planos de desconto unificados (Savings Plans) da AWS.]

### 4. Qual é o maior risco? (Hint: pense em Data Egress, sincronização, compliance)
> **Sua resposta:**  
> [Maior Risco: O maior risco técnico é o custo oculto de Data Egress (transferência de dados de saída) e problemas com relatórios cruzados. Se o sistema tentar unificar métricas globais replicando dados brutos entre continentes a todo momento, a conta de rede explodirá. A mitigação consiste em processar agregados (consolidados matemáticos menores) localmente em cada região e transferir apenas os resultados consolidados (KB em vez de GB) para o dashboard centralizado.]

---

## CENÁRIO 3: Plataforma de Streaming de Vídeo (Tipo Netflix)

### 1. Você usaria apenas regiões AWS ou consideraria usar CDN/Edge Locations? Por quê?
> **Sua resposta:**  
> [Uso de CDN/Edge Locations: Sim, obrigatoriamente. Regiões AWS puras são insuficientes para streaming de mídia. Embora o repositório centralizado de arquivos brutos permaneça em Nova York (us-east-1), os blocos de vídeo pesados precisam ser distribuídos por uma CDN (como CloudFront) usando Edge Locations espalhadas nas cidades de consumo. Isso reduz a latência para menos de 50ms (resolvendo o buffering) e evita tráfego internacional repetitivo.]

### 2. Qual seria sua arquitetura de AZs em cada região? (Exemplo: 2 AZs ou 3+ AZs?)
> **Sua resposta:**  
> [Arquitetura de AZs por Região: Pelo menos 3 Zonas de Disponibilidade (3+ AZs) em cada uma das regiões de apoio (sa-east-1, ap-south-1, etc.). Como o SLA exigido é de altíssima criticidade (99.99%) e cada minuto fora do ar representa prejuízo massivo, a redundância tripla é necessária para suportar perdas simultâneas ou manutenções sem degradar a capacidade da infraestrutura de microsserviços.]

### 3. Como você garantiria 99.99% de disponibilidade? O que aconteceria se uma AZ inteira caísse?
> **Sua resposta:**  
> [Garantia de 99.99% e Queda de AZ: Se uma AZ inteira sofrer um blecaute elétrico ou falha estrutural, o Load Balancer redirecionará o tráfego instantaneamente para as outras 2 AZs saudáveis da mesma região. O Auto Scaling disparará para recompor o tamanho do cluster nas zonas remanescentes. Para o usuário final assistindo ao vídeo, o player va ler o próximo bloco da Edge Location ou de outra AZ sem que ocorra interrupção ou travamento visual.]

### 4. Qual é o trade-off entre latência ultra-baixa (Edge Locations) e custo de operação?
> **Sua resposta:**  
> [Trade-off (Edge vs Custo Operacional): O ganho de experiência do usuário com latência ultra-baixa é enorme, mas a perda/custo associado está na operação de invalidação de cache e sincronismo. Sempre que um conteúdo novo for lançado ou alterado, a plataforma gasta processamento e custos de rede para propagar essa alteração para centenas de pontos de borda globalmente, além de exigir uma lógica de software complexa para lidar com falhas de replicação geográfica em tempo real.]
