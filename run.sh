#!/bin/bash

#!/bin/bash

# --- AUTO-COMPLETE LOGIC ---
_run_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    # First level commands (./run.sh <command>)
    if [ "$COMP_CWORD" -eq 1 ]; then
        local commands="up down setup restart clean build upsql finance-api"
        COMPREPLY=( $(compgen -W "$commands" -- "$cur") )

    # Second level commands (./run.sh <service> <command>)
    elif [ "$COMP_CWORD" -eq 2 ]; then
        case "$prev" in
            "finance-api")
                local service_commands="init stop"
                COMPREPLY=( $(compgen -W "$service_commands" -- "$cur") )
                ;;
            *)
                COMPREPLY=()
                ;;
        esac
    fi
}

complete -F _run_completions run.sh
complete -F _run_completions ./run.sh
# ----------------------------

ARG1=$1
ARG2=$2

case "$ARG1" in
    "up")
        docker compose up
        ;;
    "build")
        docker compose up --build
        ;;
    "upsql")
        docker compose up -d postgres
        ;;
    "down")
        docker compose down
        ;;
    "clean")
        docker compose down -v
        ;;
    "setup")
        cp .env.example .env
        echo "Environment file created successfully!"
        ;;
    "restart")
        docker compose down
        docker compose up --build
        echo "System restarted!"
        ;;
    "finance-api")
        # Sub-commands specifically for the finance-api service
        case "$ARG2" in
           "init")
               echo "Starting Finance API in development mode..."
               cd stack/finance-api && ./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
               ;;
           "stop")
               echo "Stopping Finance API on port 8080..."
               # Finds the Process ID (PID) listening on port 8080 and kills it gracefully
               PID=$(lsof -t -i:8080)
               if [ -z "$PID" ]; then
                   echo "Finance API is not currently running."
               else
                   kill -15 $PID
                   echo "Finance API stopped successfully."
               fi
               ;;
           *)
               echo "Unknown command for finance-api! Available commands: init, stop"
               ;;
        esac
        ;;
    *)
        echo "Unknown command! Available commands: up, build, upsql, down, clean, setup, restart, finance-api"
        ;;
esac