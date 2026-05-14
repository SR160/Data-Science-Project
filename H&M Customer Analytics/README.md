# H&M Customer Analytics

## Overview

Customer analytics initiative on **H&M-style retail data**: combine **RFM segmentation**, **lift and gain** analysis, **churn and value modeling**, and a **hybrid recommendation system** to improve targeting, retention, and personalization.

The work connects exploratory analysis to **measurable campaign efficiency** (how much of the high-value base you reach for a given budget) and to **recommendation quality** (ranking metrics on held-out interactions).

---

## Business problem

A large apparel retailer has uneven customer value: many loyalty members show **weak or dormant purchase behavior**, while a minority drives a disproportionate share of revenue. The central question:

**How can the business use transactional and customer data to target more efficiently, protect high-value relationships, and personalize recommendations?**

---

## Objectives

- Segment customers by purchase behavior (**RFM**)  
- Identify **high-value** segments and quantify **at-risk** high-value customers  
- Build **churn** and **value** models to prioritize outreach  
- Quantify **targeting lift** vs random selection  
- Deliver a **hybrid recommendation** approach using purchases and product metadata  
- Translate findings into **actionable marketing and retention** recommendations  

---

## Data

Expected inputs (typical H&M Kaggle–style schema):

| Dataset | Contents |
|---------|-----------|
| `customers.csv` | Age, postal code, club member status, fashion news frequency, etc. |
| `transactions.csv` | Customer ID, article ID, price, sales channel, timestamp |
| `articles.csv` | Product metadata: type, color, department, index group, etc. |

Obtain the official files from the **original competition or data provider** and place them where your notebooks read them (or update paths).

---

## Approach

1. **EDA** — demographics, seasonality, channel mix, category performance, spend and frequency.  
2. **RFM segmentation** — Recency, Frequency, Monetary scores; personas such as Champions, At-Risk Champions, Potential Loyalists, Lost.  
3. **Lift and gain** — cumulative capture of high-value customers in top deciles vs baseline.  
4. **Customer value modeling** — regression and classification to estimate / flag high-value customers.  
5. **Churn prediction** — behavioral signals to flag disengagement risk.  
6. **Recommendation system** — hybrid model blending collaborative signals with product information; ranking evaluated with **MAP@K**-style metrics (see modeling notebook).

---

## Final outcomes

- **Segmentation & targeting:** RFM-based segments with **~2× lift** vs random when concentrating marketing on top behavioral tiers; **~42% of high-value customers** reachable while mailing **~21%** of the base (gain-chart interpretation from the analysis).
- **Risk surfaced at scale:** **~200k+ “At-Risk Champions”** flagged (~27% of customers in the cohort), with revenue-at-risk framing for high-value customers cooling off.
- **Predictive performance:** High-value customer classifier at **~93.4% accuracy** and **~98.4% ROC-AUC** (logistic model in notebook); churn modeling supports prioritized retention lists.
- **Personalization:** Hybrid recommender achieves **MAP@12 ≈ 0.2040** on the evaluated setup—concrete ranking quality beyond naive popularity.
- **Artifacts:** Three linked notebooks (**EDA → modeling → recommendations**) plus a concise **business recommendation** narrative suitable for a leadership readout.

---

## Reported results (from project analysis)

These figures come from the analytical notebooks; re-run to reproduce on your data snapshot.

- **~2.00× targeting lift** when focusing on top RFM tiers vs random  
- **~41.96%** of high-value customers captured while targeting **~20.98%** of the base (gain chart interpretation)  
- **~200k+ “At-Risk Champions”** identified (~27% of customers in the analyzed cohort)  
- **Revenue-at-risk** framing: substantial share of revenue associated with high-value but cooling customers  
- High-value classification: **~93.4% accuracy**, **~98.4% ROC-AUC** (logistic model in notebook)  
- Hybrid recommender: **MAP@12 ≈ 0.2040**  

---

## Business recommendations (summary)

- Prioritize **premium retention and upsell** for proven Champions  
- Run **urgent win-back** for At-Risk Champions with clear offer logic  
- Reallocate spend from broad demographic targeting to **behavioral** RFM-based lists  
- Combine **churn probability** and **value** to decide **offer depth**  
- Deploy recommendations in digital journeys where history is rich  

---

## Tech stack

Python · pandas · NumPy · scikit-learn · Matplotlib · Seaborn · RFM · lift/gain analysis · logistic regression · decision trees · gradient boosting · collaborative filtering · hybrid recommendation evaluation  

---

## Project files (this repository)

| Notebook | Description |
|----------|-------------|
| `H&M_EDA.ipynb` | Exploratory data analysis |
| `H&M_Modeling.ipynb` | Segmentation, churn, lift/gain, customer value modeling |
| `H&M_Recommendation System.ipynb` | Recommendation system development and evaluation |


---

## Future work

- Near–real-time scoring and feature stores  
- Dynamic CLV forecasting and longitudinal validation  
- A/B tests on retention creatives and offer bands  
- Deeper **basket** and **cross-category** affinity models  
- Production deployment of ranking and batch segment exports  

