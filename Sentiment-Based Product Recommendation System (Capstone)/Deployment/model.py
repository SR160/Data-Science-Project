import pickle
import pandas as pd
import numpy as np
#from sklearn.feature_extraction.text import TfidfVectorizer
import random

import warnings
from sklearn.exceptions import InconsistentVersionWarning

# Suppress the specific warning
warnings.filterwarnings("ignore", category=InconsistentVersionWarning)

# Load pre-trained models and data
with open('models/Logistic_Regression_best_model.pkl', 'rb') as f:
    sentiment_model = pickle.load(f)

with open('models/features.pkl', 'rb') as f:
    features = pickle.load(f)

with open('models/user_final_rating.pkl', 'rb') as f:
    user_final_rating = pickle.load(f)

# Load data from sample30.csv
# data_csv = pd.read_csv('sample30.csv')

# Load sentiment data from data.pkl, This equal to raw data but with text processed from main notebook
with open('models/data.pkl', 'rb') as f:
    sentiment_data = pickle.load(f)


# Check if the features.pkl is not a vectorizer, train one
# if isinstance(features, dict):  # If it's a dictionary, train a vectorizer
#     vectorizer = TfidfVectorizer(max_features=5000)  # You can adjust max_features based on your dataset
#     # Fit the vectorizer on the reviews
#     vectorizer.fit(sentiment_data['review_combined_processed'])
# else:
#     vectorizer = features  # If it's already a vectorizer, use it
vectorizer = features

def get_recommendations(username):
    """Recommend top 5 products based on sentiment for the given username."""
    
    if username not in user_final_rating.index:
        return "User not found in database."



    # Get top 20 recommended products for the user based on ratings or similarity matrix
    top_20_recommendations = user_final_rating.loc[username].sort_values(ascending=False)[:20]

    # Filter 5 best products based on sentiment
    best_products = []
    
    for product in top_20_recommendations.index:
        product_reviews = sentiment_data[sentiment_data['id'] == product]

        if not product_reviews.empty:
            # Match the reviews from sentiment_data with processed reviews in sentiment_data
            product_sentiment_data = sentiment_data[sentiment_data['review_combined_processed'].isin(product_reviews['review_combined_processed'])]

            if not product_sentiment_data.empty:
                # Transform the review texts using the vectorizer
                product_features = vectorizer.transform(product_sentiment_data['review_combined_processed'])
                product_sentiments = sentiment_model.predict(product_features)

                # Count positive sentiment reviews
                positive_reviews = np.sum(product_sentiments == 'Positive')
                
                # Get additional details such as brand and manufacturer
                product_info = product_reviews.iloc[0]  # Take the first review to extract additional details
                average_rating = round(product_reviews['reviews_rating'].mean(),2)
                
                best_products.append({
                    'name': product_info['name'],
                    'brand': product_info['brand'],
                    'manufacturer': product_info['manufacturer'],
                    'average_rating': average_rating,
                    
                })

    # Sort products by the number of positive reviews
    best_products_sorted = sorted(best_products, key=lambda x: x['average_rating'], reverse=True)

    # If there are fewer than 5 products with positive sentiment, fill the rest with top-rated products
    if len(best_products_sorted) < 5:
        # Get products from top 20 based on rating if sentiment-based filtering gives fewer than 5
        top_rated_products = top_20_recommendations.index.difference([p['name'] for p in best_products_sorted])

        # Sort by average rating
        top_rated_sorted = sentiment_data[sentiment_data['id'].isin(top_rated_products)].groupby('id')['reviews_rating'].mean().sort_values(ascending=False)
        top_rated_sorted.head()
        # Convert sorted ratings to a list and shuffle to introduce diversity
        top_rated_sorted_list = list(top_rated_sorted.index)
        random.shuffle(top_rated_sorted_list)

        # Append the remaining top-rated products to get at least 5 recommendations
        for product in top_rated_sorted_list:
            if len(best_products_sorted) >= 5:
                break
            product_info = sentiment_data[sentiment_data['id'] == product].iloc[0]  # Get additional details
            average_rating = round(sentiment_data[sentiment_data['id'] == product]['reviews_rating'].mean(),2)
            best_products_sorted.append({
                'name': product_info['name'],
                'brand': product_info['brand'],
                'manufacturer': product_info['manufacturer'],
                'average_rating': average_rating,
                
            })

    # Shuffle the final product list for variety
    random.shuffle(best_products_sorted)

    # Return only the top 5 products with details
    return best_products_sorted[:5]

