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
        # # Convert the JSON input to a DataFrame
        # input_df = pd.DataFrame([data])  # Assuming data is a dictionary with one record

        # print(input_df)
        # X_new = pd.get_dummies(input_df, drop_first=False)
        # # Ensure the new data has the same columns as the training data
        # # Get the missing columns (those that are in the model's feature names but not in X_new)
        # missing_cols = set(model.feature_names_in_) - set(X_new.columns)

        # # Add missing columns with default value 0
        # for col in missing_cols:
        #     X_new[col] = 0

        # # Reorder columns to match the model's feature names
        # X_new = X_new[model.feature_names_in_]

        # # Convert boolean columns to integers for compatibility with the model (if needed)
        # for column in X_new.select_dtypes(include=['bool']).columns:
        #     X_new[column] = X_new[column].astype(int)

        # Make predictions
        predictions = model.predict(data)

        # Print predictions
        print(predictions)
        
        # Return the prediction as a JSON response
        return jsonify({"prediction": predictions.tolist()})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run()
