#!/bin/bash

# --- AUTO-COMPLETE LOGIC ---
_run_completions() {
    local commands="up down setup restart clean"
    
    local cur="${COMP_WORDS[COMP_CWORD]}"
    
    COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
}

complete -F _run_completions run.sh
complete -F _run_completions ./run.sh
# ----------------------------

ARG=$1

case "$ARG" in
    "up")
        docker compose up
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
        docker compose up
        echo "System restated!"
    ;;
    *)
        echo "Unknown command!"
        ;;
esac