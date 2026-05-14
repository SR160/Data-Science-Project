# Automatic Ticket Classification

## Overview

This project builds a **text classification** system for **customer support tickets**: unstructured complaints are grouped into **product/service categories** so they can be routed faster and resolved with the right team.

Because raw tickets are **not labeled** with department names, the pipeline uses **unsupervised topic modeling (NMF)** to discover themes, maps them to business categories, then trains **supervised classifiers** on the resulting pseudo-labels for **new ticket routing**.

---

## Business problem

Support organizations receive large volumes of free-text complaints. Manual triage is slow and inconsistent. The goal is to **automatically assign** each ticket to one of five themes:

- Credit card / prepaid card  
- Bank account services  
- Theft / dispute reporting  
- Mortgages / loans  
- Others  

---

## Methodology

1. **Data loading** — ingest JSON complaints (e.g. `complaints-2021-05-14_08_16.json`), normalize to a flat DataFrame.  
2. **Text preprocessing** — cleaning, tokenization, stopwords, lemmatization (NLTK + **spaCy** `en_core_web_sm`).  
3. **EDA** — length distributions, word clouds, exploratory plots (**Plotly**, Seaborn).  
4. **Feature extraction** — sparse text representations (e.g. **TF-IDF** / count-based pipelines as in the notebook).  
5. **Topic modeling** — **NMF** to extract topics; interpret top terms per topic and align topics to the five business categories.  
6. **Supervised learning** — train classifiers (e.g. **logistic regression**, **decision tree**, **random forest**) on the topic-assigned labels.  
7. **Evaluation** — multi-class **accuracy**, precision/recall/F1 per class; train vs test comparison to monitor generalization.

---

## Final outcomes

- **Unsupervised → supervised bridge:** **NMF topic modeling** on complaint text produces interpretable themes that are **mapped to five business categories**, yielding a large **pseudo-labeled** dataset for supervised training.
- **Routing model quality:** In the notebook’s executed evaluation, a tuned pipeline reaches on the order of **~95% training accuracy** and **~93% test accuracy** (multi-class), with strong per-class precision/recall in the printed **classification reports**—indicating the approach generalizes beyond topic-assignment noise.
- **Comparable classifiers:** **Logistic regression**, **decision tree**, and **random forest** are trained and contrasted so you can trade off interpretability vs raw accuracy for production routing rules.
- **Deliverable:** A single end-to-end notebook that ingests **JSON** complaints and supports **inference on new tickets** (model-building and evaluation sections).

See the **classification_report** and confusion-matrix cells in `Automatic Ticket Classification.ipynb` for the exact numbers on your run.

---

## Tech stack

Python · pandas · NumPy · NLTK · spaCy · scikit-learn · swifter · wordcloud · Seaborn · Matplotlib · Plotly

---

## Project files

| File | Description |
|------|-------------|
| `Automatic Ticket Classification.ipynb` | Full pipeline from JSON load through NMF labeling and supervised models |

---

## Future improvements

- Human-in-the-loop relabeling for ambiguous NMF–category mappings  
- Hierarchical classification (coarse department → fine sub-issue)  
- Multilingual support and production monitoring (drift, OOD detection)
