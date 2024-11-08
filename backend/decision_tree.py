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
        # target_columns = [
        #     "school_GP", "school_MS", "sex_F", "sex_M", "age", "address_R", "address_U",
        #     "famsize_GT3", "famsize_LE3", "Pstatus_A", "Pstatus_T", "Medu", "Fedu", 
        #     "Mjob_at_home", "Mjob_health", "Mjob_other", "Mjob_services", "Mjob_teacher",
        #     "Fjob_at_home", "Fjob_health", "Fjob_other", "Fjob_services", "Fjob_teacher",
        #     "reason_course", "reason_home", "reason_other", "reason_reputation",
        #     "guardian_father", "guardian_mother", "guardian_other", "traveltime", 
        #     "studytime", "failures", "schoolsup_yes", "schoolsup_no", "famsup_yes", 
        #     "famsup_no", "paid_yes", "paid_no", "activities_yes", "activities_no", 
        #     "nursery_yes", "nursery_no", "higher_yes", "higher_no", "internet_yes", 
        #     "internet_no", "romantic_yes", "romantic_no", "famrel", "freetime", "goout", 
        #     "Dalc", "Walc", "health", "absences", "G1", "G2"
        # ]
        
        # # Ensure the new data only contains the target columns
        # data = data[target_columns]
        print(data)

        # # Make predictions
        predictions = model.predict(data)

        # # Print predictions
        # print(predictions)
        
        # Return the prediction as a JSON response
        return jsonify({"prediction": predictions.tolist()})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run()
