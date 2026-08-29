# Automobile Fault Diagnosis — Rule-Based Expert System

A production-rule expert system, implemented in **SWI-Prolog**, that identifies
probable vehicle faults from observed symptoms (engine noise, starting failure,
warning indicators, abnormal vibration, reduced mileage, etc.) and demonstrates
both **forward chaining** and **backward chaining** over the same knowledge base.

> Course: MLA0195 / MLA0104 — Artificial Intelligence and Expert Systems
> Assessment: CO5 – AT1 Expert System Development Project
> Scenario: Automobile Fault Diagnosis System

## 1. Project Structure

```
C05-AT1/
├── knowledge_base.pl              # symptoms, 16 production rules, forward/backward engine, why/1
├── auto_expert.pl                 # 4 automated demonstration scenarios
├── auto_expert_interactive.pl     # user-facing yes/no console + goal verification
├── procedural_equivalent.py       # imperative (Python) contrast for Stage 7
├── test_run_log.txt               # actual recorded execution output
├── README.md                      # this file
├── Automobile_Fault_Diagnosis_Report.docx   # full project report
└── diagrams/
    ├── architecture.png
    ├── forward_chaining.png
    ├── backward_chaining.png
    └── interactive_demo.png
```

## 2. Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) 9.x (`swi-prolog` or `swi-prolog-nox` package)
- Python 3.8+ (only for the procedural contrast script — no external packages required)

## 3. How to Run

### 3.1 Automated demonstration (recommended first run)

```bash
swipl -q -g "consult('knowledge_base.pl'), consult('auto_expert.pl'), run_all_demos, halt."
```

This executes four test cases covering: a single-fault diagnosis, a
forward+backward agreement case, a multiple-fault case, and a controlled
"insufficient evidence" backward-chaining failure.

### 3.2 Interactive consultation

```bash
swipl
?- consult('knowledge_base.pl'), consult('auto_expert_interactive.pl').
?- start_consultation.
```

Answer each `yes.` / `no.` prompt (including the trailing full stop, which
Prolog's `read/1` requires). After forward chaining runs, you can type any
fault name to see a full `why/1` explanation trace, or `none.` to exit.

### 3.3 Direct queries

```prolog
?- consult('knowledge_base.pl').
?- reset_memory, add_symptom(clicking_sound), add_symptom(engine_wont_start).
?- forward_chain.
?- backward_chain(faulty_starter_motor).
?- why(faulty_starter_motor).
```

### 3.4 Procedural contrast (Stage 7)

```bash
python3 procedural_equivalent.py
```

Reproduces the same conclusions using explicit imperative set-matching code,
for direct comparison against the declarative Prolog rule base.

## 4. Knowledge Base Summary

- **18 recognised symptoms** (`known_symptom/1`), spanning starting, electrical,
  ignition, lubrication, exhaust, vibration, cooling and braking sub-systems.
- **16 production rules** (`rule(Fault, Conditions, Advice)`), each mapping a
  complete set of symptom conditions to one probable fault and a recommended
  action.
- **Working memory** implemented with dynamic predicates `symptom/1` and
  `known_fault/1`, managed with `assertz/1` and `retractall/1`.

## 5. Inference Engines

| Engine | Direction | Entry point | Mechanism |
|---|---|---|---|
| Forward chaining | Data → Conclusion | `forward_chain/0` | Repeatedly scans `rule/3`, fires any rule whose full condition list is present in working memory, asserts the new fault, repeats until no rule can fire. |
| Backward chaining | Goal → Evidence | `backward_chain/1`, `prove/1` | Given a candidate fault, recursively proves each required condition against `symptom/1` facts via unification and recursion. |
| Explanation | — | `why/1` | Reports the goal, each condition with an `[OK]`/`[MISSING]` marker, the proof status, and the recommended action. |

## 6. Sample Results (see `test_run_log.txt` for the full, actually-executed log)

| Case | Symptoms | Forward Result | Backward Result |
|---|---|---|---|
| 1 | slow_crank, dashboard_dim_lights, warning_light_battery | `weak_battery` | PROVED |
| 2 | clicking_sound, engine_wont_start | `faulty_starter_motor` | PROVED |
| 3 | abnormal_vibration_idle, engine_noise_knocking, warning_light_oil | `low_engine_oil`, `worn_engine_mounts` | BOTH PROVED |
| 4 | squealing_brakes | `worn_brake_pads` | `fuel_pump_failure` goal FAILED (insufficient evidence) |

## 7. Scope and Limitations

This is an educational diagnostic assistant, not a replacement for a qualified
mechanic or physical inspection. The knowledge base is intentionally bounded
(16 rules) for demonstration purposes and does not claim workshop-grade
diagnostic accuracy. See the full report for planned enhancements (confidence
factors, a larger rule set, a GUI/web front end, and regression tests).

## 8. References

1. SWI-Prolog Documentation. https://www.swi-prolog.org/Documentation.html
2. SWI-Prolog Reference Manual — dynamic predicates and runtime clause manipulation.
3. Robert Bosch GmbH, *Automotive Handbook*, 11th Edition, John Wiley & Sons, 2022,
   ISBN 978-1-119-91190-6 (general automotive diagnostic reference).
