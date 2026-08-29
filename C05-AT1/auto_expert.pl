/* =====================================================================
   auto_expert.pl
   Four automated demonstration scenarios for the Automobile Fault
   Diagnosis Expert System. Each scenario resets working memory,
   asserts a set of symptoms, then runs forward chaining, a backward
   chaining goal, and prints an explanation trace.

   Run:  ?- consult('knowledge_base.pl'), consult('auto_expert.pl'),
            run_all_demos.
   ===================================================================== */

:- consult(knowledge_base).

run_all_demos :-
    demo_case_1,
    demo_case_2,
    demo_case_3,
    demo_case_4.

banner(Title) :-
    format('~n============================================================~n'),
    format('~w~n', [Title]),
    format('============================================================~n').

/* --------------------------------------------------------------
   CASE 1 : Single-fault forward chaining -> weak_battery
   -------------------------------------------------------------- */
demo_case_1 :-
    banner('TEST CASE 1: Weak Battery (Forward Chaining)'),
    reset_memory,
    maplist(add_symptom, [slow_crank, dashboard_dim_lights, warning_light_battery]),
    format('Symptoms asserted: slow_crank, dashboard_dim_lights, warning_light_battery~n'),
    forward_chain,
    format('~n--- Backward check on weak_battery ---~n'),
    backward_chain(weak_battery).

/* --------------------------------------------------------------
   CASE 2 : Faulty starter motor (both directions agree)
   -------------------------------------------------------------- */
demo_case_2 :-
    banner('TEST CASE 2: Faulty Starter Motor (Forward + Backward)'),
    reset_memory,
    maplist(add_symptom, [clicking_sound, engine_wont_start]),
    format('Symptoms asserted: clicking_sound, engine_wont_start~n'),
    forward_chain,
    format('~n--- Backward check on faulty_starter_motor ---~n'),
    backward_chain(faulty_starter_motor).

/* --------------------------------------------------------------
   CASE 3 : Multiple-fault reasoning
   -------------------------------------------------------------- */
demo_case_3 :-
    banner('TEST CASE 3: Multiple-Fault Diagnosis'),
    reset_memory,
    maplist(add_symptom,
            [abnormal_vibration_idle, engine_noise_knocking, warning_light_oil]),
    format('Symptoms asserted: abnormal_vibration_idle, engine_noise_knocking, warning_light_oil~n'),
    forward_chain,
    format('~n--- Explanation for low_engine_oil ---~n'),
    why(low_engine_oil),
    format('~n--- Explanation for worn_engine_mounts ---~n'),
    why(worn_engine_mounts).

/* --------------------------------------------------------------
   CASE 4 : Forward success + a DIFFERENT backward goal that fails
   (demonstrates controlled negative reasoning)
   -------------------------------------------------------------- */
demo_case_4 :-
    banner('TEST CASE 4: Worn Brake Pads / Insufficient Evidence Check'),
    reset_memory,
    maplist(add_symptom, [squealing_brakes]),
    format('Symptoms asserted: squealing_brakes~n'),
    forward_chain,
    format('~n--- Backward check on an UNRELATED goal: fuel_pump_failure ---~n'),
    why(fuel_pump_failure).
