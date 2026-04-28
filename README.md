# H&M Customer Analytics

Customer analytics project focused on segmentation, churn prediction, customer value identification, and personalized recommendations using H&M transaction, customer, and product data.

## Table of Contents
- [Overview](#overview)
- [Business Problem](#business-problem)
- [Objectives](#objectives)
- [Dataset](#dataset)
- [Approach](#approach)
- [Key Results](#key-results)
- [Business Recommendations](#business-recommendations)
- [Tech Stack](#tech-stack)
- [Project Files](#project-files)
- [Future Improvements](#future-improvements)
- [Author](#author)

## Overview
This project uses behavioral and transactional data to understand customer value, identify churn risk, and improve targeting and personalization. The analysis combines customer segmentation, lift/gain analysis, predictive modeling, and recommendation systems to support better marketing and retention decisions.

## Business Problem
H&M has a large customer base, but not all customers contribute equally to revenue or engagement. Many customers appear active through loyalty membership, while actual buying behavior shows dormancy, churn risk, and uneven value concentration.

The goal was to answer:

**How can H&M use customer data to improve targeting efficiency, protect high-value customers, and personalize product recommendations?**

## Objectives
- Segment customers based on purchase behavior
- Identify high-value customers
- Predict churn risk and prioritize retention
- Improve campaign targeting efficiency
- Build a personalized recommendation system
- Translate analysis into actionable business strategy

## Dataset
The project uses three datasets:

### `customers.csv`
Customer-level attributes such as:
- age
- postal code
- club member status
- fashion news frequency

### `transactions.csv`
Transaction-level purchase history including:
- customer ID
- article ID
- price
- sales channel
- transaction date

### `articles.csv`
Product metadata including:
- article ID
- product type
- color
- department
- index group

## Approach

### 1. Exploratory Data Analysis
Explored:
- customer demographics
- transaction trends over time
- channel behavior
- product category performance
- purchase frequency and spending patterns

### 2. RFM Segmentation
Segmented customers using:
- **Recency**
- **Frequency**
- **Monetary value**

Used RFM scores to identify customer groups such as Champions, At-Risk Champions, Potential Loyalists, and Lost customers.

### 3. Lift and Gain Analysis
Measured how efficiently top segments captured high-value customers versus random targeting.

### 4. Customer Value Modeling
Used regression and classification approaches to estimate customer value and classify high-value customers.

### 5. Churn Prediction
Built churn models to identify customers likely to disengage based on behavioral signals.

### 6. Recommendation System
Built a hybrid recommendation framework using customer purchase history and product information to generate personalized suggestions.

## Key Results

- **2.00x targeting lift** achieved by focusing on top RFM segments
- **41.96% of high-value customers captured** while targeting only **20.98%** of the customer base
- Identified **200,107 At-Risk Champions**, representing **26.8% of customers**
- Estimated **30 to 40% of revenue at risk** from high-value but disengaging customers
- Logistic classification achieved **93.37% accuracy** and **98.43% ROC-AUC** for high-value customer prediction
- Hybrid recommendation model achieved **MAP@12 = 0.2040**

## Business Recommendations
- Prioritize top RFM customers for premium acquisition and upsell campaigns
- Launch retention campaigns for At-Risk Champions immediately
- Shift marketing spend toward behavioral targeting instead of demographic targeting
- Use churn risk and customer value together to guide offer intensity
- Deploy personalized product recommendations in digital channels

## Tech Stack
- Python
- Pandas
- NumPy
- Scikit-learn
- Matplotlib
- Seaborn
- RFM Analysis
- Lift and Gain Analysis
- Logistic Regression
- Decision Tree
- Gradient Boosting
- Collaborative Filtering
- Recommendation Systems

## Project Files
- `Team_14_H&M_EDA.ipynb` - exploratory data analysis
- `Team_14_H&M_Modeling.ipynb` - segmentation, churn, lift/gain, customer value modeling
- `RecommendationSystemTeam14.ipynb` - recommendation system development
- `EDA&Models.ipynb` - integrated analysis notebook

## Future Improvements
- Real-time customer scoring
- Dynamic CLV forecasting
- A/B testing on retention and targeting strategies
- Channel attribution modeling
- Product affinity and basket analysis
- Production deployment of recommendation workflows

## Author
**Shivani Raut**
