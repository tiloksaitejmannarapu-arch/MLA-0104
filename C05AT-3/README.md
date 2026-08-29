# CO5 AT3 — Automobile Fault Diagnosis: Modelling Comparative Analysis

Models an automobile service-centre fault-diagnosis problem across four
knowledge-representation paradigms — **production rules**, **propositional
logic**, **first-order logic**, and **Prolog** — and compares them on
expressiveness, inference mechanism, complexity, scalability, and
explainability. Forward and backward chaining are demonstrated over the same
rule base.

## Contents

| File | Description |
|---|---|
| `Automobile_Fault_Diagnosis_Report.docx` | Full report — problem statement, domain knowledge, all four models, forward/backward chaining traces, comparative analysis table + radar chart, results and conclusion. |
| `automobile_fault_diagnosis.pl` | Executable SWI-Prolog knowledge base (facts, rules, `diagnose/3` predicate). |
| `console_transcript.txt` | Real SWI-Prolog console output from running the sample queries in the report. |

## Running the Prolog model

```bash
swipl automobile_fault_diagnosis.pl
?- diagnose(v101, Fault, Rec).
Fault = cooling_system_fault,
Rec = inspect_radiator_coolant.
```

Four sample vehicles (`v101`–`v104`) are pre-loaded as facts, each
triggering a different diagnosed fault:

| Vehicle | Diagnosed Fault | Recommendation |
|---|---|---|
| v101 | cooling_system_fault | inspect_radiator_coolant |
| v102 | starting_system_fault | inspect_battery_starter |
| v103 | engine_internal_fault | inspect_engine_internals |
| v104 | fuel_efficiency_fault | replace_filter_service_fuel_system |

## Recommended model

Prolog — it combines first-order expressiveness (variables, unification,
one rule per fault class rather than one per vehicle) with a native,
executable inference engine, and its default backward-chaining behaviour
matches how a service advisor verifies a suspected fault against the
evidence.
