# Smart Loan Approval using Decision Tree

## Problem
Automatically classify a loan application as Approved or Rejected using customer attributes.

## AI Technique
Decision Tree Classifier. The project compares Gini Index and Information Gain (Entropy).

## Dataset
`loan_approval_dataset.csv` contains 1000 synthetic records generated for academic implementation.

Features:
- Income
- Credit_Score
- Employment_Status
- Loan_Amount
- Repayment_History
- Age

Target:
- Loan_Status

## How to Run
```bash
pip install -r requirements.txt
python smart_loan_approval.py
```

## Results
The script prints Accuracy, Precision, Recall, F1-score and the confusion matrix for both criteria.

Best criterion in this run: **Gini Index**

## Repository Structure
- `smart_loan_approval.py` - main implementation
- `loan_approval_dataset.csv` - dataset
- `requirements.txt` - required Python packages
- `results/` - generated graphs, metrics and confusion matrix
- `Smart_Loan_Approval_Report.docx` - assessment report
