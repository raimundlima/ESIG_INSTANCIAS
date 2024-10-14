#!/bin/bash

# Nome do processo do JBoss
JBOSS_PROCESS="jboss"

# Função para verificar o tempo de atividade de uma instância
verificar_tempo_atividade() {
    local PROCESS_NAME=$1
    local PROCESS_PID=$(pgrep -f "$PROCESS_NAME")

    if [ -z "$PROCESS_PID" ]; then
        echo "A instância do $PROCESS_NAME NÃO está rodando."
        return 1
    else
        echo "A instância do $PROCESS_NAME está rodando."
        
        # Verifica o tempo de atividade
        local START_TIME=$(ps -p "$PROCESS_PID" -o etimes=)

        if [ "$START_TIME" -ge 60 ]; then
            local MINUTES=$((START_TIME / 60))
            local SECONDS=$((START_TIME % 60))
            echo "Tempo de atividade do $PROCESS_NAME: $MINUTES minutos e $SECONDS segundos."
        else
            echo "Tempo de atividade do $PROCESS_NAME: $START_TIME segundos."
        fi

        return 0
    fi
}

# Função para iniciar o JBoss
iniciar_jboss() {
    echo "Iniciando o JBoss..."
    # Aqui deve ir o comando para iniciar o JBoss
    # Exemplo: /path/to/jboss/bin/standalone.sh
}

# Verificar status e tempo de atividade do JBoss
if ! verificar_tempo_atividade "$JBOSS_PROCESS"; then
    echo "A instância do JBoss está parada há mais de 1 minuto. Iniciando..."
    iniciar_jboss

    # Aguarda até que o JBoss esteja rodando
    while ! pgrep -f "$JBOSS_PROCESS" > /dev/null; do
        echo "Aguardando o JBoss iniciar..."
        sleep 2
    done

    echo "JBoss iniciado com sucesso!"
else
    echo "O JBoss já está rodando e está sendo monitorado."
fi

