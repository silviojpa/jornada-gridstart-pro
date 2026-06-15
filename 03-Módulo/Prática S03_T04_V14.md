## Pergunta 1: Quantas colunas aparecem na saída com -v ? O que significa a coluna "pkts"?
* **Resposta** - A saída com -v mostra 9 colunas: pkts, bytes, target, prot, opt, in, out, source, destination.
A coluna pkts é um contador de quantos pacotes foram processados.
<img width="1089" height="87" alt="image" src="https://github.com/user-attachments/assets/9a48ddf6-38b7-44f3-b328-68fb266a0932" />

## Pergunta 2: O que aconteceu? A conexão travou (timeout) ou recebeu um erro imediato?
* **Resposta** - A conexão travou sem resposta, foi necessário fecha o ultimo comando no terminal.

## Pergunta 3: Em qual posição ficou a regra de ACCEPT? Em qual posição está a regra de DROP?
* **Resposta** - DROP ficou na posição 1 e ACCEPT ficou na posição 2.

## Pergunta 4: Por que a regra de ACCEPT não funcionou mesmo sendo mais específica?
* **Resposta** - Porque o iptables processa as regras de cima para baixo, cas DROP esteja na primeira posição ele já joga fora e não passa para próxima regra.

## Pergunta 5: Agora tente se conectar ao 127.0.0.1:8080 . O resultado mudou? Por quê?
* **Resposta** - Sim, a conexão foi estabelecida, encontrou a primeira regra e aí, passou sem precisar usar drop.

## Pergunta 6: A política padrão mudou após o Flush? O que aconteceria se a política fosse DROP antes do
Flush?
* **Resposta** - Não. O comando -F remove todas as regras, mas não altera a política padrão ( -P ). A política padrão persiste entre Flushes.
