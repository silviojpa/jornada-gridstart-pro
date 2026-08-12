# Atividade - S06T04V02: Identidade e Acesso (IAM) na AWS
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 12 de agosto de 2026[cite: 14]  

---

## PARTE 1 — Múltipla Escolha

| Questão | Alternativa Correta | Justificativa |
| :--- | :---: | :--- |
| **1. Autenticação vs. Autorização** | **c** | Autenticação verifica a identidade (*quem você é*), enquanto autorização define as permissões (*o que você pode fazer*)[cite: 14]. |
| **2. Conta Root na AWS** | **b** | A conta Root tem acesso irrestrito e incondicional a todos os recursos da conta e não pode ter seus privilégios limitados por IAM Policies[cite: 14]. |
| **3. Interpretação de Policy JSON** | **b** | A ação `s3:GetObject` com o efeito `Allow` concede permissão de leitura/download para os objetos do bucket especificado[cite: 14]. |
| **4. Comando de credenciais AWS CLI** | **c** | O comando `aws configure` solicita Access Key, Secret Key, região padrão e formato de saída para criar o arquivo de perfil local[cite: 14]. |

---

## PARTE 2 — Verdadeiro ou Falso

| # | Afirmação | (V / F) | Justificativa / Correção |
| :-: | :--- | :-: | :--- |
| **5** | Uma Role no IAM pertence sempre a uma pessoa específica, como um usuário IAM[cite: 14]. | **(F)** | Uma Role não pertence a um único usuário; ela é assumida temporariamente por usuários, aplicações ou serviços da AWS[cite: 14]. |
| **6** | O Credential Report mostra quando cada usuário usou sua senha ou Access Key pela última vez[cite: 14]. | **(V)** | Trata-se de um relatório de auditoria do IAM que lista o status de senhas, chaves de acesso e MFA de todos os usuários[cite: 14]. |
| **7** | A ação `"ec2:*"` é mais alinhada ao Princípio do Menor Privilégio que `"ec2:DescribeInstances"`[cite: 14]. | **(F)** | `"ec2:*"` concede permissões totais sobre o EC2 (viola o menor privilégio); `"ec2:DescribeInstances"` limita o acesso a apenas leitura/listagem[cite: 14]. |
| **8** | O AWS Organizations permite agrupar contas em OUs e aplicar regras globais de uma vez[cite: 14]. | **(V)** | Permite o gerenciamento centralizado de múltiplas contas organizadas em OUs através de SCPs (Service Control Policies)[cite: 14]. |

---

## PARTE 3 — Resposta Aberta

### 9. Análise sobre o uso da conta Root no dia a dia:

> **Problemas concretos da decisão:**
> 1. **Alto risco de segurança e ausência de barreira de contenção:** A conta Root possui privilégios administrativos absolutos e irrestritos[cite: 14]. Caso as credenciais sejam vazadas ou comprometidas, um atacante pode apagar toda a infraestrutura, fechar a conta ou gerar custos astronômicos sem nenhuma política do IAM capaz de bloqueá-lo[cite: 14].
> 2. **Perda de auditabilidade e rastreabilidade (CloudTrail):** Se o login Root for compartilhado e utilizado para rotinas diárias, é impossível identificar no log do AWS CloudTrail qual membro da equipe realizou uma alteração específica no ambiente[cite: 14].
> 
> **O que deveria ser feito no lugar:**
> Ativar o fator de dupla autenticação (MFA) na conta Root, guardar suas credenciais em local seguro e utilizá-la apenas para tarefas de criação/faturamento inicial[cite: 14]. Para o uso cotidiano, deve-se criar usuários/grupos via **AWS IAM Identity Center** (ou IAMUsers) atribuindo papéis (*Roles*) e políticas de acesso específicas baseadas nas funções de cada integrante do time[cite: 14].

---

### 10. Conexão entre a analogia, o Princípio do Menor Privilégio e exemplo prático de Policy:

> **Explicação da analogia:**
> A frase reflete a essência do **Princípio do Menor Privilégio (Least Privilege)**[cite: 14]. Assim como entregar a chave física do veículo a alguém não exige conceder acesso irrestrito para desmontar ou modificar partes internas do motor, uma entidade ou aplicação na nuvem deve receber estritamente o conjunto mínimo de permissões necessárias para cumprir sua tarefa específica, nada mais[cite: 14].
> 
> **Exemplo Prático de Policy JSON:**
> Suponha uma aplicação executada em uma instância EC2 que precisa apenas ler arquivos de configuração de um bucket S3 específico (`app-config-bucket`)[cite: 14]. Em vez de conceder acesso total ao S3 (`s3:*`), aplica-se a seguinte policy restrita:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PermitirApenasLeituraConfiguracoes",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::app-config-bucket/*"
    }
  ]
}
