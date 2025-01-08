from flask import Flask, request, render_template
import model  # Importing model.py

app = Flask(__name__)

# Home route
@app.route('/')
def index():
    return render_template('index.html')

# Recommendation route
@app.route('/recommend', methods=['POST'])
def recommend():
    username = request.form['username']
    # Fetch recommendations from model.py
    recommendations = model.get_recommendations(username)

    if isinstance(recommendations, str):
        return render_template('index.html', prediction_text=recommendations)

    # Pass the list of recommended products to the template
    return render_template('index.html', prediction_text=f"Recommended products for {username}:", products=recommendations)

if __name__ == "__main__":
    app.run(debug=True)