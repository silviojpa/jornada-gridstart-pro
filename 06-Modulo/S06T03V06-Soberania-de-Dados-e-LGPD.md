# Atividade - S06T03V06: Soberania de Dados e LGPD no Compliance de Nuvem
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de julho de 2026  

---

## PARTE 1 - Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Alcance judicial estrangeiro** | **b** | A submissão jurídica da controladora (empresa americana) à sua jurisdição de origem sobressai-se à localização física dos servidores[cite: 15]. |
| **2. Lei americana extraterritorial** | **b** | O **CLOUD Act (2018)** permite explicitamente que autoridades dos EUA exijam dados sob controle de empresas sob sua jurisdição, mesmo que guardados no exterior[cite: 15]. |
| **3. Alcance da LGPD** | **b** | A LGPD adota o critério de extraterritorialidade, aplicando-se a qualquer dado coletado ou tratado que vise oferecer bens/serviços no Brasil[cite: 15]. |
| **4. Transferência internacional (Art. 33)** | **b** | Exige-se que o país receptor garanta proteção equivalente ou que o controlador forneça salvaguardas contratuais robustas homologadas[cite: 15]. |
| **5. Regra do Bacen para nuvem estrangeira** | **b** | O Banco Central permite o uso de nuvem no exterior, exigindo apenas comunicação prévia, indicação clara do país de guarda e garantia de auditoria local[cite: 15]. |
| **6. Informação governamental ultrassecreta** | **c** | Dados de segurança nacional classificados como "ultrassecretos" não podem trafegar ou ser armazenados em nuvens de terceiros públicas, privadas ou híbridas[cite: 15]. |
| **7. Requisitos da Nuvem Soberana** | **b** | A soberania real exige que toda a cadeia (física, jurídica e operacional/suporte) esteja estritamente blindada contra leis de escopo extraterritorial[cite: 15]. |

---

## PARTE 2 - Análise de Cenário (TrilhaPay)

### Questão A: O banco de dados de transações financeiras é candidato a migrar para uma nuvem soberana brasileira?

> **Resposta:** **Sim, é um candidato fortíssimo.**
> 
> **Justificativa:** Como o banco de dados armazena o histórico financeiro e cadastral de mais de 2 milhões de brasileiros, mantê-lo sob o guarda-chuva de um *hyperscaler* americano deixa a TrilhaPay diretamente vulnerável ao **CLOUD Act (2018)**[cite: 15]. Sob essa lei, a justiça dos EUA pode intimar o provedor norte-americano a entregar dados de correntistas brasileiros armazenados no território nacional sem passar pela homologação do judiciário brasileiro[cite: 15]. Migrar esse núcleo transacional para uma nuvem soberana genuinamente brasileira (onde a empresa operadora e a infraestrutura física respondem exclusivamente à soberania e às leis nacionais) elimina completamente o risco de intervenções judiciais extraterritoriais ilegítimas perante a LGPD[cite: 15].

---

### Questão B: O novo painel de analytics/BI precisa necessariamente seguir para a nuvem soberana?

> **Resposta:** **Não, necessariamente.**
> 
> **Justificativa:** O painel de BI e inteligência de negócios pode operar de forma segura no *hyperscaler* atual se a TrilhaPay adotar estratégias eficientes de **anonimização ou pseudonimização prévia dos dados** antes de enviá-los para a ferramenta de análise[cite: 15]. Se os registros de transações forem transformados em dados estritamente estatísticos e agregados (sem conter nomes, CPFs, números de cartões ou identificadores pessoais), eles deixam de ser enquadrados como dados pessoais sob o escopo da LGPD[cite: 15]. Dessa forma, o processamento analítico pode usufruir da escalabilidade e dos recursos nativos de BI do provedor atual sem violar os requisitos rígidos de soberania de dados do core bancário[cite: 15].

---

### Questão C: Complexidade regulatória adicional com a expansão para a União Europeia

> **Resposta:** Com a entrada na União Europeia, a TrilhaPay passa a responder diretamente ao **GDPR (General Data Protection Regulation)**[cite: 15]. 
> 
> **Explicação:** O conceito envolvido é o de **Soberania Digital e Fluxo Transfronteiriço de Dados**[cite: 15]. Pelo GDPR, os dados de cidadãos europeus não podem ser transferidos livremente para países terceiros (como o Brasil ou os EUA) a menos que estes possuam uma decisão de adequação da Comissão Europeia ou que sejam estabelecidas cláusulas contratuais padrão estritas (*Standard Contractual Clauses - SCCs*)[cite: 15]. O desafio técnico-jurídico é garantir o isolamento geográfico de que os dados coletados na Europa permaneçam em servidores em solo europeu e sob controle exclusivo, sem se misturar inadvertidamente com as bases de dados brasileiras na ausência de acordos bilaterais de transferência de dados[cite: 15].
