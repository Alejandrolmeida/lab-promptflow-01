#!/bin/bash

# Variables
RESOURCE_GROUP=""
NAME=""
ACR_NAME=""
SUBSCRIPTION=""

# Habilitar la identidad administrada en la Web App
echo "Habilitando la identidad administrada para la webapp...$NAME"
az webapp identity assign --name $NAME --resource-group $RESOURCE_GROUP

# Obtener el ID de la identidad administrada
IDENTITY_PRINCIPAL_ID=$(az webapp identity show --name $NAME --resource-group $RESOURCE_GROUP --query principalId --output tsv)

# Asignar permisos de AcrPull a la identidad administrada en el ACR
echo "Asignando permisos de AcrPull a la identidad administrada en el ACR...$ACR_NAME"
az role assignment create --assignee $IDENTITY_PRINCIPAL_ID --role AcrPull --scope /subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ContainerRegistry/registries/$ACR_NAME

# Habilitar el registro de diagnóstico
echo "Habilitando el registro de diagnóstico para la webapp...$NAME"
az webapp log config --name $NAME --resource-group $RESOURCE_GROUP --docker-container-logging filesystem

# Reiniciar la webapp
echo "Reiniciando la webapp...$NAME"
az webapp restart --name $NAME --resource-group $RESOURCE_GROUP

echo "Please go to https://portal.azure.com/ to config environment variables and restart the app: $NAME at (Settings>Configuration) or (Settings>Environment variables)"
echo "Reach deployment logs at (Deployment>Deployment Central) and app logs at (Monitoring>Log stream)"
echo "Reach advanced deployment tools at https://$NAME.scm.azurewebsites.net/"
echo "Reach more details about app service at https://learn.microsoft.com/en-us/azure/app-service/"