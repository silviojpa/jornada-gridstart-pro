#  Atividade Prática: A Lista de Compras Arquitetural
---

###  1. Carga e Horário
* **Requisito de Negócio:** *"Recepção funciona 08h-18h. À noite, só 1 médico esporadicamente."*
* **Sua Tradução (Componente e Ajuste):** **Auto Scaling (Grupo de Auto Dimensionamento) baseado em agendamento.**
  * **Ajuste:** Mínimo de 4 instâncias ativas das 08h às 18h (horário de pico) e redução automatizada para apenas 1 instância ativa no período noturno/madrugada para otimização de custos na nuvem.

---

###  2. Tolerância de Queda
* **Requisito de Negócio:** *"Se cair no meio da tarde, máximo 15 minutos de parada."*
* **Sua Tradução (Conceito de Disponibilidade):** **Alta Disponibilidade (High Availability) com Multi-AZ e RTO ≤ 15 min.**
  * **Conceito:** Aplicação distribuída atrás de um Load Balancer em múltiplas Zonas de Disponibilidade. Banco de dados configurado com replicação ativa e Failover Automático para garantir o restabelecimento do sistema.

---

###  3. Retenção Legal
* **Requisito de Negócio:** *"Raio-X antigo, 1x/mês, não podemos apagar por lei."*
* **Sua Tradução (Tipo de Armazenamento):** **Storage em Camada Fria (ex: AWS S3 Glacier).**
  * **Componente:** Armazenamento de baixo custo ideal para dados "frios" (arquivos acessados raramente, mas que exigem retenção por anos para fins de compliance e conformidade legal).
