# ============================================================
# EXPLAINABLE DIAGNOSIS SYSTEM
# AI Model Design Exercise - Topic 9
# ============================================================

import matplotlib
matplotlib.use("Agg")

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

plt.style.use("seaborn-v0_8-darkgrid")

from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    confusion_matrix,
    classification_report
)
from sklearn.preprocessing import StandardScaler


# ============================================================
# 1. LOAD DATASET
# ============================================================

print("=" * 60)
print("EXPLAINABLE DIAGNOSIS SYSTEM")
print("=" * 60)

data = load_breast_cancer()

X = pd.DataFrame(data.data, columns=data.feature_names)
y = pd.Series(data.target, name="diagnosis")

print("\nDataset loaded successfully.")
print("Number of samples:", X.shape[0])
print("Number of features:", X.shape[1])

print("\nTarget classes:")
for i, name in enumerate(data.target_names):
    print(i, "=", name)


# ============================================================
# 2. DATA PREPROCESSING
# ============================================================

print("\n" + "=" * 60)
print("DATA PREPROCESSING")
print("=" * 60)

# Check missing values
print("\nMissing values:")
print(X.isnull().sum().sum())

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)

print("\nTraining samples:", len(X_train))
print("Testing samples:", len(X_test))


# ============================================================
# 3. FEATURE SCALING
# ============================================================

scaler = StandardScaler()

X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

X_train_scaled = pd.DataFrame(
    X_train_scaled,
    columns=X.columns,
    index=X_train.index
)

X_test_scaled = pd.DataFrame(
    X_test_scaled,
    columns=X.columns,
    index=X_test.index
)


# ============================================================
# 4. BUILD EXPLAINABLE AI MODEL
# ============================================================

print("\n" + "=" * 60)
print("MODEL TRAINING")
print("=" * 60)

model = DecisionTreeClassifier(
    criterion="entropy",
    max_depth=5,
    min_samples_split=5,
    random_state=42
)

model.fit(X_train_scaled, y_train)

print("\nDecision Tree trained successfully.")


# ============================================================
# 5. PREDICTION
# ============================================================

y_pred = model.predict(X_test_scaled)


# ============================================================
# 6. MODEL EVALUATION
# ============================================================

accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

print("\n" + "=" * 60)
print("MODEL PERFORMANCE")
print("=" * 60)

print(f"\nAccuracy  : {accuracy:.4f}")
print(f"Precision : {precision:.4f}")
print(f"Recall    : {recall:.4f}")
print(f"F1 Score  : {f1:.4f}")

print("\nClassification Report:")
print(classification_report(
    y_test,
    y_pred,
    target_names=data.target_names
))


# ============================================================
# 7. CONFUSION MATRIX
# ============================================================

cm = confusion_matrix(y_test, y_pred)

print("\nConfusion Matrix:")
print(cm)

plt.figure(figsize=(6, 5))

plt.imshow(cm, cmap="coolwarm", vmin=0, vmax=max(1, cm.max()))

plt.title("Confusion Matrix")
plt.xlabel("Predicted Class")
plt.ylabel("Actual Class")

plt.xticks(
    [0, 1],
    data.target_names
)

plt.yticks(
    [0, 1],
    data.target_names
)

for i in range(2):
    for j in range(2):
        plt.text(
            j,
            i,
            cm[i, j],
            ha="center",
            va="center",
            color="black",
            fontsize=12
        )

plt.colorbar()
plt.tight_layout()
plt.savefig("confusion_matrix.png", dpi=150, bbox_inches="tight")
plt.close()
print("\nSaved confusion matrix to confusion_matrix.png")


# ============================================================
# 8. FEATURE IMPORTANCE
# ============================================================

feature_importance = pd.DataFrame({
    "Feature": X.columns,
    "Importance": model.feature_importances_
})

feature_importance = feature_importance.sort_values(
    by="Importance",
    ascending=False
)

print("\n" + "=" * 60)
print("TOP IMPORTANT FEATURES")
print("=" * 60)

print(
    feature_importance.head(10).to_string(index=False)
)


# ============================================================
# 9. EXPLAINABLE PREDICTION
# ============================================================

