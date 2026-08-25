# C04-AT1: Explainable Diagnosis System

This project implements an explainable machine learning diagnosis system using the Breast Cancer Wisconsin dataset.

## Overview
The model is trained to classify whether a tumor is malignant or benign using a Decision Tree Classifier. The system also explains its predictions by showing the decision path and the most important medical features considered for the prediction.

## Project Files
- `co4 At1.py` - main Python script for training, evaluation, and explanation
- `requirements.txt` - required Python dependencies
- `confusion_matrix.png` - confusion matrix visualization
- `decision_tree.png` - trained decision tree visualization
- `top_features.png` - top feature importance plot
- `run_output.txt` - sample execution output

## Requirements
Install the dependencies with:

```bash
pip install -r requirements.txt
```

## Run the Project
From the project directory:

```bash
python "co4 At1.py"
```

## Model Information
- Dataset: Breast Cancer Wisconsin (scikit-learn)
- Model: Decision Tree Classifier
- Task: Binary classification
- Evaluation metrics included:
  - Accuracy
  - Precision
  - Recall
  - F1 Score
  - Confusion Matrix
  - Classification Report

## Notes
This project is designed to be explainable and educational, emphasizing how a decision tree makes predictions and which features matter most in the diagnosis.
