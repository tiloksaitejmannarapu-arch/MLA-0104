% =====================================================================
% Automobile Fault Diagnosis - Prolog Knowledge Base
% CO5 AT3 - Modelling Comparative Analysis Assignment
% =====================================================================

% -------- Facts: observed symptoms per vehicle --------
symptom(v101, low_coolant).
symptom(v101, high_temp_gauge).
symptom(v101, check_engine_lamp).

symptom(v102, weak_battery).
symptom(v102, starter_clicks).

symptom(v103, engine_knock).
symptom(v103, belt_squeal).

symptom(v104, poor_fuel_economy).
symptom(v104, clogged_air_filter).

% -------- Rules: derived conditions --------
overheating(V) :-
    symptom(V, low_coolant),
    symptom(V, high_temp_gauge).

no_start(V) :-
    symptom(V, weak_battery),
    symptom(V, starter_clicks).

abnormal_noise(V) :- symptom(V, engine_knock).
abnormal_noise(V) :- symptom(V, belt_squeal).

low_mileage(V) :-
    symptom(V, poor_fuel_economy),
    symptom(V, clogged_air_filter).

warning_active(V) :- symptom(V, check_engine_lamp).
warning_active(V) :- symptom(V, oil_pressure_lamp).

% -------- Rules: fault derivation --------
cooling_system_fault(V)   :- overheating(V).
starting_system_fault(V)  :- no_start(V).
engine_internal_fault(V)  :- once(abnormal_noise(V)), symptom(V, engine_knock).
fuel_efficiency_fault(V)  :- low_mileage(V).
electronic_control_fault(V) :-
    warning_active(V),
    \+ overheating(V),
    \+ no_start(V).

% -------- Rules: recommended action --------
recommend(V, inspect_radiator_coolant)  :- cooling_system_fault(V).
recommend(V, inspect_battery_starter)   :- starting_system_fault(V).
recommend(V, inspect_engine_internals)  :- engine_internal_fault(V).
recommend(V, replace_filter_service_fuel_system) :- fuel_efficiency_fault(V).
recommend(V, run_obd_scan) :- electronic_control_fault(V).

% -------- Top-level diagnosis predicate --------
diagnose(V, Fault, Recommendation) :-
    (   cooling_system_fault(V)      -> Fault = cooling_system_fault
    ;   starting_system_fault(V)     -> Fault = starting_system_fault
    ;   engine_internal_fault(V)     -> Fault = engine_internal_fault
    ;   fuel_efficiency_fault(V)     -> Fault = fuel_efficiency_fault
    ;   electronic_control_fault(V)  -> Fault = electronic_control_fault
    ;   Fault = no_fault_detected
    ),
    (   Fault == no_fault_detected -> Recommendation = none
    ;   recommend(V, Recommendation)
    ).

% -------- Sample queries (run in SWI-Prolog) --------
% ?- cooling_system_fault(v101).
% ?- diagnose(v101, Fault, Rec).
% ?- diagnose(v102, Fault, Rec).
% ?- diagnose(v103, Fault, Rec).
% ?- diagnose(v104, Fault, Rec).
% ?- findall(V-F, (member(V,[v101,v102,v103,v104]), diagnose(V,F,_)), Results).
