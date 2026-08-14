## ATIVIDADE PRÁTICA — S06T04V11: Seu próprio desafio multicloud
* Script de Automação (apache-setup.sh)
* Arquivo local criado para ser injetado como User Data em ambos os provedores:

````bash
#!/bin/bash
apt-get update -y
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>Servidor Web Multi-Cloud - GridStart Pro</h1><p>Hospedado na nuvem rodando no Host: $(hostname)</p>" > /var/www/html/index.html
````
* Execução na AWS
````bash
# Lançar nova instância com User Data
aws ec2 run-instances \
  --image-id ami-0c7217cdde317cfec \
  --count 1 \
  --instance-type t2.micro \
  --key-name gridstart-key \
  --security-group-ids sg-0123456789abcdef0 \
  --subnet-id subnet-0123456789abcdef0 \
  --user-data file://apache-setup.sh \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=gridstart-multicloud-aws}]'

# Obter IP Público da nova instância
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=gridstart-multicloud-aws" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text
````
* Execução na MagaluCloud
````bash
# Lançar nova VM com User Data
mgc virtual-machine instances create \
  --name "gridstart-multicloud-mgc" \
  --machine-type "BV2-4-20" \
  --image-id <IMAGE_ID_UBUNTU> \
  --ssh-key-name "gridstart-mgc-key" \
  --security-group-ids <SG_MGC_ID> \
  --associate-public-ip true \
  --user-data="$(cat apache-setup.sh)"

# Obter IP Público e Status
mgc virtual-machine instances list
````

------------------------------
## ATIVIDADE PRÁTICA — S06T04V12: Zerando o marcador (Descomissionamento)
* Parte 1 — Limpeza na AWS
````bash
# 1. Obter IDs e Terminar as 2 Instâncias AWS (V04 e V11)
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,Tags[?Key=='Name'].Value|[0]]" --output table
aws ec2 terminate-instances --instance-ids i-0a1b2c3d4e5f6g7h8 i-0f8e7d6c5b4a31234

# 2. Confirmar desvinculação e deletar Volume EBS do V09
aws ec2 describe-volumes --filters "Name=status,Values=available"
aws ec2 delete-volume --volume-id vol-0123456789abcdef0

# 3. Esvaziar e Excluir Bucket S3 do V10
aws s3 rm s3://gridstart-silvioluiz-s3 --recursive
aws s3api delete-bucket --bucket gridstart-silvioluiz-s3 --region us-east-1

# 4. Verificar e liberar IPs Elásticos órfãos
aws ec2 describe-addresses
# Se houver IP não associado: aws ec2 release-address --allocation-id eipalloc-xxxxxx
````
* Parte 2 — Limpeza na MagaluCloud
````bash
# 1. Listar e Excluir as 2 VMs MGC (V06 e V11)
mgc virtual-machine instances list
mgc virtual-machine instances delete --id <VM_01_ID>
mgc virtual-machine instances delete --id <VM_02_ID>

# 2. Confirmar status available e Deletar Volume Block Storage do V09
mgc block-storage volumes list
mgc block-storage volumes delete --id <VOLUME_ID>

# 3. Esvaziar e Excluir Bucket no Object Storage MGC do V10
mgc object-storage objects delete --bucket "gridstart-silvioluiz-mgc" --object "relatorio.pdf"
mgc object-storage buckets delete --bucket "gridstart-silvioluiz-mgc"

# 4. Confirmar que não restam IPs reservados órfãos
mgc network public-ips list
````
* Parte 3 — Validação do Balanço Final
- [x] AWS EC2 / EBS: Nenhuma instância em execução; todos os volumes EBS desalocados.

- [x] AWS S3: Bucket removido do namespace global S3.

- [x] MGC Compute & Storage: Listagens de instâncias, volumes de bloco e buckets retornam vazias.

- [x] AWS Billing / MGC Financial: Confirmado que o consumo residual foi zerado, evitando cobranças surpresa e eliminando a existência de "Recursos Órfãos".
