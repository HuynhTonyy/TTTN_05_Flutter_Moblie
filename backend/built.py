import joblib
import numpy as np
import pandas as pd
from sklearn.metrics import r2_score
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split

data = pd.read_csv("./backend/student_data_train.csv")
y = data['G3']  # Target variable (final grade)
X = data.drop("G3", axis=1)
X = pd.get_dummies(X, drop_first=True)
for column in X.select_dtypes(include=['bool']).columns:
    X[column] = X[column].astype(int)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = DecisionTreeRegressor()
model.fit(X_train, y_train)

y_predict = model.predict(X_test)
# Step 3: Evaluate the model (optional)
print("Model Accuracy file train:", r2_score(y_test, y_predict))
joblib.dump(model,'decision_tree.joblib')


# Step 1: Load the model/data using joblib
model = joblib.load('decision_tree.joblib')

# Step 2: Save the model/data using pickle
with open('decision_tree.pkl', 'wb') as pkl_file:
    joblib.dump(model, pkl_file)