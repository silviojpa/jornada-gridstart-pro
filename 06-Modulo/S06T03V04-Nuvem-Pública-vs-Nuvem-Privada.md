# Atividade - S06T03V04: Nuvem Pública vs. Nuvem Privada
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Infraestrutura compartilhada com isolamento lógico** | **b** | *Multi-tenancy* é a arquitetura onde múltiplos clientes compartilham os mesmos recursos físicos sob isolamento lógico estrito[cite: 15]. |
| **2. Controle físico e auditável de dados de saúde** | **c** | Ambientes de nuvem privada garantem o controle físico e perimetral exigidos por regras estritas de custódia e auditoria[cite: 15]. |
| **3. Vantagem financeira da nuvem pública** | **b** | Elimina o *CapEx* (investimento de capital em hardware) e transfere o custo para *OpEx* (despesa operacional proporcional ao uso)[cite: 15]. |
| **4. Repatriação de cargas de trabalho** | **c** | A repatriação (retorno ao on-premise) faz sentido econômico quando as cargas de trabalho são muito estáveis, previsíveis e com alto consumo[cite: 15]. |
| **5. Função do AWS Outposts** | **b** | Permite estender a infraestrutura física e os serviços nativos da AWS para o data center local do cliente, rodando APIs de forma idêntica[cite: 15]. |
| **6. Inicialização de startup com demanda imprevisível** | **c** | A nuvem pública oferece a elasticidade necessária para absorver variações e evita custos iniciais com aquisição de servidores[cite: 15]. |
| **7. Conceito de CapEx e OpEx** | **c** | Na nuvem pública, o modelo de pagamento por consumo (pay-as-you-go) se enquadra perfeitamente na contabilidade como despesa operacional (*OpEx*)[cite: 15]. |

---

## PARTE 2 - Análise de Cenário (FinTrack)

### Questão A: Análise das Três Variáveis de Decisão aplicadas à FinTrack

Com base nas três variáveis apresentadas em aula para avaliar a viabilidade de repatriação ou manutenção em nuvem pública:

1. **Previsibilidade da Carga:** A carga de trabalho da FinTrack é **extremamente estável e previsível** (2 milhões de transações diárias com variação máxima de apenas 15% para mais ou para menos)[cite: 15]. Não há picos sazonais agressivos inesperados, o que é um indicador clássico de que o ambiente se adequaria muito bem a uma nuvem privada de custo fixo[cite: 15].
2. **Volume de Dados/Computação:** A empresa opera uma volumetria robusta com 80 servidores rodando com **alta taxa de eficiência média (85% de capacidade)**, gerando uma fatura considerável de R$ 180.000/mês[cite: 15]. Quando a infraestrutura opera em alto volume de forma constante, a nuvem pública tende a ser mais cara do que amortizar hardware próprio a médio/longo prazo[cite: 15].
3. **Requisitos Não-Funcionais (Segurança e Conformidade):** Por lidar com transações e dados financeiros regulados pelo Banco Central e submetidos à LGPD, existem barreiras severas de isolamento de rede, criptografia de dados em repouso e rastreabilidade total de acessos[cite: 15].

---

### Questão B: Influência dos Requisitos Regulatórios (Banco Central e LGPD)

Tanto as normas do **Banco Central do Brasil** (como a Resolução CMN n° 4.893 de segurança cibernética) quanto a **LGPD** não proíbem o uso de nuvem pública, contanto que haja auditoria rígida, controle de acesso e criptografia de ponta a ponta[cite: 15]. 

*   **Na Nuvem Pública:** O compliance exige que a FinTrack configure controles robustos adicionais de criptografia com chaves gerenciadas pelo cliente (KMS/HSM), auditorias constantes de acessos (AWS CloudTrail/Config) e contratos claros de soberania de dados. Isso pode elevar a complexidade e o custo de licenciamento de segurança[cite: 15].
*   **Na Nuvem Privada:** Facilita a auditoria de presença física de servidores por órgãos reguladores e garante a soberania total de onde os dados estão armazenados localmente no país. No entanto, transfere toda a responsabilidade de implementar controles físicos de segurança, redundância elétrica e prevenção de desastres (que na nuvem pública já vêm prontos) para a própria FinTrack[cite: 15].

---

### Questão C: A Terceira Opção e Solução AWS Correspondente

A alternativa ideal para a FinTrack que foge da dicotomia binária é a adoção de uma estratégia de **Nuvem Híbrida**[cite: 15]. Com essa arquitetura, a fintech pode manter o núcleo transacional, o banco de dados principal e dados críticos de clientes em uma nuvem privada on-premise (para controle regulatório rígido, conformidade e economia com volumetria constante de rede)[cite: 15], enquanto utiliza a nuvem pública para desenvolvimento, testes, backups redundantes ou serviços de atendimento ao cliente menos críticos[cite: 15].

*   **Solução da AWS Relevante para Avaliação:** A FinTrack deve avaliar o **AWS Outposts**[cite: 15]. Ele entrega racks de hardware físico homologados pela AWS diretamente no data center privado da fintech, garantindo o processamento local de baixíssima latência e conformidade regulatória, ao mesmo tempo que mantém a consistência operacional utilizando as mesmas APIs, consoles, ferramentas de monitoramento e automações que eles já usam na nuvem pública da AWS[cite: 15].
