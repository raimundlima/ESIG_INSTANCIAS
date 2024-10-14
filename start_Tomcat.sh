#!/bin/bash

# Nome do processo do Tomcat
TOMCAT_PROCESS="tomcat"

# Função para instalar o Tomcat (caso ainda não tenha sido instalado)
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

# Função para iniciar o Tomcat
iniciar_tomcat() {
    echo "Iniciando o Tomcat..."
    cd /opt/tomcat/bin
    ./startup.sh
    echo "Tomcat iniciado com sucesso!"
}

# Verifica se o Tomcat está rodando
if pgrep -f "$TOMCAT_PROCESS" > /dev/null; then
    echo "A instância do Tomcat está rodando."

    # Verifica o tempo de atividade do Tomcat (em segundos)
    TOMCAT_PID=$(pgrep -f "$TOMCAT_PROCESS" | head -n 1)  # Caso tenha múltiplos processos, pega o primeiro
    START_TIME=$(ps -p "$TOMCAT_PID" -o etimes=)

    if [ -z "$START_TIME" ]; then
        echo "Não foi possível obter o tempo de atividade."
    elif [ "$START_TIME" -ge 60 ]; then
        echo "Tempo de atividade do Tomcat: $((START_TIME / 60)) minutos."
    else
        echo "Tempo de atividade do Tomcat: $START_TIME segundos."
    fi
else
    echo "A instância do Tomcat NÃO está rodando."

    # Caso o Tomcat não esteja rodando, verifica se está instalado e inicia
    if [ -d "/opt/tomcat" ]; then
        echo "O Tomcat está instalado, mas não está rodando. Iniciando..."
        iniciar_tomcat
    else
        # Caso o Tomcat não esteja instalado, chama a função para instalar
        instalar_tomcat
    fi
fi

