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

# Parte 4 — dig +trace

# Parte 5 — Interpretando erros
