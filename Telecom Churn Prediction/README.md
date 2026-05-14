# Telecom Churn Prediction

## Overview

End-to-end **customer churn** analysis for a telecom use case: understand who leaves, focus retention on **high-value** subscribers, and build an interpretable predictive model aligned with business costs (acquisition vs retention).

This was developed as a **group case study** with emphasis on data preparation, class imbalance, feature selection, and clear storytelling for stakeholders.

---

## Business problem

Telecom markets are competitive; annual churn often sits in the **15–25%** range, and acquiring a customer typically costs **several times** more than retaining one. Operators need to **prioritize high-value customers at risk** and understand **drivers of churn** to act early.

---

## What this project does

1. **Loads and cleans** customer-level usage and recharge data (`telecom_churn_data.csv`).  
2. **Defines high-value customers (HVC)** using a recharge threshold (70th percentile of average recharge in the initial “good” phase).  
3. **Tags churn** in the evaluation window using usage rules (e.g., no voice and no mobile data usage in the churn phase).  
4. **Explores** patterns between churners and non-churners.  
5. **Prepares modeling data**: train/test split, **SMOTE** for imbalance, **RobustScaler** for outlier-heavy numeric features.  
6. **Builds models** — baseline and comparative work includes **logistic regression** with **RFE** (top feature subset), manual review for multicollinearity (e.g., VIF-style thinking via statsmodels), and **tree/boosted** models available in the notebook (Random Forest, XGBoost).  
7. **Reports** discrimination metrics (accuracy, ROC-AUC, precision/recall/F1 as appropriate) and **feature importance** for the chosen interpretable model.

---

## Key methods

| Area | Approach |
|------|-----------|
| Target definition | Churn label from behavioral silence in churn month(s) |
| Scope | Restrict modeling to **high-value customers** |
| Imbalance | SMOTE (see notebook) |
| Scaling | RobustScaler |
| Feature selection | RFE with logistic regression; coefficient interpretation |
| Alternative models | Decision trees, Random Forest, XGBoost (for comparison) |

---

## Final outcomes

- **Business-ready cohort:** Analysis restricted to **high-value customers** (recharge-based rule in the notebook), so retention budget focuses on subscribers who matter most to revenue.
- **Churn definition operationalized:** Churn labels derived from **voice and mobile data inactivity** in the churn window; post-filtering **churn prevalence among high-value customers is about 8.14%** in the executed notebook (re-run to confirm on your CSV snapshot).
- **Modeling package delivered:** Full pipeline from raw usage/recharge features through **SMOTE**, **RobustScaler**, **RFE-driven logistic regression** (interpretable coefficients), side-by-side **tree and boosted** models, and **ROC / confusion-matrix** style evaluation cells.
- **Actionable outputs:** Ranked churn risk for prioritization, plus **feature importance / coefficient direction** to explain *why* a customer looks risky—suitable for campaign design and stakeholder review.

> **Note:** Exact test-set accuracy and ROC-AUC for each model variant appear in the **executed outputs** of `Telecom Churn Prediction.ipynb`; re-run all cells after attaching `telecom_churn_data.csv` if outputs are cleared.

---

## Tech stack

Python · pandas · NumPy · scikit-learn · statsmodels · imbalanced-learn (SMOTE) · XGBoost · Matplotlib · Seaborn

---

## Project files

| File | Description |
|------|-------------|
| `Telecom Churn Prediction.ipynb` | Full analysis: EDA, HVC + churn tagging, preprocessing, modeling, evaluation |

---

## Data

The notebook expects **`telecom_churn_data.csv`** in the working directory (standard telecom churn case-study schema with monthly usage and recharge columns). If your file lives elsewhere, update the `pd.read_csv(...)` path in the notebook.

---

## Possible extensions

- Calibration curves and threshold tuning for retention campaigns  
- Profit-based evaluation (cost of intervention vs saved ARPU)  
- Production scoring pipeline (batch or near-real-time features)
