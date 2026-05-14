# Chatbot-Based Recommendation System — Fashion Search AI

## Overview

**Fashion Search AI** is a conversational discovery system for fashion products: users describe what they want in natural language, and the pipeline returns **semantically relevant** items with **images** and **narrative explanations** using a modern **retrieval + rerank + generation** stack.

The project demonstrates how to move beyond keyword search toward **meaning-aware** catalog search suitable for chatbots or shopping assistants.

---

## Business problem

Traditional e-commerce search breaks when customers use **long, subjective queries** (“boho summer wedding guest outfit under budget”) or mix **attributes** that are not all filterable in SQL. A **vector search** layer plus **reranking** and **LLM summarization** improves relevance and trust.

---

## Architecture (three layers)

### 1. Embedding and vector store

- **OpenAI** `text-embedding-ada-002` (or successor APIs in your fork) embeds rich product descriptions.  
- Vectors are stored in **ChromaDB** for fast **approximate nearest-neighbor** retrieval.

### 2. Search, cache, and rerank

- **Semantic search** retrieves a broad candidate set; a **cache** can accelerate repeated queries.  
- A **cross-encoder** reranks candidates for finer relevance than cosine similarity alone.

### 3. Retrieval-augmented generation (RAG)

- The system takes the **top retrieved products** (e.g. top 3 after reranking).  
- An LLM **generates** a helpful answer conditioned on the user query and product metadata, including **image links** where available.

---

## Final outcomes

- **End-to-end discovery flow:** A working notebook pipeline from **cleaned catalog text** to **embedding-backed search**, **cross-encoder reranking**, and **RAG-style answers** that cite real products and surface **images**—suitable as a prototype for a shopping chatbot or assistant.
- **Better-than-keyword retrieval:** Semantic vector search over **ChromaDB** handles long, natural-language fashion queries that traditional keyword or faceted search alone typically miss.
- **Quality stack:** Two-stage retrieval (**broad semantic recall → cross-encoder rerank**) reduces false positives before the LLM summarizes, improving perceived relevance versus single-stage embedding search.
- **Operational clarity:** Preprocessing notebook produces analysis-ready descriptions (HTML stripped from attributes, normalized text); the main notebook ties components into a **repeatable conversation** pattern (`initialize_conv()` / prompt flow as implemented there).
- **Extensibility:** Architecture and README roadmap point to filters, moderation, and a future **REST** service—without changing the core research outcome: a **demonstrated multimodal (text + image) recommendation experience**.

Because results depend on API models and prompts, treat qualitative answer quality as **configuration-dependent**; tune and evaluate on your own held-out queries when hardening for production.

---

## Data

The workflow is built around a **Myntra-style fashion catalog** (public Kaggle dataset with descriptions, prices, colors, brands, ratings, and image URLs):

[Myntra Fashion Product Dataset on Kaggle](https://www.kaggle.com/datasets/djagatiya/myntra-fashion-product-dataset?resource=download)

This repository includes:

- `Fashion_Dataset.csv` — working extract used in the main notebook  
- `Fashion Search AI - Preprocessing.ipynb` — references **`Fashion Dataset v2.csv`** in the cleaning pipeline; if you only have `Fashion_Dataset.csv`, align the filename in the notebook or add a copy with the expected name.

---

## Preprocessing highlights

- Handle missing values and drop irrelevant columns  
- Strip **HTML** from `p_attributes` (BeautifulSoup)  
- Normalize whitespace and noisy characters in text fields  

---

## Project files

| File | Description |
|------|-------------|
| `Fashion Search AI - Preprocessing.ipynb` | Data cleaning and preparation |
| `Fashion Search AI.ipynb` | Main pipeline: embeddings, vector DB, search, rerank, RAG-style answering |
| `Fashion_Dataset.csv` | Catalog data for experiments |

---

## Configuration

Set your **OpenAI API key** securely (environment variable recommended).

Example (PowerShell):

```powershell
$env:OPENAI_API_KEY = "sk-..."
```

Install dependencies as needed for your chosen stack (OpenAI SDK, ChromaDB, sentence-transformers / cross-encoder libraries, Jupyter). Exact versions should match the notebook you execute.

---

## Roadmap (from project notes)

- Prompt engineering and evaluation harnesses for answer quality  
- **Moderation** and multi-turn **clarifying** questions for underspecified queries  
- **Structured filters** (size, price band, gender) fused with semantic retrieval  
- Full **Flask** or **FastAPI** service with session memory  

