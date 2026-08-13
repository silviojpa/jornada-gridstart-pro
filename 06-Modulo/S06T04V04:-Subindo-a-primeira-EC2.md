# Caderno de Atividades Práticas — Módulo 6 (Cloud Computing - Tópico 4)
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 12 de agosto de 2026  

---

## 1. ATIVIDADE — S06T04V04: Subindo a primeira EC2 (AWS)

### Checklist de Execução e Evidências
- [x] **Parte 1 (AMI e Tipo):** Instância `gridstart-ec2-01` criada utilizando Ubuntu Server LTS (Free Tier) e tipo `t2.micro` / `t3.micro`.
- [x] **Parte 2 (Rede):** Alocada na VPC `gridstart-vpc`, Subnet `gridstart-subnet-publica` com *Auto-assign public IP* habilitado.
- [x] **Parte 3 (Security Group):** Criado `gridstart-sg-web` com regras de SSH (Porta 22 / Origem: My IP) e HTTP (Porta 80 / Origem: 0.0.0.0/0).
- [x] **Parte 4 (Key Pair):** Chave `gridstart-key.pem` baixada e permissões ajustadas no terminal com `chmod 400 gridstart-key.pem`.
- [x] **Parte 5 (Lançamento e Conexão):** Instância no status *Running* e acesso SSH confirmado via `ssh -i gridstart-key.pem ubuntu@<IP_PUBLICO_AWS>`.

### Parte 6 — Verificação Final

> **1. Se você tivesse escolhido uma AMI Amazon Linux em vez de Ubuntu, qual comando de atualização de pacotes você usaria no lugar de `apt update`?**  
> **Resposta:** No Amazon Linux (AL2 ou AL2023), o gerenciador de pacotes padrão é o `dnf` (ou `yum` nas versões legadas). O comando equivalente utilizado no lugar do `apt update` seria **`sudo dnf update`** (ou **`sudo yum update`**).

> **2. Por que a regra de SSH usa *My IP* como origem, e não *Anywhere*, enquanto a regra de HTTP usa *Anywhere*?**  
> **Resposta:** A porta de SSH (22) é um ponto de acesso administrativo crítico do servidor; restringi-la ao seu próprio IP (*My IP*) segue o princípio da menor exposição, evitando ataques bruteforce e varreduras automatizadas globais. Já a porta HTTP (80) serve para disponibilizar um serviço ou site público para a internet, devendo aceitar requisições vindas de qualquer endereço IP (*Anywhere* / `0.0.0.0/0`).

---

## 2. ATIVIDADE — S06T04V05: Identidade, Acesso e Redes na MagaluCloud

### Checklist de Execução e Evidências
- [x] **Parte 1:** Chave gerada via `ssh-keygen -t rsa -b 4096 -f ~/.ssh/gridstart-mgc-key` e exibida com `cat ~/.ssh/gridstart-mgc-key.pub`.
- [x] **Parte 2:** Chave pública registrada na MagaluCloud com `mgc profile ssh-keys create --name="gridstart-mgc-key"` e confirmada via `mgc profile ssh-keys list`.
- [x] **Parte 3:** API Key criada via `mgc auth api-key create --name="gridstart-api-key"` com escopo `Virtual Machine [Read]` e validada via `mgc auth api-key get <uuid>`.
- [x] **Parte 4:** Navegação realizada pelas abas *Geral*, *Subnet* e *Blocos CIDR* da VPC padrão no console da MGC.

### Parte 5 — Verificação Final

> **1. Na AWS, a chave privada `.pem` é gerada pela própria AWS e baixada uma única vez. Na MGC, quem gera o par de chaves SSH, e o que exatamente é enviado para a MagaluCloud?**  
> **Resposta:** Na MagaluCloud, a responsabilidade de gerar o par de chaves é do **próprio usuário** em seu ambiente local (utilizando comandos como `ssh-keygen`). Para a infraestrutura da MagaluCloud é enviada e cadastrada unicamente a **chave pública** (`.pub`), garantindo que a chave privada nunca saia da máquina local do usuário.

> **2. Você tentou criar uma nova VPC direto pela tela de Network do console MGC e não encontrou a opção. Isso é um bug ou é esperado? Onde essa ação deveria ser feita?**  
> **Resposta:** É um **comportamento esperado** da plataforma. No estágio atual do console web, a MGC disponibiliza uma VPC padrão pré-alocada para o tenant/região. A criação e o gerenciamento avançado de novas estruturas de redes e subnets são realizados via **MGC CLI** ou através de chamadas diretas de **API / Terraform**.

