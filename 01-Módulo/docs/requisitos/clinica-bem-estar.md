#  Atividade Prática – Simulador de Requisitos
**Cenário:** Clínica Bem-Estar digitalizando prontuários eletrônicos.

---
### Obs (Resposta feita pela IA para simular as reposta do Dir. da clínica)
##  Perguntas em Linguagem de Negócio

### 1. Impacto real de uma queda (Foco: SLA / Disponibilidade)
> **Pergunta:** *"Se o sistema de prontuários eletrônicos ficar completamente fora do ar durante o horário de pico de atendimento na clínica, o que acontece com os médicos e pacientes no consultório? Conseguimos atender de alguma forma ou a clínica para de funcionar totalmente?"*
* **Resposta do Diretor da Clínica (Linguagem de Negócio):**
    > *"Olha, se o sistema cair durante o dia, os médicos não conseguem ver o histórico do paciente, não conseguem digitar a evolução da consulta e nem emitir receitas digitais. O atendimento praticamente trava. Conseguimos segurar no papel por uns 15 ou 20 minutos no máximo, mas se passar disso, começa a acumular fila na recepção e teremos que desmarcar consultas, gerando prejuízo financeiro e reclamações graves."*

### 2. Tolerância à perda de dados (Foco: RPO - Recovery Point Objective)
> **Pergunta:** *"No pior cenário possível, em caso de uma pane grave de hardware ou sistema corrompido, se precisarmos restaurar um backup, qual é o limite de tempo de anotações médicas ou históricos de consultas que aceitamos perder e ter que refazer manualmente?"*
* **Resposta do Diretor da Clínica (Linguagem de Negócio):**
    > *"Perder dados de saúde é inaceitável para nós. Se o sistema quebrar às 16h, eu não posso perder as consultas que os médicos fizeram de manhã, pois legalmente precisamos daquele registro e o paciente já foi embora. Se tivermos que ligar para o paciente e pedir para ele voltar para refazer a consulta porque o dado sumiu, seria um desastre jurídico e de imagem. Toleramos perder, no limite do limite, os dados dos últimos 30 a 60 minutos de digitação."*

### 3. Janela de manutenção (Foco: Downtime Planejado)
> **Pergunta:** *"Qual é o melhor dia da semana e horário em que a clínica está completamente fechada ou com o menor fluxo possível de atendimentos, onde nossa equipe de tecnologia possa desligar o sistema por alguns minutos para realizar melhorias e atualizações de segurança?"*
* **Resposta do Diretor da Clínica (Linguagem de Negócio):**
    > *"Nossa clínica funciona de segunda a sexta-feira das 07:00 às 21:00, e aos sábados das 08:00 às 14:00. O único momento em que a clínica está totalmente vazia e sem nenhum atendimento em andamento é aos sábados após as 16h e nos domingos o dia inteiro."*

---

### Contexto criado por IA para reforçar o trabalho.
##  Justificativa Arquitetural (Métricas Técnicas Extraídas)

- Para extrair os requisitos reais de resiliência e disponibilidade com a diretoria e o corpo médico da clínica, foram definidas as seguintes perguntas estratégicas (evitando termos como SLA, RPO ou Uptime):

Com base nas respostas esperadas para esse tipo de negócio (Saúde/Clínica), a arquitetura deve ser desenhada considerando:

* **SLA Alto:** Prontuários médicos são críticos. Uma queda impede o médico de receitar ou ver o histórico do paciente. A meta deve ser de no mínimo **99.9% de uptime** durante o horário comercial.
* **RPO Baixo:** Perder dados de saúde é um risco jurídico e operacional grave. O RPO ideal deve ser de **no máximo 1 hora** (backups frequentes ou replicação de banco de dados).
* **Janela de Manutenção Estrita:** Geralmente nas madrugadas de sábado para domingo ou domingos o dia todo, quando clínicas particulares não costumam realizar consultas eletivas.
