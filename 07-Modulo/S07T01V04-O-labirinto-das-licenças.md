# Atividade — S07T01V04: O labirinto das licenças - decisão de ferramenta
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 19 de agosto de 2026  

---

## PARTE 1 — Fixação de Conceitos

### 1. Diferença entre Docker Engine e Docker Desktop e cobrança de licença:
> **Resposta:** O **Docker Engine** é o motor de contêineres open-source (projeto Moby, licença Apache 2.0) que roda nativamente no Linux[cite: 16]. O **Docker Desktop** é um produto comercial proprietário que empacota o Docker Engine com uma interface gráfica (GUI), uma máquina virtual Linux integrada (WSL2/Hyper-V/Virtualization Framework), Kubernetes local e extensões[cite: 16]. A cobrança só existe para o Docker Desktop porque a marca Docker Inc. detém os direitos da camada proprietária do aplicativo de desktop[cite: 16].

---

### 2. Os dois critérios de licença paga do Docker Desktop e o operador lógico ("E" vs "OU"):
> **Resposta:** Os dois critérios são:  
> 1. Ter **mais de 250 funcionários**[cite: 16]; **OU**  
> 2. Faturar **mais de US$ 10 milhões** em receita anual[cite: 16].  
> 
> **Diferença prática do operador "OU":** Os critérios funcionam de forma independente (*OU*)[cite: 16]. Basta atingir **apenas um** dos limites para que a licença paga seja obrigatória[cite: 16]. Por exemplo: uma empresa de 10 funcionários que fatura US$ 11 milhões **é obrigada** a pagar, assim como uma empresa de 300 funcionários que fatura apenas US$ 1 milhão[cite: 16].

---

### 3. Causa técnica para a dependência de uma VM Linux no Windows e no Mac:
> **Resposta:** Os contêineres dependem nativamente das primitivas do kernel Linux (`namespaces` para isolamento e `cgroups` para limites de recursos)[cite: 16]. Como os sistemas operacionais macOS (kernel Darwin/XNU) e Windows (kernel NT) não possuem o kernel Linux rodando nativamente, é obrigatório subir uma Máquina Virtual Linux leve por baixo para fornecer essas funcionalidades do kernel ao Docker Daemon[cite: 16].

---

### 4. Tecnologias de virtualização no Windows e Mac e a diferença entre WSL1 e WSL2:
> **Resposta:**  
> * **Windows:** Utiliza **WSL2** ou **Hyper-V**[cite: 16].  
> * **Mac:** Utiliza **Apple Virtualization Framework** ou **HyperKit**[cite: 16].  
> 
> **Diferença WSL1 vs WSL2:** O WSL1 não possuía um kernel Linux real; ele fazia uma tradução das chamadas de sistema (syscalls) do Linux para o kernel NT do Windows, inviabilizando o suporte completo a `namespaces` e `cgroups`[cite: 16]. O **WSL2** utiliza uma VM com um **kernel Linux completo e otimizado**, permitindo o funcionamento nativo e perfeito do Docker Engine[cite: 16].

---

### 5. Comparativo entre Rancher Desktop e OrbStack:
> **Resposta:**  
> * **Licenciamento:** O **Rancher Desktop** é 100% open-source e gratuito (licença Apache 2.0), inclusive para uso corporativo em grandes empresas[cite: 16]. O **OrbStack** é um software proprietário comercial (gratuito apenas para uso pessoal/não-comercial e pago para empresas)[cite: 16].  
> * **Plataforma:** O **Rancher Desktop** é multiplataforma (suporta Windows, macOS e Linux)[cite: 16]. O **OrbStack** é exclusivo para **macOS**[cite: 16].

---

## PARTE 2 — Análise de Cenários

### 6. Cenário 1: Startup de 35 funcionários com faturamento de US$ 12 milhões (Windows + Mac)
> **Conformidade:** **Não está em conformidade**[cite: 16]. Apesar de ter menos de 250 funcionários, a empresa ultrapassou o teto de faturamento de US$ 10 milhões (regra do "OU"), o que torna o uso do Docker Desktop irregular sem licença paga[cite: 16].  
> 
> **Alternativas gratuitas para o ambiente misto (Windows e Mac):**
> 1. **Rancher Desktop:** Funciona nativamente tanto em **Windows** quanto em **macOS**, fornecendo a CLI do Docker (`docker`) e suporte a contêineres de forma 100% gratuita para qualquer tamanho de faturamento[cite: 16].
> 2. **Colima + Docker CLI (no Mac) & Docker Engine direto no WSL2 (no Windows):** Solução baseada em ferramentas open-source via linha de comando, funcionando no **macOS** via Colima e no **Windows** via Ubuntu/WSL2 com o Docker Engine instalado diretamente[cite: 16].

---

### 7. Cenário 2: Squad de 8 devs em Mac, empresa de 120 funcionários e R$ 4 milhões faturados (foco em performance)
> **Enquadramento de licença paga:** **Não se enquadra**[cite: 16]. A empresa tem menos de 250 funcionários e faturamento bem abaixo do limite de US$ 10 milhões (R$ 4 mi ≈ US$ 700 mil), podendo usar a versão gratuita do Docker Desktop se quisesse[cite: 16].  
> 
> **Escolha técnica recomendada:** **OrbStack**[cite: 16].  
> 
> **Justificativa Técnica:** Como a equipe usa exclusivamente macOS e busca máxima performance, o OrbStack se destaca por ser desenvolvido em Swift nativo para Mac[cite: 16]. Ele utiliza uma camada de virtualização extremamente otimizada com consumo de CPU/RAM quase nulo em standby, integra o emulador Rosetta 2 nativamente para execução rápida de imagens x86_64 em chips Apple Silicon e oferece taxas de I/O de sistema de arquivos muito superiores ao Docker Desktop e Rancher Desktop[cite: 16].

---

### 8. Cenário 3: Arquiteto para empresa de 600 funcionários (Windows, Mac e Linux) buscando risco zero de compliance
> **Por que o Docker Desktop não é a opção mais segura de compliance:** Com 600 funcionários, a empresa se enquadra obrigatoriamente no modelo pago[cite: 16]. Manter centenas de instalações do Docker Desktop exige controle constante de assentos e auditoria de licenças ativas, gerando risco financeiro e de *non-compliance* caso funcionários instalem o aplicativo sem licença atribuída[cite: 16].  
> 
> **Ferramenta ideal sem risco:** **Rancher Desktop**[cite: 16].  
> 
> **Justificativa de licença:** O Rancher Desktop é totalmente open-source (Apache 2.0)[cite: 16]. Ele não possui modalidades de licença paga, limitações de assentos ou termos comerciais restritivos, garantindo **risco zero de compliance** independentemente do número de funcionários ou do faturamento futuro da empresa[cite: 16]. Ele também atende perfeitamente ao requisito de ser multiplataforma (Windows, Mac e Linux)[cite: 16].
