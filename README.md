# Script de Instalação e Monitoramento do JBoss e Tomcat

Este script foi criado para gerenciar os serviços Apache Tomcat e JBoss (WildFly) em sistemas Linux. Ele verifica se as instâncias estão rodando, e, caso contrário, instala e inicia o serviço correspondente.

## Funcionalidades

1. **Verificar se o JBoss (WildFly) está rodando:**
   - O script verifica se o processo do JBoss está em execução.
   - Se não estiver rodando, ele realizará a instalação e o início do JBoss.

2. **Verificar se o Tomcat está rodando:**
   - O script verifica se o processo do Tomcat está em execução.
   - Se não estiver rodando, ele realizará a instalação e o início do Tomcat.

3. **Instalação do JBoss (WildFly) e Tomcat:**
   - Caso qualquer um dos serviços não esteja instalado, o script realiza o download, extração e configuração do JBoss ou Tomcat, conforme o caso.

## Requisitos

- Sistema operacional baseado em Linux.
- Permissões de superusuário (sudo) para instalação e execução de comandos.
- Acesso à internet para baixar o JBoss e Tomcat.