#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GLOBAL_ENV="$ROOT_DIR/.env"
STACK_DIR="$ROOT_DIR/stack"


# ==============================
# Feedback
# ==============================

info() {
    echo "[INFO] $1"
}

success() {
    echo "[OK] $1"
}

warning() {
    echo "[WARNING] $1"
}

error() {
    echo "[ERROR] $1" >&2
}


# ==============================
# Validações
# ==============================

validate_global_env() {
    if [[ ! -f "$GLOBAL_ENV" ]]; then
        error "Global .env not found: $GLOBAL_ENV"
        exit 1
    fi
}

validate_stack_dir() {
    if [[ ! -d "$STACK_DIR" ]]; then
        error "Stack directory not found: $STACK_DIR"
        exit 1
    fi
}


# ==============================
# Environment
# ==============================

get_env_value() {
    local key="$1"

    grep -E "^${key}=" "$GLOBAL_ENV" \
        | head -n 1 \
        | cut -d '=' -f2-
}

configure_service_env() {
    local service_dir="$1"

    local service_name
    local example_env
    local service_env

    service_name="$(basename "$service_dir")"
    example_env="$service_dir/.env.example"
    service_env="$service_dir/.env"

    if [[ ! -f "$example_env" ]]; then
        return
    fi

    info "Configuring $service_name..."

    > "$service_env"

    while IFS= read -r line || [[ -n "$line" ]]; do

        # Ignora comentários e linhas vazias
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

        # Extrai apenas o nome da variável
        local key="${line%%=*}"

        # Remove espaços
        key="$(echo "$key" | xargs)"

        # Obtém valor do .env global
        local value
        value="$(get_env_value "$key")"

        if [[ -z "$value" ]]; then
            warning "$key not found in global .env"
            continue
        fi

        echo "${key}=${value}" >> "$service_env"

    done < "$example_env"

    success "Created $service_env"
}

configure_services() {
    for service_dir in "$STACK_DIR"/*; do

        [[ -d "$service_dir" ]] || continue

        configure_service_env "$service_dir"

    done
}


# ==============================
# Setup
# ==============================

setup_env() {
    info "Starting environment setup..."

    validate_global_env
    validate_stack_dir
    configure_services

    success "Environment setup completed."
}