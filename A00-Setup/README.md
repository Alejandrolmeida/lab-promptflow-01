# 00 - Setup

## Configuración Inicial del Entorno

En esta carpeta encontrarás los archivos necesarios para configurar los recursos en Azure que se utilizarán en este laboratorio. Sigue las instrucciones a continuación para completar la configuración inicial.

## Archivos en esta carpeta

- **`main.bicep`**: Archivo Bicep que define la infraestructura a desplegar en Azure.
- **`setup.sh`**: Script Bash que automatiza la creación de los recursos en Azure y la configuración del entorno.
- **`.env`**: Archivo de variables de entorno necesario para personalizar la configuración.

---

## Pasos para la configuración

### 1️⃣ Crear un archivo `.env`

Antes de ejecutar el script, es necesario crear un archivo `.env` en la raíz del repositorio. Este archivo debe contener las variables necesarias para personalizar la configuración de los recursos en Azure.

Crea el archivo `.env` y copia el siguiente contenido de ejemplo:

```plaintext
# Ejemplo de archivo .env
TENANT_ID=147acad1-d48a-4bff-b318-0080721c9de2
SUBSCRIPTION_ID=0b7a1d33-92a5-4725-a90c-4127717a76f0
RESOURCE_GROUP=promptflow-rg
DEPLOYMENT_NAME=promptflow-deployment
LOCATION=eastus2
PROJECT_NAME=pflab01
```

**Importante:** 
- Sustituye los valores de ejemplo por los datos correspondientes a tu suscripción de Azure.
- Antes de seleccionar una región (`LOCATION`), verifica la disponibilidad del modelo **GPT-4o** en esa región. Puedes consultar esta [documentación oficial](https://learn.microsoft.com/es-es/azure/ai-services/openai/concepts/models?tabs=python-secure%2Cglobal-standard%2Cstandard-chat-completions).


---

### 2️⃣ Ejecutar el script `setup.sh`

El script `setup.sh` automatiza el proceso de configuración del entorno. Antes de ejecutarlo, asegúrate de tener instalado y configurado lo siguiente:

- [Azure CLI](https://learn.microsoft.com/es-es/cli/azure/install-azure-cli)
- Permisos para crear recursos en tu suscripción de Azure.

Para ejecutar el script, sigue estos pasos:

1. Abre una terminal en la carpeta `setup`.
2. Asegúrate de que el archivo `.env` está creado y contiene los valores correctos.
3. Ejecuta el siguiente comando:

   ```bash
   bash setup.sh
   ```

---

## ¿Qué hace el script `setup.sh`?

1. **Inicio de sesión en Azure:** Comprueba si estás autenticado en Azure CLI y, si no, inicia sesión utilizando tu `TENANT_ID`.
2. **Creación del grupo de recursos:** Crea un grupo de recursos en la ubicación especificada.
3. **Despliegue de la infraestructura:** Utiliza el archivo `main.bicep` para crear los recursos necesarios.
4. **Configuración de variables de entorno:** Genera claves y puntos de conexión para los servicios desplegados y actualiza el archivo `.env` automáticamente.
5. **Creación del archivo `config.json`:** Este archivo es necesario para usar PromptFlow y contiene información del espacio de trabajo.

---

### 3️⃣ Verificar la configuración

Una vez completado el proceso, asegúrate de que los siguientes archivos se hayan generado correctamente:
- **`.env`:** Contendrá las claves y puntos de conexión necesarios.
- **`config.json`:** Archivo de configuración para PromptFlow.

---

## Solución de problemas

Si encuentras algún problema al ejecutar el script, verifica lo siguiente:
- Que Azure CLI esté instalado y actualizado.
- Que tengas permisos para crear recursos en la suscripción.
- Que los valores en el archivo `.env` sean correctos.

---

¡Tu entorno ya estará listo para comenzar el laboratorio!

[⬅️ Volver al inicio](../README.md)