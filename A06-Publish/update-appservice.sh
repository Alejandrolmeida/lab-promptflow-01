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

# Función para actualizar la configuración del Deployment Center
function update_deployment_center {
    local app_service_name="$1"
    local resource_group="$2"
    local acr_name="$3"
    local image_name="$4"
    local image_version="$5"

    # Actualizar la configuración del Deployment Center
    az webapp config container set \
        --name "$app_service_name" \
        --resource-group "$resource_group" \
        --container-image-name "$acr_name.azurecr.io/$image_name:$image_version" \
        --container-registry-url "https://$acr_name.azurecr.io"
}

function main {
    local image_name="${1:-$DEFAULT_DOCKER_IMAGE_NAME}"
    local image_version="${2:-$DEFAULT_DOCKER_IMAGE_VERSION}"

    # Llamar a la función para actualizar la configuración del Deployment Center
    update_deployment_center "$APP_SERVICE_NAME" "$RESOURCE_GROUP" "$ACR_NAME" "$image_name" "$image_version"

    echo "Configuración del Deployment Center actualizada correctamente."
}

main "$@"