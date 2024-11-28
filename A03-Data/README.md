# Configuración de Conexiones: Azure AI Search y CosmosDB

En esta carpeta encontrarás una serie de cuadernos de Jupyter diseñados para establecer las conexiones y cargar los datos necesarios en **Azure AI Search** y **CosmosDB** 

## ¿Qué hacen estos cuadernos de Jupyter?

Los cuadernos están organizados para guiarte en la configuración de las conexiones a los servicios de Azure necesarios para el laboratorio:

### 1️⃣ **create-connections.ipynb**
- Establece la conexión con un servicio de búsqueda de Azure y la conexion con CosmosDB. 
- Configura los endpoint y las claves de administración.

### 2️⃣ **create-cosmos-db.ipynb**
- Configura las credenciales necesarias para acceder a una base de datos CosmosDB.
- Realiza operaciones básicas como listar bases de datos, consultar datos o insertar nuevos documentos.

## ¿Qué hace el fichero de Python?
Este fichero de Python configura y inicializa un índice de Azure Cognitive Search con datos personalizados utilizando búsqueda vectorial y ranking semántico. A continuación, se detalla su funcionamiento:

### Propósito general
El script:
- Carga documentos desde una carpeta.
- Divide los documentos en fragmentos manejables.
- Genera embeddings de los fragmentos utilizando un modelo de Azure OpenAI.
- Crea un índice de Azure Cognitive Search que soporta búsqueda vectorial y semántica.
- Sube los documentos procesados al índice creado.

### Estructura del código
Configuración inicial
- Variables globales como la dirección del servicio de Azure Cognitive Search, las claves API y el nombre del índice son leídas de un archivo .env.
- Utiliza dotenv para cargar configuraciones sensibles, y estas se utilizan para interactuar con los servicios de Azure.
Carga y preprocesamiento de documentos
1. Carga de documentos:
- Se usa langchain y DirectoryLoader para cargar documentos Markdown desde una carpeta especificada (DATA_DIR).
2. División de contenido:
- Divide los documentos en fragmentos manejables utilizando RecursiveCharacterTextSplitter, lo que asegura que cada fragmento sea apto para ser indexado y procesado eficientemente.
3. Conversión a formato de diccionario:
- Los documentos se convierten a un formato JSON-friendly, con campos como id, content, title y sourcefile.

### Generación de embeddings
- Azure OpenAI genera embeddings para los fragmentos usando el modelo de embeddings especificado en AZURE_OPENAI_EMBEDDING_DEPLOYMENT.
- Los embeddings se almacenan como parte del contenido del documento

### Creación del índice en Azure Cognitive Search
#### Definición de campos:
- Define un esquema de campos para el índice, que incluye campos textuales (content, title) y un campo vectorial (embedding).

#### Vector Search:
- Configura un algoritmo de búsqueda vectorial basado en HNSW (Hierarchical Navigable Small World), adecuado para búsquedas de similitud de alto rendimiento.
- Alternativamente, incluye un algoritmo Exhaustive KNN para búsquedas exactas.

#### Semantic Ranking:
- Configura el ranking semántico para priorizar el campo content.


### Carga de datos al índice
- Los documentos procesados (incluyendo embeddings) se suben al índice creado usando el cliente SearchClient de Azure.

### Gestión del índice
- Incluye funciones para crear, inicializar y borrar índices:
 - initialize(): Configura y llena el índice.
 - delete(): Elimina un índice existente para evitar conflictos.

### Ejecución principal
- main():
1. Configura las API de Azure OpenAI.
2. Elimina el índice existente.
3. Inicializa un nuevo índice con los datos procesados.


---

## Instrucciones de uso

1. Abre los cuadernos desde esta carpeta en Visual Studio Code.
2. Selecciona el Kernel `AzureAI` al abrir cada cuaderno.
3. Sigue las instrucciones incluidas en cada cuaderno para configurar y probar las conexiones.

---

## Solución de problemas

- Si encuentras errores relacionados con el Kernel, asegúrate de que el DevContainer esté activo y correctamente configurado.
- Si no puedes conectar a los servicios de Azure, verifica las credenciales y los endpoints configurados en el archivo `.env` del proyecto.

---

¡Explora y configura tus conexiones con facilidad! Si tienes problemas, no dudes en abrir un [issue](https://github.com/Alejandrolmeida/lab-promptflow-01/issues) en el repositorio.


[⬅️ Volver al inicio](../README.md)