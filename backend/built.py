import joblib
import numpy as np
import pandas as pd
from sklearn.metrics import r2_score
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split

data_Train = pd.read_csv("./backend/student_data_train.csv")
target_columns = [
    "school_GP", "school_MS", "sex_F", "sex_M", "age", "address_R", "address_U",
    "famsize_GT3", "famsize_LE3", "Pstatus_A", "Pstatus_T", "Medu", "Fedu", 
    "Mjob_at_home", "Mjob_health", "Mjob_other", "Mjob_services", "Mjob_teacher",
    "Fjob_at_home", "Fjob_health", "Fjob_other", "Fjob_services", "Fjob_teacher",
    "reason_course", "reason_home", "reason_other", "reason_reputation",
    "guardian_father", "guardian_mother", "guardian_other", "traveltime", 
    "studytime", "failures", "schoolsup_yes", "schoolsup_no", "famsup_yes", 
    "famsup_no", "paid_yes", "paid_no", "activities_yes", "activities_no", 
    "nursery_yes", "nursery_no", "higher_yes", "higher_no", "internet_yes", 
    "internet_no", "romantic_yes", "romantic_no", "famrel", "freetime", "goout", 
    "Dalc", "Walc", "health", "absences", "G1", "G2"
]

y = data_Train['G3']  # Target variable (final grade)
X = data_Train.drop("G3", axis=1)

# Apply one-hot encoding to categorical variables
X = pd.get_dummies(X, drop_first=False)

# Convert boolean columns to integers for compatibility with the model
for column in X.select_dtypes(include=['bool']).columns:
    X[column] = X[column].astype(int)

# Split the data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train the Decision Tree Regressor model
model = DecisionTreeRegressor()
model.fit(X_train, y_train)

# Make predictions on the test set
y_predict = model.predict(X_test)

# Evaluate the model's performance
print("Model Accuracy on training set:", r2_score(y_test, y_predict))

# Print predicted values for inspection
print("Predictions:", y_predict)

# Save the model to the specified folder
joblib.dump(model, './backend/decision_tree.joblib')

# # Reload the model to verify it's saved correctly
# model = joblib.load('./backend/decision_tree.joblib')

# # Save the model as a .pkl file
# with open('./backend/decision_tree.pkl', 'wb') as pkl_file:
#     joblib.dump(model, pkl_file)