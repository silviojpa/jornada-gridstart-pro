# Conversor de Distância 
![Status](https://img.shields.io/badge/status-active-success) ![License](https://img.shields.io/badge/license-MIT-blue)

##  Sobre o Projeto
Uma aplicação web desenvolvida em Python (Flask) estruturada para demonstrar conceitos práticos de conteinerização, arquitetura Cloud-Native e orquestração de microsserviços de alta disponibilidade em ambientes de nuvem.

##  Pré-requisitos
Antes de começar, você precisará ter instalado em sua máquina:
* **Docker** e **Docker Compose**
* **Kubernetes (kubectl)** instalado no ambiente WSL2 (Ubuntu)
* **AWS CLI** configurado (caso deseje realizar o deploy na nuvem)

##  Instalação
Siga os passos abaixo para configurar o ambiente local de desenvolvimento:

1. Clone o repositório para sua máquina local.
2. Copie o arquivo de exemplo de variáveis de ambiente para o arquivo definitivo:
   ```bash
   cp .env.example .env