> **3. Que produto da MagaluCloud reúne conceitos como grupos, membros, papéis e service accounts parecido com o vocabulário do IAM da AWS e o que precisa ser feito antes de usá-lo?**  
> **Resposta:** Trata-se do **MagaluCloud IAM / IdP (Identity Provider)**. Antes de utilizá-lo, é necessário autenticar a sessão do usuário/organização no ambiente via CLI (`mgc auth login` ou API Key) e possuir o perfil administrativo para vincular papéis (*Roles*) e políticas de acesso aos membros e contas de serviço (*Service Accounts*).

---

## 3. ATIVIDADE PRÁTICA — S06T04V06: Subindo sua própria VM na MagaluCloud

### Script e Comandos de Implementação
```bash
# 1. Seleção de Flavor e Imagem
mgc virtual-machine machine-types list
mgc virtual-machine images list

# 2. Criação do Grupo de Segurança Customizado
mgc network security-groups create --name "gridstart-mgc-sg"

# 3. Adição da Regra de Saída (Egress - Obrigatória para Boot)
mgc network security-groups rules create \
  --security-group-id <SG_ID> \
  --direction egress \
  --ethertype IPv4 \
  --port-range-min 1 --port-range-max 65535 \
  --remote-ip-prefix 0.0.0.0/0

# 4. Adição da Regra de Entrada (Ingress - SSH Restrito ao IP)
mgc network security-groups rules create \
  --security-group-id <SG_ID> \
  --direction ingress \
  --ethertype IPv4 \
  --port-range-min 22 --port-range-max 22 \
  --remote-ip-prefix <SEU_IP_ATUAL>/32

# 5. Provisionamento da VM
mgc virtual-machine instances create \
  --name "gridstart-mgc-vm01" \
  --machine-type "BV2-4-20" \
  --image-id <IMAGE_ID_UBUNTU> \
  --ssh-key-name "gridstart-mgc-key" \
  --security-group-ids <SG_ID> \
  --associate-public-ip true

# 6. Validação do Status
mgc virtual-machine instances get --id <INSTANCE_ID>
````
----------

## 4. ATIVIDADE PRÁTICA — S06T04V07: Conectando e blindando suas próprias VMs via SSH
```Bash
# 1. Ajuste de Permissões das Chaves Privadas (Local)
chmod 400 gridstart-key.pem
chmod 400 ~/.ssh/gridstart-mgc-key

# 2. Acesso e Atualização da VM AWS
ssh -i gridstart-key.pem ubuntu@<IP_PUBLICO_AWS>
sudo apt update && sudo apt upgrade -y
exit

# 3. Acesso e Atualização da VM MagaluCloud
ssh -i ~/.ssh/gridstart-mgc-key ubuntu@<IP_PUBLICO_MGC>
sudo apt update && sudo apt upgrade -y
exit
````
<img width="775" height="407" alt="image" src="https://github.com/user-attachments/assets/fe388e69-0b77-431a-816a-56757645ad5a" />

## 5. ATIVIDADE PRÁTICA — S06T04V09: Do disco cru ao disco persistente

* Etapa AWS (EBS Volume)
````Bash
# 1. Identificar o disco cru anexado (ex: /dev/xvdf)
lsblk

# 2. Formatar o volume com sistema de arquivos ext4
sudo mkfs.ext4 /dev/xvdf

# 3. Criar ponto de montagem e montar
sudo mkdir -p /mnt/data
sudo mount /dev/xvdf /mnt/data
df -h

# 4. Obter o UUID do disco para persistência segura
sudo blkid /dev/xvdf

# 5. Adicionar entrada no /etc/fstab usando o UUID
# Adicionar no final do arquivo /etc/fstab:
# UUID=<SEU_UUID_AWS>  /mnt/data  ext4  defaults,nofail  0  2

# 6. Testar persistência antes de reiniciar
sudo umount /mnt/data
sudo mount -a
df -h
````
* Etapa MagaluCloud (Block Storage)
````Bash
# 1. Criar e Anexar o Volume via MGC CLI
mgc block-storage volumes create --name "gridstart-vol01" --size 10 --type-name "cloud_nvme1k"
mgc block-storage volumes attach --id <VOLUME_ID> --virtual-machine-id <VM_ID>

# 2. Na VM MGC: Identificar, Formatar e Montar (ex: /dev/vdb)
lsblk
sudo mkfs.ext4 /dev/vdb
sudo mkdir -p /mnt/data
sudo mount /dev/vdb /mnt/data

# 3. Persistência via UUID
sudo blkid /dev/vdb
# Editar /etc/fstab:
# UUID=<SEU_UUID_MGC>  /mnt/data  ext4  defaults,nofail  0  2

# 4. Validar montagem sem erros
sudo umount /mnt/data
sudo mount -a
````
