#!/bin/bash

# Nome do processo do Tomcat
TOMCAT_PROCESS="tomcat"

# Função para instalar o Tomcat
instalar_tomcat() {
    echo "Instalando o Tomcat..."

    # Baixar e extrair a versão mais recente do Tomcat
    cd /opt
    sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz
    sudo tar -xvzf apache-tomcat-9.0.58.tar.gz
    sudo mv apache-tomcat-9.0.58 tomcat

    # Definir permissões e iniciar o Tomcat
    sudo chown -R $USER:$USER /opt/tomcat
    cd /opt/tomcat/bin
    ./startup.sh

    echo "Tomcat instalado e iniciado com sucesso!"
}

# Verifica se o Tomcat está rodando
if pgrep -f "$TOMCAT_PROCESS" > /dev/null; then
    echo "A instância do Tomcat está rodando."
else
    echo "A instância do Tomcat NÃO está rodando."
    # Caso não esteja rodando, instala o Tomcat
    instalar_tomcat
fi

