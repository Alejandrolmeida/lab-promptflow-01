# **Flujo de Tipo RAG en PromptFlow**

---

## **Paso 1: Crear un flujo con plantilla de chat**
1. Selecciona la plantilla de tipo *Chat* al crear el flujo.
2. Nombra el flujo y configúralo con tu conexión de OpenAI.

---

## **Paso 2: Agregar herramientas al flujo**

### **Tool 1: Embeddings (question_embedding)**
1. Agrega una tool de tipo embeddings.
2. Configura las propiedades:
   - **Input**: `inputs.question`.
   - **Connection**: `oai_lab_promptflow`.
   - **Deployment name**: Especifica el nombre de tu modelo.

### **Tool 2: Búsqueda RAG (rag_search)**
1. Crea una tool de tipo Python y edita su código:
   - Cambia el nombre del archivo a `rag_search.py`.
   - Actualiza la firma de la función:
     ```python
     def my_python_tool(question: str, index_name: str, embedding: List[float], search: CognitiveSearchConnection) -> str:
     ```
   - Agrega los imports necesarios:
     ```python
     from promptflow import tool
     from typing import List
     from azure.search.documents import SearchClient
     from azure.search.documents.models import VectorizedQuery, QueryType, QueryCaptionType, QueryAnswerType
     from azure.core.credentials import AzureKeyCredential
     from promptflow.connections import CognitiveSearchConnection
     ```
   - Implementa la lógica en la función:
     ```python
     @tool
     def my_python_tool(question: str, index_name: str, embedding: List[float], search: CognitiveSearchConnection) -> str:
         search_client = SearchClient(endpoint=search.api_base, 
                                      index_name=index_name, 
                                      credential=AzureKeyCredential(search.api_key))

         vector_query = VectorizedQuery(vector=embedding, 
                                        k_nearest_neighbors=3, 
                                        fields="embedding")

         results = search_client.search(  
             search_text=question,  
             vector_queries=[vector_query],
             query_type=QueryType.SEMANTIC, 
             semantic_configuration_name='default', 
             query_caption=QueryCaptionType.EXTRACTIVE, 
             query_answer=QueryAnswerType.EXTRACTIVE,
             top=5
         )

         docs = [{"id": doc["id"],  "content": doc["content"]} for doc in results]
         return docs
     ```

### **Tool 3: Consulta a Cosmos DB (customer_lookup)**
1. Agrega otra tool de tipo Python y nómbrala `customer_lookup`.
2. Copia el siguiente código:
   ```python
   from promptflow import tool
   from azure.cosmos import CosmosClient
   from promptflow.connections import CustomConnection

   @tool
   def my_python_tool(customerId: str, conn: CustomConnection) -> str:
       client = CosmosClient(url=conn.configs["endpoint"], credential=conn.secrets["key"])
       db = client.get_database_client(conn.configs["databaseId"])
       container = db.get_container_client(conn.configs["containerId"])
       response = container.read_item(item=customerId, partition_key=customerId)
       services = response["services"]
       services = sorted(services, key=lambda x: x["Severity"], reverse=True)
       response["services"] = services[-3:]
       return response
   ```
3. Configura:
   - **Input**: `inputs.customerId`.
   - **Connection**: Objeto de conexión de Cosmos DB.

---

## **Paso 3: Configurar la plantilla Prompt (customer_prompt)**
1. Agrega una tool de tipo Prompt y edita el archivo `jinja`.
2. Introduce el siguiente contenido:
   ```jinja
   # Task
   You are an AI customer support agent for Azurebrains, a community of Azure experts...
   # Documentation
   {% for item in documentation %}
   item number: {{item.id}}
   ...
   {% endfor %}
   # Customer Insights
   {% for item in customer.services %}
   type: {{item.Type}}
   ...
   {% endfor %}
   # Customer Context
   The customer's name is {{customer.name}} ...
   ```
3. Configura:
   - **Documentation**: `rag_search.output`.
   - **Customer**: `customer_lookup.output`.

---

## **Paso 4: Configurar el objeto de chat**
1. Renombra el objeto a `llm_call`.
2. Ajusta las propiedades:
   - **Connection**: Tu conexión OpenAI.
   - **Deployment name**: `gpt-4o`.
   - **Max tokens**: 512.
3. Modifica el archivo Jinja:
   ```jinja
   system:
   {{prompt_text}}

   {% for item in history %}
   user:
   {{item.inputs.question}}

   assistant:
   {{item.outputs.answer}} 
   {% endfor %}

   user:
   {{question}}
   Please be brief, use my name in the response, reference 
   previous purchases, and add emojis for personalization and flair.
   ```

---

Este flujo combina búsquedas avanzadas con RAG y consultas a Cosmos DB, proporcionando un asistente efectivo y personalizado. ¡Estás listo para implementarlo en PromptFlow! 🚀