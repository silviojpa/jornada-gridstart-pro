# Parte 1 — /etc/hosts
<img width="1437" height="544" alt="image" src="https://github.com/user-attachments/assets/60eaef8f-b208-4c5d-b2c3-1896cf4cb8d4" />
* **Resposta** -> Com a retirada do dns teste.gridstart.local o ping não consegue buscar no host o ip interno da máquina.

# Parte 2 — dig básico
1. Qual o IP retornado?
- 172.217.172.14
2. Qual o TTL?
- 300
3. Qual servidor DNS respondeu (campo SERVER)?
-  SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
<img width="712" height="529" alt="image" src="https://github.com/user-attachments/assets/ab3ed532-5b2d-43fd-affb-23a36ca01d4d" />

- Output do dig google.com com IP, TTL e servidor identificados
<img width="712" height="521" alt="image" src="https://github.com/user-attachments/assets/7fbfb55e-1bde-4536-9281-311d6b08286b" />

- Registros MX do Gmail com prioridades anotadas e análise
<img width="903" height="612" alt="image" src="https://github.com/user-attachments/assets/1dfe9472-5577-4d95-80ee-a2b3dbf54b68" />
* **Resposta** -> Analisa em heraquia os setores de resposta em prioridades. 

- Registro SPF do Google identificado e explicado
- Encontre o registro SPF. Qual o conteúdo completo dele? O que include: significa nesse contexto?
* **Resposta** -> O mecanismo include: serve para delegar autorização para terceiros. Ele diz aos servidores de e-mail que estão recebendo a mensagem:
<img width="1485" height="367" alt="image" src="https://github.com/user-attachments/assets/99221986-3f8d-45cc-8e24-cd0a1d0b664e" />

# Parte 3 — Comparando servidores DNS
Os IPs são os mesmos? São do mesmo bloco de endereços (/24)? O que isso diz sobre como o Google
distribui seu tráfego?
* **Resposta** -> Não, os IPs não são os mesmos. Cada consulta retornou um endereço IP diferente na ANSWER SECTION:
- O primeiro comando retornou: 172.217.172.14
- O segundo comando (via DNS 8.8.8.8) retornou: 142.251.132.238
- O terceiro comando (via DNS 1.1.1.1) retornou: 142.250.219.46
* **Resposta** -> Não, eles não pertencem ao mesmo bloco /24, os três primeiros octetos teriam que ser exatamente iguais.
* **Resposta** -> Isso demonstra que o Google utiliza uma estratégia de balanceamento de carga global baseada em DNS.

# Parte 4 — dig +trace
- Não consegui retorno no trace conforme o print abaixo.
<img width="705" height="180" alt="image" src="https://github.com/user-attachments/assets/a56bf014-c292-452d-ba42-65ace08970d2" />
- Usando a IA, cheguei no comando dig +trace @1.1.1.1 google.com e me trouxe
1. Quantos servidores intermediários a consulta passou antes de chegar na resposta final?
* **Resposta** -> A consulta passou por 2 blocos de servidores intermediários (as etapas Root e TLD) antes de bater no servidor final que tinha a resposta.
2. Quais foram os tipos de servidores (root, TLD, authoritative)?
* **Resposta** -> 1º Tipo: Root Servers (Servidores Raiz) / 2º Tipo: TLD Servers (Top-Level Domain / 3º Tipo: Authoritative Name Servers (Servidores Autoritativos)
3. Em qual ponto a resposta final foi retornada?
* **Resposta** -> A resposta final (o registro do tipo A que aponta para o IP do site) foi retornada na última linha do rastreamento, vinda diretamente do servidor autoritativo do Google.
# Parte 5 — Interpretando erros
