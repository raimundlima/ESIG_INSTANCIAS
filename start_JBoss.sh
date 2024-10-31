#!/bin/bash

# Nome do processo do JBoss
JBOSS_PROCESS="jboss"

# Caminho para o JBoss
JBOSS_HOME="/opt/jboss"

# Função para verificar o tempo de atividade de uma instância
verificar_tempo_atividade() {
    local PROCESS_NAME=$1
    local PROCESS_PID=$(pgrep -f "$PROCESS_NAME" | head -n 1)  # Pega apenas o primeiro PID

    if [ -z "$PROCESS_PID" ]; then
        echo "A instância do $PROCESS_NAME NÃO está rodando."
        return 1
    else
        echo "A instância do $PROCESS_NAME está rodando."
        
        # Verifica o tempo de atividade
        local START_TIME=$(ps -p "$PROCESS_PID" -o etimes= | xargs)

        if [ -z "$START_TIME" ]; then
            echo "Não foi possível obter o tempo de atividade para PID $PROCESS_PID."
            return 1
        elif ! [[ "$START_TIME" =~ ^[0-9]+$ ]]; then
            echo "O tempo de atividade para PID $PROCESS_PID não é um número válido: '$START_TIME'"
            return 1
        else
            local MINUTES=$((START_TIME / 60))
            local SECONDS=$((START_TIME % 60))
            echo "Tempo de atividade do $PROCESS_NAME: $MINUTES minutos e $SECONDS segundos."
        fi
        return 0
    fi
}

# Função para iniciar o JBoss
iniciar_jboss() {
    echo "Iniciando o JBoss..."
    mkdir -p $JBOSS_HOME/logs
    $JBOSS_HOME/bin/standalone.sh > $JBOSS_HOME/logs/standalone.log 2>&1 &
}

# Verificar status e tempo de atividade do JBoss
if ! verificar_tempo_atividade "$JBOSS_PROCESS"; then
    echo "A instância do JBoss está parada. Iniciando..."
    iniciar_jboss

    # Aguarda até que o JBoss esteja rodando
    for i in {1..30}; do
        if pgrep -f "$JBOSS_PROCESS" > /dev/null; then
            echo "JBoss iniciado com sucesso!"
            exit 0
        fi
        echo "Aguardando o JBoss iniciar... ($i/30)"
        sleep 2
    done

    echo "Falha ao iniciar o JBoss. Verifique os logs para mais detalhes."
else
    echo "O JBoss já está rodando e está sendo monitorado."
fi

