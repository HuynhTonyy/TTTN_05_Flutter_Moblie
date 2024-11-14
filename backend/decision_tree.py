from flask import Flask, request, jsonify
import joblib
from flask_cors import CORS
import pandas as pd

# Load the ML model
model = joblib.load(open("./backend/decision_tree.joblib", "rb"))

# Initialize the app
app = Flask(__name__)
# Enable CORS for the app
CORS(app)

# Create a route for predictions
@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    
    if data is None:
        return jsonify({"error": "No input data provided"}), 400
    try:

        predictions = model.predict(data)
        return jsonify({"prediction": predictions.tolist()})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run()
