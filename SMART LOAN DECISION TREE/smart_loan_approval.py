# Smart Loan Approval using Decision Tree
# Generated dataset + preprocessing + Gini vs Entropy comparison

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix

# 1. Load the dataset
df = pd.read_csv("loan_approval_dataset.csv")

# 2. Encode categorical data
X = pd.get_dummies(df.drop(columns=["Loan_Status"]), columns=["Employment_Status"])
y = df["Loan_Status"].map({"Rejected": 0, "Approved": 1})

# 3. Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.20, random_state=42, stratify=y
)

# 4. Compare attribute-selection measures
models = {
    "Gini Index": DecisionTreeClassifier(criterion="gini", max_depth=5, random_state=42),
    "Information Gain (Entropy)": DecisionTreeClassifier(
        criterion="entropy", max_depth=5, random_state=42
    )
}

for name, model in models.items():
    model.fit(X_train, y_train)
    pred = model.predict(X_test)

    print("\n", name)
    print("Accuracy :", round(accuracy_score(y_test, pred), 4))
    print("Precision:", round(precision_score(y_test, pred), 4))
    print("Recall   :", round(recall_score(y_test, pred), 4))
    print("F1-Score :", round(f1_score(y_test, pred), 4))
    print("Confusion Matrix:\n", confusion_matrix(y_test, pred))

# 5. Example prediction
best_model = models["Gini Index"]
best_model.fit(X_train, y_train)

sample = pd.DataFrame([{
    "Income": 85000,
    "Credit_Score": 740,
    "Employment_Status": "Salaried",
    "Loan_Amount": 30000,
    "Repayment_History": 8,
    "Age": 30
}])
sample = pd.get_dummies(sample)
sample = sample.reindex(columns=X.columns, fill_value=False)

prediction = best_model.predict(sample)[0]
print("\nSample Loan Decision:", "Approved" if prediction == 1 else "Rejected")
