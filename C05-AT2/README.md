# C05-AT2 — Rule-Based Healthcare Diagnostic Expert System

A Prolog-based preliminary symptom-analysis expert system developed for the Artificial Intelligence and Expert Systems C05-AT2 assignment.

## Project Structure

```text
C05-AT2/
├── README.md
├── prolog/
│   └── healthcare_expert_system.pl
├── tests/
│   └── test_cases.pl
└── docs/
    └── project_report.pdf
```

## Features

- Prolog knowledge base of symptoms, conditions and severity.
- Production rules for condition matching.
- Backward-chaining reasoning for individual candidate conditions.
- Forward-chaining-style sweep across the knowledge base using `findall/3`.
- Unification and backtracking.
- Confidence scoring based on matched classic symptoms.
- Threshold pruning: at least 2 matched symptoms and at least 40% confidence.
- Independent urgent-referral safety rule for fever + breathing difficulty + chest pain.
- Interactive `start/0` entry point.
- Batch `diagnose_from_list/2` entry point.

## Requirements

Install SWI-Prolog 9.x.

## Run

Open a terminal in this folder and run:

```text
swipl
```

Then:

```prolog
[prolog/healthcare_expert_system].
diagnose_from_list([fever,cough,breathing_difficulty,fatigue,loss_of_taste_smell], R).
R.
```

For the interactive version:

```prolog
start.
```

## Run Test Cases

From the project root:

```text
swipl tests/test_cases.pl
```

The test file covers the five representative cases documented in the report:

1. COVID-19-like presentation
2. Common cold presentation
3. Malaria-like presentation
4. Pneumonia presentation with urgent referral
5. Migraine presentation

## Important Note

This is an educational/preliminary-triage demonstration. It is not a substitute for professional medical diagnosis or treatment.
