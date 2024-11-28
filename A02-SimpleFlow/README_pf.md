# Flujo de chat (Chat Flow)

El flujo de chat está diseñado para el desarrollo de aplicaciones conversacionales, basado en las capacidades de los flujos estándar y ofreciendo soporte mejorado para entradas/salidas de chat y gestión del historial de chat. Con el flujo de chat, puedes crear fácilmente un chatbot que maneje entradas y salidas de chat.

## Crear una conexión para usar con una herramienta LLM

Puedes seguir estos pasos para crear una conexión requerida por una herramienta LLM.

Actualmente, hay dos tipos de conexiones compatibles con herramientas LLM: "AzureOpenAI" y "OpenAI". Si deseas usar el tipo de conexión "AzureOpenAI", primero debes crear un servicio de Azure OpenAI. Consulta [Azure OpenAI Service](https://azure.microsoft.com/en-us/products/cognitive-services/openai-service/) para más detalles. Si deseas usar el tipo de conexión "OpenAI", primero debes crear una cuenta en OpenAI. Consulta [OpenAI](https://platform.openai.com/) para más detalles.

```bash
# Sobrescribe claves con --set para evitar cambios en el archivo YAML
# Crear una conexión de OpenAI
pf connection create --file openai.yaml --set api_key=<tu_clave_api> --name open_ai_connection

# Crear una conexión de Azure OpenAI
# pf connection create --file azure_openai.yaml --set api_key=<tu_clave_api> api_base=<tu_api_base> --name open_ai_connection
```

Nota: En [flow.dag.yaml](flow.dag.yaml) estamos utilizando una conexión llamada `open_ai_connection`.
```bash
# Mostrar conexiones registradas
pf connection show --name open_ai_connection
```

Consulta la [documentación de conexiones](https://promptflow.azurewebsites.net/community/local/manage-connections.html) y este [ejemplo](https://github.com/microsoft/promptflow/tree/main/examples/connections) para más detalles.

## Desarrollar un flujo de chat

Los elementos más importantes que diferencian un flujo de chat de un flujo estándar son **Entrada de chat**, **Historial de chat** y **Salida de chat**.

- **Entrada de chat**: Se refiere a los mensajes o consultas enviados por los usuarios al chatbot. Manejar eficazmente la entrada de chat es crucial para una conversación exitosa, ya que implica comprender las intenciones del usuario, extraer información relevante y generar respuestas adecuadas.

- **Historial de chat**: Es el registro de todas las interacciones entre el usuario y el chatbot, incluyendo tanto las entradas del usuario como las salidas generadas por la IA. Mantener un historial de chat es esencial para rastrear el contexto de la conversación y garantizar que la IA pueda generar respuestas contextualmente relevantes. El historial de chat es un tipo especial de entrada de flujo de chat que almacena los mensajes de chat en un formato estructurado.

- **Salida de chat**: Se refiere a los mensajes generados por la IA que se envían al usuario en respuesta a sus entradas. Generar salidas de chat contextualmente apropiadas y atractivas es vital para una experiencia positiva del usuario.

Un flujo de chat puede tener múltiples entradas, pero el historial de chat y la entrada de chat son entradas requeridas.

## Interactuar con el flujo de chat

La CLI de PromptFlow proporciona una manera de iniciar una sesión de chat interactiva para el flujo de chat. El cliente puede usar el siguiente comando para iniciar una sesión de chat interactiva:

```
pf flow test --flow <carpeta_del_flujo> --interactive
```

Después de ejecutar este comando, el cliente puede interactuar con el flujo de chat en la terminal. El cliente puede presionar **Enter** para enviar el mensaje al flujo de chat y salir con **Ctrl+C**.
La CLI de PromptFlow distinguirá la salida de diferentes roles por colores: <span style="color:Green">Entrada del usuario</span>, <span style="color:Gold">Salida del bot</span>, <span style="color:Blue">Salida del script del flujo</span>, <span style="color:Cyan">Salida del nodo</span>.

> =========================================<br>
> Bienvenido al flujo de chat, <Tu-nombre-de-flujo>.<br>
> Presiona Enter para enviar tu mensaje.<br>
> Puedes salir con Ctrl+C.<br>
> =========================================<br>
> <span style="color:Green">Usuario:</span> ¿Qué tipos de software de contenedores existen?<br>
> <span style="color:Gold">Bot:</span> Existen varios tipos de software de contenedores, incluyendo:<br>
> 1. Docker: Es uno de los software de contenedores más populares, que permite a los desarrolladores empaquetar sus aplicaciones en contenedores y desplegarlas en diferentes entornos.<br>
> 2. Kubernetes: Es una plataforma de orquestación de contenedores de código abierto que automatiza el despliegue, escalado y gestión de aplicaciones en contenedores.<br>
>
> <span style="color:Green">Usuario:</span> ¿Cuál es la diferencia entre ellos?<br>
> <span style="color:Gold">Bot:</span> La principal diferencia entre los sistemas de software de contenedores es su funcionalidad y propósito. Aquí hay algunas diferencias clave:<br>
> 1. Docker se centra más en el empaquetado y despliegue de contenedores, mientras que Kubernetes se centra más en la orquestación y gestión de contenedores.<br>

Si el cliente agrega "--verbose" al comando pf, se mostrará la salida de cada paso.