def explain_prediction(model, sample, feature_names, target_names):
    """
    Generates an explanation by following the
    decision path of the Decision Tree.
    """

    sample_df = pd.DataFrame([sample], columns=feature_names)

    prediction = model.predict(sample_df)[0]

    probabilities = model.predict_proba(sample_df)[0]

    # Find the nodes used for this prediction
    node_indicator = model.decision_path(sample_df)

    leaf_id = model.apply(sample_df)[0]

    node_indices = node_indicator.indices[
        node_indicator.indptr[0]:
        node_indicator.indptr[1]
    ]

    print("\n" + "=" * 60)
    print("EXPLAINABLE DIAGNOSIS")
    print("=" * 60)

    print("\nPrediction:", target_names[prediction])

    print("\nPrediction probabilities:")

    for i, probability in enumerate(probabilities):
        print(
            f"{target_names[i]} : {probability * 100:.2f}%"
        )

    print("\nDecision Path:")
    print("-" * 60)

    explanations = []

    for node_id in node_indices:

        # Skip leaf node
        if leaf_id == node_id:
            continue

        feature_index = model.tree_.feature[node_id]
        threshold = model.tree_.threshold[node_id]

        feature_name = feature_names[feature_index]
        feature_value = sample_df.iloc[0, feature_index]

        if feature_value <= threshold:

            explanation = (
                f"{feature_name} = {feature_value:.3f} "
                f"<= threshold {threshold:.3f}"
            )

        else:

            explanation = (
                f"{feature_name} = {feature_value:.3f} "
                f"> threshold {threshold:.3f}"
            )

        explanations.append(explanation)

        print("[OK]", explanation)

    print("-" * 60)

    print("\nFinal Explanation:")

    if prediction == 0:

        print(
            "The model classified this patient as "
            "MALIGNANT because the patient's measured "
            "features followed a decision path associated "
            "with malignant cases."
        )

    else:

        print(
            "The model classified this patient as "
            "BENIGN because the patient's measured "
            "features followed a decision path associated "
            "with benign cases."
        )

    print("\nImportant factors considered:")

    for explanation in explanations[:5]:
        print("•", explanation)

    return prediction, explanations


# ============================================================
# 10. EXPLAIN ONE TEST PATIENT
# ============================================================

sample_index = 0

sample = X_test_scaled.iloc[sample_index].values

actual_class = y_test.iloc[sample_index]

print("\nActual diagnosis:",
      data.target_names[actual_class])

prediction, explanation = explain_prediction(
    model,
    sample,
    X.columns,
    data.target_names
)


# ============================================================
# 11. DISPLAY DECISION TREE
# ============================================================

print("\n" + "=" * 60)
print("GENERATING MODEL ARCHITECTURE")
print("=" * 60)

plt.figure(figsize=(22, 12))

plot_tree(
    model,
    feature_names=X.columns,
    class_names=data.target_names,
    filled=True,
    rounded=True,
    fontsize=7
)

plt.title("Explainable Decision Tree Diagnosis Model")
plt.savefig("decision_tree.png", dpi=200, bbox_inches="tight")
plt.close()
print("\nSaved decision tree to decision_tree.png")


# ============================================================
# 12. SHOW TOP FEATURES GRAPH
# ============================================================

top_features = feature_importance.head(10)

plt.figure(figsize=(10, 6))

feature_colors = plt.cm.viridis(np.linspace(0.25, 0.95, len(top_features)))

plt.barh(
    top_features["Feature"],
    top_features["Importance"],
    color=feature_colors,
    edgecolor="black",
    linewidth=0.8
)

plt.xlabel("Importance")
plt.ylabel("Feature")
plt.title("Top 10 Important Medical Features")

plt.gca().invert_yaxis()

plt.tight_layout()
plt.savefig("top_features.png", dpi=150, bbox_inches="tight")
plt.close()
print("Saved top features chart to top_features.png")


# ============================================================
# 13. SAMPLE PATIENT DIAGNOSIS FUNCTION
# ============================================================

def diagnose_patient(patient_data):
    """
    Predicts and explains the diagnosis
    for a new patient.
    """

    patient_df = pd.DataFrame(
        [patient_data],
        columns=X.columns
    )

    patient_scaled = scaler.transform(patient_df)

    prediction, explanation = explain_prediction(
        model,
        patient_scaled[0],
        X.columns,
        data.target_names
    )

    return data.target_names[prediction]


# ============================================================
# 14. FINISH
# ============================================================

print("\n" + "=" * 60)
print("SYSTEM EXECUTION COMPLETED")
print("=" * 60)

print("\nThe system successfully:")
print("1. Loaded medical dataset")
print("2. Preprocessed the data")
print("3. Trained an AI model")
print("4. Predicted diagnosis")
print("5. Evaluated model performance")
print("6. Generated decision explanations")
print("7. Identified important features")
print("8. Visualized the decision tree")