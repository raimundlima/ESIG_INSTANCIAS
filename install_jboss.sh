#!/bin/bash

# Nome do processo do JBoss
JBOSS_PROCESS="java"

# Função para instalar o JBoss
instalar_jboss() {
    echo "Instalando o JBoss..."

    # Baixar e extrair a versão mais recente do JBoss (Exemplo com WildFly, versão mais recente do JBoss)
    cd /opt
    sudo wget https://github.com/wildfly/wildfly/releases/download/26.1.1.Final/wildfly-26.1.1.Final.tar.gz
    sudo tar -xvzf wildfly-26.1.1.Final.tar.gz
    sudo mv wildfly-26.1.1.Final jboss

    # Definir permissões e iniciar o JBoss
    sudo chown -R $USER:$USER /opt/jboss
    cd /opt/jboss/bin
    ./standalone.sh &

    echo "JBoss instalado e iniciado com sucesso!"
}

# Verifica se o JBoss está rodando
if pgrep -f "$JBOSS_PROCESS" > /dev/null; then
    echo "A instância do JBoss está rodando."
else
    echo "A instância do JBoss NÃO está rodando."
    # Caso não esteja rodando, instala o JBoss
    instalar_jboss
fi

