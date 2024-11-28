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

# Función para leer la configuración del Deployment Center
function print_current_image_version {
    local app_service_name="$1"
    local resource_group="$2"

    # Obtener la configuración actual del contenedor
    local current_config=$(az webapp config container show --name "$app_service_name" --resource-group "$resource_group" -o json)

    # Extraer la URL del registro y la imagen
    local registry_url=$(echo "$current_config" | jq -r '.[] | select(.name == "DOCKER_REGISTRY_SERVER_URL") | .value')
    local image_name=$(echo "$current_config" | jq -r '.[] | select(.name == "DOCKER_CUSTOM_IMAGE_NAME") | .value')

    echo "App Service: $app_service_name"
    echo "Resource Group: $resource_group"
    echo "Current registry URL: $registry_url"
    echo "Current image: $image_name"

}

function main {
    # Imprimir la versión actual de la imagen y su etiqueta
    print_current_image_version "$APP_SERVICE_NAME" "$RESOURCE_GROUP"

}

main "$@"