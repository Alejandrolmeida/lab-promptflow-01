#!/bin/bash

# Endpoint de la API
API_ENDPOINT="https://mycopilot.azurewebsites.net/score"

# JSON a enviar
JSON_PAYLOAD=$(cat <<EOF
{
    "chat_history": [],
    "question": "¿Cuantos App Services tengo?",
}
EOF
)

# Hacer la llamada POST
response=$(curl -s -X POST -H "Content-Type: application/json" -d "$JSON_PAYLOAD" "$API_ENDPOINT")

# Imprimir la respuesta
echo "Response from API: $response"