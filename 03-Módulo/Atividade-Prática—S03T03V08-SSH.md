# Exemplo com provilégio 777 no arquivo .pemm
<img width="1031" height="230" alt="Exemplo chmod 777  pem" src="https://github.com/user-attachments/assets/daa41bd3-e26c-4e0e-8fa1-91a85cd62f5d" />

---
# Exemplo com provilégio 600 no arquivo .pemm
<img width="1041" height="514" alt="Exemplo chmod 600  pem" src="https://github.com/user-attachments/assets/4628e9cd-16b7-46c9-b8f2-b74a624080c0" />

---

# Parte 4 — Desafio extra (opcional)
- Usando o checklist que vimos no vídeo, analise o cenário abaixo e responda no seu caderno/arquivo de
notas:
- Um servidor web rodando com o usuário www-data precisa ler o arquivo
````/etc/myapp/config.env .````
- O arquivo atualmente tem dono root , grupo root , e permissão 600 .
- O comando cat /etc/myapp/config.env dentro do processo da aplicação retorna
* **Permission denied .**
1. Qual dos 4 passos do checklist identifica o problema?
- Qual o acesso mínimo necessário.
2. Qual das três opções de correção você usaria — chown , chmod , ou usermod -aG ?
- privilégio chmod 604  
3. Qual seria a permissão octal final do arquivo após a sua correção?
- rw----r-- /etc/myapp/config.env
