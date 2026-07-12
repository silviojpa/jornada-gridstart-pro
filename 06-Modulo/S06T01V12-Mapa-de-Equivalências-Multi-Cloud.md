# Mapa de Equivalências Multi-Cloud
**Aluno:** Silvio Luiz da Silva Ezequiel
**Data:** 12 de julho de 2026

## Tabela de Equivalências

| Conceito Universal | Definição Universal | AWS | GCP | Azure | MagaluCloud |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Rede privada isolada** | Espaço de rede virtual sob controle exclusivo do usuário, com range de IPs configurável, onde os recursos da conta são alocados. | VPC (Virtual Private Cloud) | VPC Network | VNet (Virtual Network) | VPC (Virtual Private Cloud) |
| **Sub-rede dentro da rede privada** | Segmentação lógica de um bloco de IP (CIDR) da rede privada para isolar e organizar recursos por critérios geográficos ou de segurança. | Subnet | Subnet | Subnet | Subnet |
| **Regra de segurança de rede (entrada/saída)** | Mecanismo de firewall que filtra de forma granular o tráfego de dados permitido para entrar ou sair de recursos de computação ou sub-redes. | Security Group / Network ACL | Firewall Rules | Network Security Group (NSG) | Security Group |
| **Máquina virtual (servidor na nuvem)** | Instância computacional isolada que executa um sistema operacional sobre uma camada de virtualização utilizando recursos físicos compartilhados. | EC2 Instance | Compute Engine VM Instance | Virtual Machine (VM) | Instância Virtual / Virtual Machine |
| **Imagem de sistema operacional** | Arquivo de template pré-configurado contendo o sistema operacional, drivers e softwares base necessários para iniciar uma máquina virtual. | AMI (Amazon Machine Image) | OS Image | VM Image | Imagem / OS Image |
| **Tipo/tamanho de máquina (CPU+RAM)** | Especificação de dimensionamento que define a quantidade exata de núcleos de processamento virtual, memória RAM e capacidade de performance de uma instância. | Instance Type (ex: t3.medium) | Machine Type (ex: e2-medium) | VM Size (ex: Standard_D2s_v5) | Sabor / Flavor / Tamanho |
| **Chave de acesso via SSH** | Par de chaves criptográficas (pública/privada) utilizado para autenticar e garantir o acesso remoto seguro à linha de comando de uma máquina virtual. | Key Pair | SSH Keys | SSH Key Pair | Chave SSH / Key Pair |
| **Balanceador de carga (distribui tráfego)** | Serviço de rede que distribui automaticamente o tráfego de entrada de aplicativos entre vários servidores saudáveis para garantir escalabilidade e HA. | ELB (Elastic Load Balancing) | Cloud Load Balancing | Azure Load Balancer / Application Gateway | Load Balancer |
| **Armazenamento de objetos (arquivos, imagens, backups)** | Repositório redundante e infinitamente escalável para guardar dados não estruturados (arquivos), acessíveis diretamente via APIs HTTP/HTTPS. | Amazon S3 | Cloud Storage | Blob Storage | Object Storage / Armazenamento de Objetos |
| **Banco de dados relacional gerenciado** | Serviço de motor de banco de dados SQL onde a nuvem cuida do provisionamento, patches, backups e alta disponibilidade, restando ao usuário apenas o esquema de dados. | Amazon RDS | Cloud SQL | Azure SQL Database / Azure Database for PostgreSQL | Banco de Dados Gerenciado / Managed Database |

---

## Surpresas encontradas

### 1. Escopo de Fronteira e Alocação da Rede Privada (VPC)
* **Diferença de comportamento:** Na AWS, na Azure e na MagaluCloud, a rede privada (VPC/VNet) possui um escopo estritamente **regional**. Isso significa que, para interligar máquinas que estão em regiões geográficas diferentes (por exemplo, São Paulo e Virgínia), você é obrigado a configurar um componente de pareamento (*VPC Peering* ou *VNet Peering*) para que elas se comuniquem. Já no Google Cloud (GCP), a VPC possui por padrão um escopo **global**. Uma única rede pode conter sub-redes espalhadas por qualquer datacenter do planeta, permitindo que as instâncias conversem via IP privado interno sem nenhuma configuração extra de roteamento ou túneis de trânsito internacional.
* **Documentação de referência:** [GCP VPC Network Overview](https://cloud.google.com/vpc/docs/vpc)

### 2. Ciclo de Vida Obrigatório e Acoplamento de Recursos (Resource Groups)
* **Diferença de comportamento:** Na AWS e no GCP, os recursos de infraestrutura (como uma máquina virtual ou um disco) podem ser criados de maneira isolada ou "solta" dentro de um projeto ou região. Na Microsoft Azure, o comportamento é completamente diferente: **nenhum recurso pode existir sem pertencer obrigatoriamente a um Resource Group (Grupo de Recursos)**. O Resource Group funciona como um container lógico que dita o ciclo de vida dos componentes; se você deletar o Resource Group, a Azure apaga instantaneamente todos os recursos associados de forma cascateada, além de centralizar as políticas de permissão de acesso (IAM) e faturamento por essa fronteira lógica.
* **Documentação de referência:** [Azure Resource Manager Overview](https://learn.microsoft.com/azure/azure-resource-manager/management/overview)
