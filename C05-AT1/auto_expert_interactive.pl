/* =====================================================================
   auto_expert_interactive.pl
   User-facing yes/no console consultation for the Automobile Fault
   Diagnosis Expert System, plus a goal-verification helper.

   Run:  ?- consult('knowledge_base.pl'), consult('auto_expert_interactive.pl'),
            start_consultation.
   ===================================================================== */

:- consult(knowledge_base).

start_consultation :-
    reset_memory,
    format('~n=== Automobile Fault Diagnosis - Interactive Consultation ===~n'),
    format('Answer each question with yes. or no. (including the full stop)~n~n'),
    findall(S, known_symptom(S), AllSymptoms),
    ask_all(AllSymptoms),
    format('~n--- Running forward chaining on your answers ---~n'),
    forward_chain,
    offer_explanation.

ask_all([]).
ask_all([S|Rest]) :-
    format('Is ~w present? (yes/no): ', [S]),
    read(Answer),
    ( Answer == yes -> assertz(symptom(S)) ; true ),
    ask_all(Rest).

offer_explanation :-
    format('~nType a fault name to see why/why-not it was concluded,~n'),
    format('or type none. to finish: '),
    read(Goal),
    ( Goal == none
    -> format('Consultation ended.~n')
    ;  why(Goal), nl, offer_explanation
    ).

/* --------------------------------------------------------------
   Direct goal-verification helper for the viva / demonstration:
   verify_goal(+FaultName) prints a full backward-chaining trace
   without going through the whole questionnaire.
   -------------------------------------------------------------- */
verify_goal(Fault) :-
    format('~n--- Verifying goal: ~w ---~n', [Fault]),
    why(Fault).
