# Guía paso a paso: Crear un flujo de chat sencillo con PromptFlow

En esta guía, aprenderás cómo crear un flujo de chat básico utilizando **PromptFlow** desde la extensión para Visual Studio Code. Usaremos una conexión ya configurada a **Azure OpenAI** llamada `oai_lab_promptflow`.

---

## Pasos para crear un flujo de chat sencillo

### 1️⃣ Abrir Visual Studio Code y acceder a PromptFlow

1. **Abrir Visual Studio Code**.
2. Asegúrate de que la extensión de **PromptFlow** esté instalada. Si estás usando el DevContainer del proyecto, esta ya debería estar disponible.
3. En la barra lateral izquierda, haz clic en el icono de **PromptFlow** para abrir el panel correspondiente.

---

### 2️⃣ Crear un nuevo flujo

1. Haz clic en el botón **"Create New Flow"** (Crear nuevo flujo) en el panel de PromptFlow.
2. Asigna un nombre al flujo, por ejemplo: `SimpleFlow`.
3. Selecciona la opción para crear un flujo basado en plantillas y elige la plantilla **Chat**.

---

### 3️⃣ Configurar el flujo de chat

1. **Definir la conexión**:
   - En la configuración del flujo, selecciona la conexión **`oai_lab_promptflow`** como el modelo a utilizar.
   - Asegúrate de que la conexión esté funcionando. Puedes verificarlo haciendo clic en "Test Connection".

2. **Agregar el prompt inicial**:
   - Define un mensaje inicial que el modelo utilizará como contexto para las interacciones. Por ejemplo:
     ```plaintext
     Eres un asistente virtual diseñado para ayudar con preguntas relacionadas con PromptFlow.
     ```

3. **Configurar los ajustes del modelo**:
   - Elige el modelo que deseas usar (por ejemplo, `gpt-4` o `gpt-3.5-turbo`, dependiendo de lo disponible en la conexión).
   - Ajusta los parámetros como la temperatura, la frecuencia de penalización, y el límite de tokens según sea necesario. Para un chat básico, puedes usar los valores predeterminados.

---

### 4️⃣ Crear un nodo de entrada de usuario

1. Haz clic en **"Add Node"** para agregar un nuevo nodo.
2. Selecciona el tipo de nodo **"User Input"** (Entrada de usuario).
3. Configura el nodo para aceptar texto como entrada.

---

### 5️⃣ Conectar nodos y salida del modelo

1. Arrastra una línea desde el nodo de entrada del usuario hacia el modelo de OpenAI configurado.
2. Agrega un nodo de salida para mostrar la respuesta del modelo.
3. Conecta la salida del modelo al nodo de salida.

---

### 6️⃣ Guardar y probar el flujo

1. Haz clic en el botón **"Save Flow"** (Guardar flujo).
2. Para probar el flujo:
   - Haz clic en el botón **"Test Flow"** (Probar flujo).
   - Introduce una pregunta o mensaje en el campo de entrada del usuario y observa cómo el modelo responde.

---

### 7️⃣ Ajustar el flujo según sea necesario

- Puedes volver a editar el prompt inicial o los parámetros del modelo para ajustar el comportamiento del chat.
- Agrega lógica adicional si necesitas manejar casos específicos.

---

## ¡Listo!

Has creado un flujo de chat básico utilizando PromptFlow y una conexión a Azure OpenAI. Ahora puedes extender este flujo para incluir más nodos o lógica según las necesidades de tu proyecto.

---

Si tienes dudas o necesitas más información, consulta la [documentación oficial de PromptFlow](https://learn.microsoft.com/en-us/azure/machine-learning/prompt-flow/).
