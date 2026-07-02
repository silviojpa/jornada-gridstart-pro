# Atividade - Decidindo o que Automatizar na Achei.app em Escala

> "A prática é o único lugar onde o aprendizado vira habilidade."

**Objetivo:** Aplicar os três critérios do `quickwin_score` (vistos em S05T01V11 — repetitiva, bem definida, erro custoso) a um cenário de infraestrutura real, com múltiplas instâncias por serviço, pra decidir o que automatizar primeiro quando a Achei.app entra em produção em escala[cite: 14].  
**Tipo:** Diagnóstico + pontuação + justificativa escrita — sem terminal, sem script[cite: 14].  
**Tempo estimado:** 10-15 minutos[cite: 14]  
**Entrega:** Tabela de pontuação preenchida + respostas escritas às duas questões abaixo[cite: 14].

---

## Contexto (cenário fictício)

A Achei.app já está em produção com os cinco microsserviços divididos em V03 (Identidade, Catálogo, Carrinho, Pagamento e Notas Fiscais) — e cada um deles agora roda com várias instâncias simultâneas, pra suportar volume e resiliência[cite: 14]. O time de operações tem uma lista de quatro tarefas operacionais recorrentes e precisa decidir o que automatizar primeiro, usando os mesmos três critérios do `quickwin_score`[cite: 14]:

*   **REPETITIVA:** a tarefa acontece com frequência, sempre de forma parecida?[cite: 14]
*   **BEM_DEFINIDA:** existe um jeito claro e documentado de fazer, sem ambiguidade?[cite: 14]
*   **ERRO CUSTOSO:** o erro humano nela já causou, ou tem potencial real de causar, problema de verdade?[cite: 14]

### Critério de Classificação:
*   **Pontuação 3/3:** Automatizar agora (quick win)[cite: 14]
*   **Pontuação 2/3:** Automatizar com cautela / ajustar processo/critério primeiro[cite: 14]
*   **Pontuação 0 ou 1:** Não automatizar ainda — é problema de investigação ou de pessoas/processo[cite: 14]

---

## As Quatro Tarefas

*   **A - Deploy de nova versão de um serviço em todas as instâncias:** Sempre que uma nova versão do serviço de Pagamento é liberada, alguém do time precisa substituir a versão antiga pela nova em todas as instâncias daquele serviço, seguindo sempre a mesma sequência: build, teste rápido, substituição gradual[cite: 14].
*   **B - Verificação de saúde e reinício de instância travada:** Periodicamente, o time verifica se cada instância está respondendo corretamente (via um endpoint de "saúde" já documentado) e, se uma instância específica parar de responder, ela precisa ser reiniciada[cite: 14].
*   **C - Investigação de um bug intermitente raro:** Dois usuários relataram, no último mês, um comportamento estranho na tela de Carrinho que ninguém no time conseguiu reproduzir ainda. Não há padrão claro de quando ou por que acontece[cite: 14].
*   **D - Decisão de quantas instâncias adicionais colocar no ar num pico de tráfego:** Quando o tráfego sobe (por exemplo, numa promoção), o time precisa decidir quantas instâncias extras de cada serviço colocar no ar. Isso acontece em todo pico — mas o time ainda está calibrando qual o ponto exato (qual métrica, qual limiar) que indica "está na hora de escalar"[cite: 14]. 
---

## Questões

### 1. Tabela de Pontuação

| Tarefa | Repetitiva | Bem definida | Erro custoso | Pontuação | Classificação |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **A** | 1 | 1 | 1 | **3** | Automatizar agora |
| **B** | 1 | 1 | 1 | **3** | Automatizar agora |
| **D** | 1 | 0 | 1 | **2** | Automatizar com cautela |
| **C** | 0 | 0 | 1 | **1** | Não automatizar ainda |

### 2. Por que não automatizar a tarefa C agora?
Mesmo sendo uma tarefa importante (o erro pode ser custoso pro usuário), explique por que automatizar a investigação da tarefa C agora seria um erro, usando os critérios do vídeo.

> **Resposta fictícia:** Automatizar a tarefa C seria um erro grave porque ela falha nos critérios fundamentais de ser repetitiva e bem definida. Como o bug é intermitente, raro e sem padrão claro, não existe um processo lógico estruturado ou documentado para uma automação seguir. Tentar escrever um script para algo que os próprios humanos ainda não conseguem reproduzir ou compreender transformaria a automação numa ferramenta inútil ou geradora de falsos positivos, reforçando que este é um problema de investigação analítica (observabilidade, análise de logs), e não de automação.

### 3. O que falta pra automatizar a tarefa D com segurança?
A tarefa D não está pronta pra automação total ainda, mas também não é como a tarefa C. O que especificamente precisa ser definido antes do time poder automatizar essa decisão de escala?

> **Resposta fictícia:** Para que a tarefa D possa ser automatizada com total segurança, falta estabelecer uma definição clara e sem ambiguidades dos critérios de gatilho para a escala (o limiar exato). O time precisa transformar a intuição humana em dados objetivos definindo qual métrica monitorar (ex: uso de CPU acima de 80% ou latência de requisições acima de 200ms) por quanto tempo esse pico deve se manter estável para acionar o gatilho, e exatamente quantas instâncias extras devem ser adicionadas por bloco. Uma vez que essa calibração de regras e limites estiver documentada, a tarefa passa de "automatizar com cautela" (2/3) para uma automação segura (3/3).

---

**Dica de pit stop:** Se uma tarefa ainda depende de alguém "investigar" ou "decidir no sentimento", ela não está bem definida — não importa quão repetitiva ou custosa ela pareça[cite: 14]. Automação exige um critério claro pra seguir, não intuição de quem está de plantão[cite: 14].
