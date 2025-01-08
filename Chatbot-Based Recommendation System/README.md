# FASHION SEARCH AI

# Introduction
This project aims to develop a generative search system to search through product descriptions and recommend appropriate fashion choices based on user queries. The system uses advanced AI models and search algorithms to provide accurate and relevant results.

# Data Source
The primary data source for this project is the Myntra fashion product dataset from Kaggle. This dataset includes detailed descriptions, prices, colors, brands, ratings, and other relevant attributes of fashion items available on Myntra along with their images.
Link - https://www.kaggle.com/datasets/djagatiya/myntra-fashion-product-dataset?resource=download

# Data Preprocessing
Key preprocessing steps included:
- Filling null values and removing unwanted columns.
- Removing HTML tags from the p_attributes column.
- Performing basic data cleaning such as removing white spaces and extra characters.
  
# Layers
The system is made of three layer:
1. Generating and Storing Embeddings Layer (Vector Store):
   - Uses OpenAI’s text-embedding-ada-002 model to create vector representations for fashion product descriptions.
   - Embeddings are stored in ChromaDB for efficient retrieval and semantic search.
2. Search, Cache, and Rerank Layer:
   - Semantic Search with Cache: Handles the primary search and utilizes caching for frequent queries.
   - Re-ranking Layer: Refines search results with a cross-encoder to improve relevance.
3. Retrieval-Augmented Generation Layer:
   - Retrieves the top 3 results based on semantic search and cross-encoder scores.
   - Combines these results with the user query to generate comprehensive answers and include images of recommended items.

# Usage
1. Run the main script.
2. Enter your query when prompted or use initialize_conv() to start conversation.
3. View the recommended fashion items along with their images and descriptions

# Future Scope 
- Improving Prompts: Better prompts can enhance the quality of the generated responses.
- Moderation and Iteration Layer: Adding a moderation layer to filter inappropriate content and an iteration layer to gather more information from users can improve the system's performance.
- Content and Product-Based Filters: Implementing these filters can further enhance system performance by providing more tailored recommendations.
- Application Development: The project can be extended to develop a flask application.

# Conclusion
The Fashion Search AI project successfully implements a search system using the RAG pipeline and semantic search layer. The system efficiently retrieves and generates relevant fashion product recommendations. 

# Contributors
- Shivani Raut
- Sindhu M 
- Vidhya Manikandan
