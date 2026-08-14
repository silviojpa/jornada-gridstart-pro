# Caderno de Atividades Práticas — Módulo 6 (Cloud Computing - Tópico 4)
**Aluno:** Silvio Luiz da Silva Ezequiel  
**Data:** 14 de agosto de 2026  

---

## 1. ATIVIDADE PRÁTICA — S06T04V10: Do arquivo privado à URL pública

### Parte 1 — AWS (Amazon S3)

#### 1. Criação do Bucket e Upload do Arquivo Público
```bash
# Criar bucket com sufixo único
aws s3api create-bucket \
  --bucket gridstart-silvioluiz-s3 \
  --region us-east-1

# Upload do arquivo público
aws s3 cp relatorio.pdf s3://gridstart-silvioluiz-s3/relatorio.pdf
````
## 2. Desativação do Bloqueio de Acesso Público
```bash
aws s3api put-public-access-block \
  --bucket gridstart-silvioluiz-s3 \
  --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
````

## 3. Configuração da Bucket Policy (policy.json)
Criação do arquivo policy.json liberando leitura pública apenas para o objeto:

````json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::gridstart-silvioluiz-s3/*"
    }
  ]
}
````
### Aplicação da política:
````bash
aws s3api put-bucket-policy \
  --bucket gridstart-silvioluiz-s3 \
  --policy file://policy.json
````
* URL Pública de Acesso Direct: https://gridstart-silvioluiz-s3.s3.amazonaws.com/relatorio.pdf

## 4. Upload de Arquivo Privado e Geração de Presigned URL

````bash
# Upload do arquivo estritamente privado
aws s3 cp contrato-privado.pdf s3://gridstart-silvioluiz-s3/contrato-privado.pdf

# Geração de Presigned URL válida por 3600 segundos (1 hora)
aws s3 presign s3://gridstart-silvioluiz-s3/contrato-privado.pdf --expires-in 3600
````

### Parte 2 — MagaluCloud (Object Storage)

````bash
# 1. Criar o Bucket no Object Storage MGC
mgc object-storage buckets create --name "gridstart-silvioluiz-mgc"

# 2. Upload do arquivo
mgc object-storage objects upload \
  --bucket "gridstart-silvioluiz-mgc" \
  --file "relatorio.pdf" \
  --dst "relatorio.pdf"

# 3. Liberar ACL pública no Bucket e no Objeto
mgc object-storage buckets acl set --bucket "gridstart-silvioluiz-mgc" --public-read
mgc object-storage objects acl set --bucket "gridstart-silvioluiz-mgc" --object "relatorio.pdf" --public-read
````
* URL Pública MGC: https://br-se1.magaluobjects.com/gridstart-silvioluiz-mgc/relatorio.pdf
