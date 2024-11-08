from flask import Flask, request, jsonify
import joblib
# from flask_ngrok import run_with_ngrok
from flask_cors import CORS
import numpy as np
import pandas as pd

# Load the ML model and other required data
model = joblib.load(open("./backend/decision_tree.pkl", "rb"))

# Initialize the app
app = Flask(__name__)
# Enable CORS for the app
CORS(app)

# Create a route for predictions
@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    print(data)

    if data is None:
        return jsonify({"error": "No input data provided"}), 400
    try:
        
        
        prediction = model.predict(data)
        return jsonify({"prediction": prediction.tolist()})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run()