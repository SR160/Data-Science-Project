# Data Science Portfolio

Welcome. This repository collects end-to-end **machine learning**, **NLP**, **recommendation systems**, and **generative / retrieval** work applied to realistic business problems: retention, targeting, support automation, e-commerce personalization, and conversational product discovery.

Each project lives in its own folder with a dedicated README, artifacts (where applicable), and reproducible notebooks or application code.

---

## About the portfolio

The work spans the full analytics lifecycle where it matters for hiring and collaboration:

- **Problem framing** — business objectives, constraints, and success metrics  
- **Data engineering** — loading, cleaning, feature design, and train/validation discipline  
- **Modeling** — classical ML, text pipelines, matrix factorization, and modern embedding-based retrieval  
- **Interpretation** — lift curves, confusion matrices, feature importance, and qualitative review  
- **Delivery** — Flask prototypes and deployment-oriented structure (Capstone)

If you are reviewing this for **recruiting or collaboration**, start with any project that aligns with your stack; each README summarizes methods, stack, and how to run or extend the work.

---

## Projects at a glance

| Project | Focus | Highlights |
|--------|--------|------------|
| [Telecom Churn Prediction](./Telecom%20Churn%20Prediction/README.md) | Classification, retention analytics | High-value customer definition, SMOTE, RFE + interpretable models, churn drivers |
| [Automatic Ticket Classification](./Automatic%20Ticket%20Classification/README.md) | NLP, topic modeling, multi-class classification | NMF-derived labels → supervised routing (~93% test accuracy reported in notebook) |
| [H&M Customer Analytics](./H&M%20Customer%20Analytics/README.md) | Customer analytics, CLV-style targeting, recsys | RFM, lift/gain, churn/value models, hybrid recommendations (MAP@12) |
| [Sentiment-Based Product Recommendation (Capstone)](./Sentiment-Based%20Product%20Recommendation%20System%20%28Capstone%29/README.md) | NLP + collaborative filtering + web app | Sentiment model reranks CF candidates; Flask UI; Heroku-oriented layout |
| [Chatbot-Based Recommendation System (Fashion Search AI)](./Chatbot-Based%20Recommendation%20System/README.md) | RAG, vector search, reranking | OpenAI embeddings, ChromaDB, cross-encoder rerank, generative answers |

---

## Final outcomes (portfolio snapshot)

| Project | What shipped | Headline result |
|--------|----------------|-------------------|
| [Telecom Churn](./Telecom%20Churn%20Prediction/README.md) | HVC-scoped churn pipeline + interpretable models | ~**8.14%** churn among high-value customers (notebook); risk ranking + drivers for retention |
| [Ticket classification](./Automatic%20Ticket%20Classification/README.md) | NMF pseudo-labels → supervised routers | ~**93%** test accuracy (multi-class, notebook execution) |
| [H&M analytics](./H&M%20Customer%20Analytics/README.md) | RFM, lift/gain, value/churn models, hybrid recsys | ~**2×** targeting lift; high-value model **~93%** acc / **~98%** ROC-AUC; **MAP@12 ≈ 0.20** |
| [Sentiment recommendations](./Sentiment-Based%20Product%20Recommendation%20System%20%28Capstone%29/README.md) | Sentiment + CF + Flask demo | Best sentiment run **~89%** accuracy; **user-based CF** **RMSE 2.46** vs item **3.58**; top-**5** reranked recommendations |
| [Fashion Search AI](./Chatbot-Based%20Recommendation%20System/README.md) | Embeddings + ChromaDB + rerank + RAG answers | End-to-end **semantic** catalog Q&A with **images** (API-dependent quality) |

Each project README has a dedicated **Final outcomes** section with more detail and caveats.

---

## Tech stack (across projects)

**Languages & core libraries:** Python, pandas, NumPy, scikit-learn  

**Modeling & ML:** logistic regression, tree ensembles (Random Forest, XGBoost), SMOTE / imbalanced learning, RFE, NMF, collaborative filtering  

**NLP & text:** NLTK, spaCy, TF-IDF, lemmatization, topic modeling  

**Modern retrieval & LLMs:** text embeddings, vector stores (ChromaDB), cross-encoders, retrieval-augmented generation patterns  

**Visualization & apps:** Matplotlib, Seaborn, Plotly, Flask, Gunicorn  

---

## Portfolio author

**Shivani Raut**  
[LinkedIn](https://www.linkedin.com/in/raut-shivani/)
