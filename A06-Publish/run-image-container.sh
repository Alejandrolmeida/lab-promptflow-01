#!/bin/bash

set -e

scriptDir=$(dirname "$(realpath "$0")")

# Load environment variables from .env file
if [ -f "$scriptDir/../.env" ]; then
    source "$scriptDir/../.env"
fi

function login {
    az login --use-device-code -t $TENANT_ID
    az account set --subscription $SUBSCRIPTION_ID
}

function check_login {
    if [ -z "$(az account show)" ]; then
        login
    fi
}

function run_image_container {
    local image_name="$1"
    local env_file="$2"

    # Construir el comando docker run dinámicamente
    local docker_run_cmd="docker run -p 8080:8080"

    # Agregar el archivo .env si existe
    if [ -f "$env_file" ]; then
        docker_run_cmd+=" --env-file $env_file"
    fi

    # Agregar el nombre de la imagen
    docker_run_cmd+=" \"$image_name\""

    # Ejecutar el comando
    eval $docker_run_cmd
}

function print_help {
    echo "Uso: $0 <nombre_imagen_docker>"
    echo "Si no se proporciona <nombre_imagen_docker>, se usará el valor predeterminado: $DEFAULT_DOCKER_IMAGE_NAME."
}

function main {
    local image_name="${1:-$DEFAULT_DOCKER_IMAGE_NAME}"
    local env_file="$scriptDir/docker/.env"

    if [ -z "$image_name" ]; then
        echo "Error: No se ha proporcionado un nombre de imagen de Docker y la variable DEFAULT_DOCKER_IMAGE_NAME no está definida."
        print_help
        exit 1
    fi

    check_login    
    run_image_container "$image_name" "$env_file"    
}

main "$@"