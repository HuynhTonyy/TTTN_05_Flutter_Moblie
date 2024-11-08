import joblib
import numpy as np
import pandas as pd
from sklearn.metrics import r2_score
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split

data_Train = pd.read_csv("./backend/student_data_train.csv")

y = data_Train['G3']  # Target variable
X = data_Train.drop(["G3", "Name"], axis=1)  # Drop the target and unnecessary columns

# Apply one-hot encoding to categorical variables
X = pd.get_dummies(X, drop_first=False)

# Convert boolean columns to integers
for column in X.select_dtypes(include=['bool']).columns:
    X[column] = X[column].astype(int)

# Split the data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train the Decision Tree Regressor model
model = DecisionTreeRegressor(random_state=42)
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