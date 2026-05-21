# Atividade Prática: Diagnóstico FinOps – Módulo 01

## 01. Diagnóstico do Cenário
Análise baseada nos princípios de governança financeira em nuvem e identificação de desperdícios:

1. **Frota Fantasma:** Presença de recursos ativos que não entregam valor real ao negócio (como máquinas virtuais ligadas fora do horário comercial, discos órfãos desatrelados e IPs públicos reservados sem uso), fazendo o taxímetro da nuvem girar sem necessidade.
2. **Dimensionamento Incorreto (Wrongsizing):** Recursos superdimensionados com base em estimativas iniciais superestimadas em vez de métricas de uso real (por exemplo, alocação excessiva de vCPU e RAM para cargas de trabalho baixas uso).
3. **Alerta Reativo:** Falha na progressão de alertas de gastos. Notificações configuradas apenas quando o teto do orçamento (Budget) é atingido (100%), eliminando qualquer tempo de reação ou previsão (*Forecast*) para conter anomalias.
4. **Falta de Travão de Emergência (Hard Limit):** Dependência exclusiva de limites imaginários de orçamento (Budget) sem a implementação de travas nas APIs, por região ou tipo de recurso para conter loops infinitos ou provisionamentos acidentais.

---

## 02. As Perguntas ao Gestor
Cinco perguntas específicas e acionáveis para mapear a previsibilidade antes de qualquer alteração de código ou console:

1. **Janela de Utilização:** *"Quais são os dias e horários exatos em que as equipes ou os clientes de fato utilizam este ambiente para sabermos se podemos automatizar o desligamento integral nas madrugadas e finais de semana?"*
2. **Métricas de Capacidade Real:** *"Qual tem sido a média e o pico histórico de utilização de CPU e memória monitorados nas ferramentas de observabilidade para que possamos adequar o tamanho do servidor real consumido?"*
3. **Mapeamento de Data Egress:** *"Temos volumetria ou clareza de quantos dados trafegam saindo da nuvem para servidores locais ou internet, dado que este é o motor de custo mais silencioso e variável da rede?"*
4. **Alinhamento Cambial:** *"Como a variação cambial do dólar (USD) impacta o planejamento financeiro atual da empresa e se existe abertura para avaliarmos provedores de infraestrutura locais faturados em Reais (BRL) para garantir previsibilidade?"*
5. **Políticas de Governança e Ciclo de Vida:** *"Há alguma política definida de retenção de dados e descarte automático de volumes antigos (como snapshots e mídias antigas) para evitar o acúmulo de armazenamento alocado ocioso?"*

---

## 03. Ações Concretas de Processo (Imediatas)
Três ações focadas em mentalidade e processos corporativos, sem alteração de arquitetura técnica:

1. **Instituir a Cultura de Dono (Responsabilidade Compartilhada):** Unificar as visões de Engenharia, Finanças e Negócios sob a mesma telemetria, garantindo que o desenvolvedor entenda que o terminal de comandos se tornou o cartão de crédito da empresa.
2. **Definição de Workflow para Desligamento Programado:** Implementar um processo operacional padrão onde os ambientes não produtivos (desenvolvimento) sejam rotulados obrigatoriamente para desligamento automático via políticas de governança ao término do expediente.
3. **Revisão Periódica de Recursos Órfãos (Checklist de Faxina):** Criar um rito semanal ou quinzenal de auditoria de faturamento para mapear e documentar componentes isolados no ecossistema (rastreabilidade de quem provisionou e o motivo) antes que virem custos não programados.

---

## 04. Reflexão
O conteúdo mais relevante ao longo desse tópico foi o entendimento de que **a nuvem funciona estritamente como um taxímetro infinito kkkk, baseado em provisionamento (reserva) e não em consumo real**. Compreender que uma ineficiência ou loop infinito no código em ambientes de escala com Auto Scaling não gera indisponibilidade, mas sim uma fatura financeira descontrolada, muda drasticamente a responsabilidade do Engenheiro DevOps no desenho de qualquer arquitetura.
