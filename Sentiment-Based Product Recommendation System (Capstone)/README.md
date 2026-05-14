# Sentiment-Based Product Recommendation System (Capstone)

## Overview

End-to-end **e-commerce personalization** prototype for an “Ebuss”-style retailer: combine **review text sentiment**, **ratings**, and **collaborative filtering** so recommendations reflect not only *what similar users bought* but also *how people feel about those products*.

The repository includes a **full analytical notebook**, serialized **models**, sample data, and a **Flask** web UI suitable for local demos or cloud deployment (Heroku-style `Procfile` included).

---

## Business problem

Pure collaborative filtering can surface items that are **popular or similar** but **polarizing or low quality**. Incorporating **sentiment** from reviews helps **down-rank** weak experiences and **up-rank** consistently praised products—closer to how a human curator would recommend.

---

## What you will find here

| Stage | Description |
|-------|-------------|
| **Data sourcing & NLP** | Load product review data; clean and preprocess text; exploratory plots |
| **Sentiment modeling** | TF-IDF features; compare classifiers (e.g. logistic regression, tree ensembles, Naive Bayes); handle imbalance (**SMOTE**); persist best model |
| **Recommendations** | User–item rating matrix; similarity / distance–based collaborative scores; top-N candidate generation |
| **Sentiment reranking** | Take top collaborative candidates per user, score review sentiment, and select a diverse **top-5** list with fallbacks when text is sparse |
| **Deployment** | Flask app + HTML template; `model.py` loads pickles and serves `get_recommendations(username)` |

The serving logic (see `Deployment/model.py`) roughly:

1. Confirm the user exists in the collaborative **user–item** matrix.  
2. Take the **top 20** collaborative candidates.  
3. For each candidate, aggregate reviews, vectorize text, run the **sentiment classifier**, and prefer items with stronger **positive** sentiment density.  
4. If fewer than five strong candidates exist, **fill from highly rated** collaborative picks.  
5. Return five products with **name, brand, manufacturer, average rating**.

---

## Final outcomes

- **Sentiment model:** After TF-IDF features, **grid-searched** classifiers in the notebook rank **logistic regression highest** on held-out data (**~88.9% accuracy**, **~91.7% sensitivity** on the positive class, **~65.7% specificity** in the saved run), with **Random Forest (~85.2%)**, **XGBoost (~88.3%)**, and **Naive Bayes (~84.0%)** trailing—logistic regression is selected as the production sentiment scorer for overall balance.
- **Collaborative filtering:** **User-based** collaborative filtering **outperforms item-based** on the notebook metric (**RMSE ≈ 2.46** vs **≈ 3.58** on normalized ratings), so the **user–item** matrix in the app reflects the stronger approach.
- **Hybrid logic:** For each known user, the system pulls **top-20 collaborative** candidates, **re-ranks with review sentiment**, and returns **five** diverse product recommendations (with rating-based fallback when review text is thin).
- **Shippable demo:** **Flask + HTML** UI and **pickled** artifacts under `Deployment/`, plus a **Heroku-style `Procfile`**, document a path from experiment to a small hosted prototype.

Figures above come from executed cells in `Sentiment_based_Recommendation_System_Full_Notebook.ipynb`; re-run training if you change data or random seeds.

---

## Tech stack

**Notebook:** Python · pandas · NumPy · NLTK · spaCy · scikit-learn · XGBoost · imbalanced-learn · wordcloud · Matplotlib · Seaborn  

**App:** Flask · Gunicorn · pickle  

---

## Repository layout

```
Sentiment-Based Product Recommendation System (Capstone)/
├── Sentiment_based_Recommendation_System_Full_Notebook.ipynb   # Main ML + NLP pipeline
├── sample30.csv                                                 # Sample tabular/review data
├── Pickle Files/                                                # Additional serialized artifacts (if used)
└── Deployment/
    ├── requirements.txt
    ├── Procfile
    ├── model.py                    # Recommendation + sentiment logic (pickle I/O)
    ├── style.css                   # Served as static in template; you may add static/ mapping
    ├── templates/
    │   └── index.html
    └── Models/
        ├── app.py                  # Flask routes
        ├── features.pkl
        ├── user_final_rating.pkl
        └── data.pkl
        # Logistic_Regression_best_model.pkl should live here if referenced by model.py
```

> **Note:** The Colab-oriented notebook may reference Google Drive paths for training. For local runs, mount or copy data to your machine and adjust paths.

---

## Running the Flask app (local)

`app.py` imports `model`, and `model.py` loads pickles from a `models/` subdirectory **relative to the process working directory**. In practice, **`model.py` should sit next to `app.py`** inside `Deployment/Models/` (copy or move the file once), and any missing classifier pickle (e.g. `Logistic_Regression_best_model.pkl`) should be placed in `Deployment/Models/models/` to match the paths in `model.py`.

```powershell
cd "Sentiment-Based Product Recommendation System (Capstone)\Deployment"
pip install -r requirements.txt
copy model.py Models\
cd Models
python app.py
```

Then open the URL shown in the terminal (defaults to Flask dev server). Submit a **username** that exists in the trained user–item index.

**Heroku / Gunicorn:** The included `Procfile` uses `web: gunicorn app:app`. Point the dyno’s **working directory** at `Deployment/Models` (or adjust module paths) so both `app` and `model` import correctly and pickle paths resolve.

**Templates / static:** `index.html` references `url_for('static', filename='style.css')`. Either add a `static` folder with `style.css` or update the template to match how you serve styles in production.

---

## Model artifacts:

- `Logistic_Regression_best_model.pkl` — sentiment classifier  
- `features.pkl` — fitted vectorizer or compatible feature object  
- `user_final_rating.pkl` — user–item score matrix (pandas-friendly)  
- `data.pkl` — processed tabular data with combined review text  



