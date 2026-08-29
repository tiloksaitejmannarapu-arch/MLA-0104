/* =====================================================================
   AUTOMOBILE FAULT DIAGNOSIS EXPERT SYSTEM
   knowledge_base.pl

   Core knowledge base: symptoms, production rules, working memory,
   forward chaining engine, backward chaining engine, and an
   explanation facility (why/1).

   Tool  : SWI-Prolog (tested on SWI-Prolog 9.x)
   Run   : ?- consult('knowledge_base.pl').
   ===================================================================== */

:- dynamic(symptom/1).
:- dynamic(known_fault/1).

/* ---------------------------------------------------------------------
   1. DOMAIN VOCABULARY -- 18 recognised symptoms (known_symptom/1)
   --------------------------------------------------------------------- */
known_symptom(slow_crank).
known_symptom(dashboard_dim_lights).
known_symptom(warning_light_battery).
known_symptom(clicking_sound).
known_symptom(engine_wont_start).
known_symptom(rough_idle).
known_symptom(reduced_mileage).
known_symptom(black_smoke_exhaust).
known_symptom(stalling).
known_symptom(engine_noise_ticking).
known_symptom(engine_noise_knocking).
known_symptom(warning_light_oil).
known_symptom(fuel_smell).
known_symptom(abnormal_vibration_idle).
known_symptom(abnormal_vibration_driving).
known_symptom(warning_light_engine).
known_symptom(overheating).
known_symptom(squealing_brakes).

/* ---------------------------------------------------------------------
   2. PRODUCTION RULES : rule(Fault, ConditionList, Advice)
      16 rules covering starting, electrical, ignition, lubrication,
      exhaust, vibration, cooling and braking sub-systems.
   --------------------------------------------------------------------- */
rule(weak_battery,
     [slow_crank, dashboard_dim_lights, warning_light_battery],
     'Battery is weak or discharged. Charge or replace the battery.').

rule(faulty_starter_motor,
     [clicking_sound, engine_wont_start],
     'Starter motor / solenoid fault. Inspect and replace the starter motor.').

rule(faulty_spark_plug,
     [engine_wont_start, rough_idle, reduced_mileage],
     'Spark plug(s) worn or fouled. Inspect and replace spark plugs.').

rule(clogged_air_filter,
     [rough_idle, black_smoke_exhaust, reduced_mileage],
     'Air filter is clogged. Clean or replace the air filter.').

rule(faulty_alternator,
     [dashboard_dim_lights, warning_light_battery, stalling],
     'Alternator is not charging correctly. Test and replace the alternator.').

rule(worn_timing_belt,
     [engine_noise_ticking, engine_wont_start],
     'Timing belt worn or slipping. Inspect and replace the timing belt.').

rule(faulty_ignition_coil,
     [engine_noise_knocking, rough_idle, stalling],
     'Ignition coil misfiring. Test and replace the ignition coil.').

rule(low_engine_oil,
     [warning_light_oil, engine_noise_knocking],
     'Engine oil level is low. Top up / change oil and check for leaks.').

rule(exhaust_leak,
     [engine_noise_knocking, reduced_mileage, fuel_smell],
     'Exhaust manifold or gasket leak. Inspect exhaust system for leaks.').

rule(worn_engine_mounts,
     [abnormal_vibration_idle, engine_noise_knocking],
     'Engine mounts worn or broken. Inspect and replace engine mounts.').

rule(wheel_misalignment,
     [abnormal_vibration_driving],
     'Wheels are misaligned. Perform wheel alignment.').

rule(low_tire_pressure,
     [abnormal_vibration_driving, reduced_mileage],
     'Tire pressure is low. Check and inflate tires to spec.').

rule(faulty_oxygen_sensor,
     [black_smoke_exhaust, reduced_mileage, warning_light_engine],
     'Oxygen sensor faulty, causing poor fuel mixture. Replace O2 sensor.').

rule(radiator_overheating_issue,
     [overheating, warning_light_engine],
     'Cooling system fault (radiator/coolant/thermostat). Inspect cooling system.').

rule(worn_brake_pads,
     [squealing_brakes],
     'Brake pads worn. Inspect and replace brake pads.').

rule(fuel_pump_failure,
     [engine_wont_start, stalling, fuel_smell],
     'Fuel pump failure or fuel leak. Inspect and replace the fuel pump.').

/* ---------------------------------------------------------------------
   3. WORKING MEMORY HELPERS
   --------------------------------------------------------------------- */
add_symptom(S) :-
    known_symptom(S),
    \+ symptom(S),
    assertz(symptom(S)), !.
add_symptom(S) :-
    symptom(S), !.          % already recorded
add_symptom(S) :-
    \+ known_symptom(S),
    format('~w is not a recognised symptom.~n', [S]).

reset_memory :-
    retractall(symptom(_)),
    retractall(known_fault(_)).

all_symptoms_present([]).
all_symptoms_present([S|Rest]) :-
    symptom(S),
    all_symptoms_present(Rest).

/* ---------------------------------------------------------------------
   4. FORWARD CHAINING  (data driven: facts -> rules -> conclusions)
   --------------------------------------------------------------------- */
forward_chain :-
    forward_loop,
    print_faults.

forward_loop :-
    rule(Fault, Conditions, _Advice),
    \+ known_fault(Fault),
    all_symptoms_present(Conditions),
    !,
    assertz(known_fault(Fault)),
    format('Rule fired -> ~w~n', [Fault]),
    forward_loop.
forward_loop.   % stop when no more rules can fire

print_faults :-
    findall(F, known_fault(F), Faults),
    ( Faults == []
    -> format('No fault could be concluded from the given symptoms.~n')
    ;  format('Diagnosed fault(s): ~w~n', [Faults])
    ).

/* ---------------------------------------------------------------------
   5. BACKWARD CHAINING  (goal driven: goal -> conditions -> evidence)
   --------------------------------------------------------------------- */
prove(Goal) :-
    rule(Goal, Conditions, _Advice),
    prove_all(Conditions).

prove_all([]).
prove_all([S|Rest]) :-
    symptom(S),
    prove_all(Rest).

backward_chain(Goal) :-
    ( prove(Goal)
    -> format('GOAL PROVED: ~w~n', [Goal])
    ;  format('GOAL FAILED: insufficient evidence for ~w~n', [Goal])
    ).

/* ---------------------------------------------------------------------
   6. EXPLANATION FACILITY
   --------------------------------------------------------------------- */
why(Goal) :-
    rule(Goal, Conditions, Advice),
    !,
    format('Goal               : ~w~n', [Goal]),
    format('Required conditions: ~w~n', [Conditions]),
    check_each(Conditions),
    ( prove(Goal)
    -> format('Status             : GOAL PROVED~n')
    ;  format('Status             : GOAL FAILED (insufficient evidence)~n')
    ),
    format('Recommended action : ~w~n', [Advice]).
why(Goal) :-
    \+ rule(Goal, _, _),
    format('~w is not a known fault in the knowledge base.~n', [Goal]).

check_each([]).
check_each([S|Rest]) :-
    ( symptom(S)
    -> format('  [OK]      ~w~n', [S])
    ;  format('  [MISSING] ~w~n', [S])
    ),
    check_each(Rest).

/* ---------------------------------------------------------------------
   7. UTILITY: list every rule (used by the interactive console)
   --------------------------------------------------------------------- */
list_all_rules :-
    forall(rule(F, C, _), format('~w :- ~w~n', [F, C])).
