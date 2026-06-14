# Questão 1 — Conceito de porta lógica

1. Um servidor Linux está rodando simultaneamente: um servidor web (Nginx), um banco de dados
PostgreSQL e um servidor SSH.
Quando um pacote TCP chega ao servidor, o que determina para qual desses processos o kernel vai
entregar o pacote?
A) O endereço IP de origem do pacote
B) O número de porta de destino no cabeçalho do pacote
C) O protocolo de rede (IPv4 ou IPv6)
D) O tamanho do pacote

---
# Questão 2 — Faixas de portas

Você está escrevendo um script de inicialização de um serviço customizado em um servidor Linux.
Você quer que o serviço escute na porta 80 (HTTP) sem precisar rodar como root.
Qual afirmação descreve corretamente esse cenário?

A) É possível — portas abaixo de 1024 são livres para qualquer processo
B) Não é possível diretamente — portas 0 a 1023 requerem privilégio de root no Linux
C) É possível desde que o processo use UDP em vez de TCP
D) Não é possível em nenhuma circunstância — essas portas são desabilitadas pelo kernel

# Questão 3 — Three-way handshake

Coloque os três passos do three-way handshake TCP na ordem correta:
1. ___ O servidor responde com SYN e ACK simultâneos
2. ___ O cliente confirma com ACK — conexão estabelecida
3. ___ O cliente envia um segmento com a flag SYN
(Escreva os números 1, 2 ou 3 nos espaços)

# Questão 4 — TCP vs. UDP

Para cada cenário abaixo, identifique qual protocolo de transporte é mais adequado e justifique em
uma frase:

Cenário TCP ou UDP? Justificativa

Transferência de um arquivo de 2 GB via FTP
Transmissão ao vivo de uma partida de futebol em streaming
Query DNS para resolver um domínio
Conexão SSH a um servidor de produção
Jogo online multiplayer em tempo real

# Questão 5 — Well-known ports em firewall

Você está configurando as regras de security group de uma nova VM em cloud que vai hospedar uma
aplicação web com acesso SSH restrito. Analise as regras abaixo e identifique qual delas representa um
risco de segurança:
Regra A:
Protocolo: TCP | Porta: 443 | Origem: 0.0.0.0/0 | Ação: Permitir
````
Regra B:
Protocolo: TCP | Porta: 22 | Origem: 0.0.0.0/0 | Ação: Permitir
Regra C:
Protocolo: TCP | Porta: 22 | Origem: 177.92.0.0/16 | Ação: Permitir
Regra D:
Protocolo: TCP | Porta: 80 | Origem: 0.0.0.0/0 | Ação: Permitir
````
a) Qual regra representa o maior risco de segurança? Por quê?
b) Qual seria a forma correta de configurar o acesso SSH para um ambiente de produção?

# Questão 6 — Cenário de debug

Você tem uma aplicação rodando atrás de um load balancer. O load balancer está configurado para:
Escutar na porta 443 (HTTPS, com TLS termination)
Encaminhar tráfego para os backends na porta 8080 (HTTP)
Um colega reporta que a aplicação não está respondendo. Você verifica os logs do load balancer e ele
está recebendo requisições normalmente. O problema está nos backends.
Liste em ordem as primeiras verificações que você faria relacionadas a portas e processos no servidor
backend:
1.
2.
3.
