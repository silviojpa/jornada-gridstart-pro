#  Atividade Prática – Simulador de Requisitos
**Cenário:** Clínica Bem-Estar digitalizando prontuários eletrônicos.

---

##  Perguntas em Linguagem de Negócio

Para extrair os requisitos reais de resiliência e disponibilidade com a diretoria e o corpo médico da clínica, foram definidas as seguintes perguntas estratégicas (evitando termos como SLA, RPO ou Uptime):

### 1. Impacto real de uma queda (Foco: SLA / Disponibilidade)
> **Pergunta:** *"Se o sistema de prontuários eletrônicos ficar completamente fora do ar durante o horário de pico de atendimento na clínica, o que acontece com os médicos e pacientes no consultório? Conseguimos atender de alguma forma ou a clínica para de funcionar totalmente?"*
* **Objetivo oculto:** Entender a criticidade do sistema para definir o SLA (Service Level Agreement). Se a clínica parar totalmente, o sistema exige altíssima disponibilidade (Multi-AZ, instâncias redundantes).

### 2. Tolerância à perda de dados (Foco: RPO - Recovery Point Objective)
> **Pergunta:** *"No pior cenário possível, em caso de uma pane grave de hardware ou corrupção no sistema, se precisarmos restaurar um backup, qual é o limite de tempo de anotações médicas ou históricos de consultas que aceitamos perder e ter que refazer manualmente?"*
* **Objetivo oculto:** Definir a estratégia e a frequência de backup/replicação (RPO). Por exemplo: se responderem "não podemos perder nada do dia de hoje", a estratégia exige replicação síncrona ou backups de hora em hora.

### 3. Janela de manutenção (Foco: Downtime Planejado)
> **Pergunta:** *"Qual é o melhor dia da semana e horário em que a clínica está completamente fechada ou com o menor fluxo possível de atendimentos, onde nossa equipe de tecnologia possa desligar o sistema por alguns minutos para realizar melhorias e atualizações de segurança?"*
* **Objetivo oculto:** Mapear a janela de manutenção programada sem impactar o faturamento e a operação dos médicos.

---

##  Justificativa Arquitetural (Métricas Técnicas Extraídas)

Com base nas respostas esperadas para esse tipo de negócio (Saúde/Clínica), a arquitetura deve ser desenhada considerando:

* **SLA Alto:** Prontuários médicos são críticos. Uma queda impede o médico de receitar ou ver o histórico do paciente. A meta deve ser de no mínimo **99.9% de uptime** durante o horário comercial.
* **RPO Baixo:** Perder dados de saúde é um risco jurídico e operacional grave. O RPO ideal deve ser de **no máximo 1 hora** (backups frequentes ou replicação de banco de dados).
* **Janela de Manutenção Estrita:** Geralmente nas madrugadas de sábado para domingo ou domingos o dia todo, quando clínicas particulares não costumam realizar consultas eletivas.
