# 01 - OpenAI Connection

## Configuración de la Conexion con Azure OpenAI

En esta carpeta encontrarás un cuaderno de Jupyter diseñado para establecer la conexion necesaria con **Azure OpenAI**.

---

## Requisito previo: Configuración de PromptFlow en Visual Studio Code

Antes de ejecutar este cuaderno de Jupyter, es importante que el componente **PromptFlow** esté configurado correctamente en **Visual Studio Code**. Este componente es esencial para trabajar con las integraciones proporcionadas en este laboratorio.

### Pasos para configurar el componente de PromptFlow:

1. **Abrir Visual Studio Code**: 
   - Si estás usando el DevContainer del proyecto, asegúrate de que esté activo.

2. **Acceder a PromptFlow**:
   - Desde Visual Studio Code, localiza el panel de **PromptFlow** en la barra lateral.

3. **Seleccionar el Kernel Python**:
   - Al abrir los cuadernos de Jupyter, selecciona el Kernel llamado `AzureAI` (este ya debería estar configurado si estás usando el DevContainer).

4. **Validar la configuración**:
   - Sigue los pasos del asistente para ejecutar y configurar todos los modulos de PF.

---

## ¿Qué hace el cuaderno de Jupyter?

Este cuaderno está diseñado  para guiarte en la configuración de la conexion al servicios de Azure OpenAI necesario para el laboratorio:

### 1️⃣ **create-openai-connection.ipynb**
- Establece la conexión con un servicio de búsqueda de Azure (Azure Search), CosmosDb y Azure OpenAI para acceder desde PromptFlow.
- Configura los endpoints y las claves de administración.


---

## Instrucciones de uso

1. Abre el cuaderno desde esta carpeta en Visual Studio Code.
2. Selecciona el Kernel `AzureAI` al abrir el cuaderno.
3. Sigue las instrucciones incluidas en el cuaderno para configurar y probar las conexiones.

---

## Solución de problemas

- Si encuentras errores relacionados con el Kernel, asegúrate de que el DevContainer esté activo y correctamente configurado.
- Si no puedes conectar a los servicios de Azure, verifica las credenciales y los endpoints configurados en el archivo `.env` del proyecto.

---

¡Explora y configura tus conexiones con facilidad! Si tienes problemas, no dudes en abrir un [issue](https://github.com/Alejandrolmeida/lab-promptflow-01/issues) en el repositorio.

[⬅️ Volver al inicio](../README.md)