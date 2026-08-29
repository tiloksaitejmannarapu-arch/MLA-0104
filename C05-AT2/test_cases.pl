% Test cases for the healthcare expert system.
:- [../prolog/healthcare_expert_system].

run_tests :-
    test_case(1, [fever,cough,breathing_difficulty,fatigue,loss_of_taste_smell]),
    test_case(2, [runny_nose,sore_throat,cough,fatigue]),
    test_case(3, [fever,chills,body_pain,headache,nausea]),
    test_case(4, [fever,cough,breathing_difficulty,chest_pain,fatigue]),
    test_case(5, [headache,nausea,fatigue]).

test_case(Number, Symptoms) :-
    format('~n===== Test Case ~w =====~n', [Number]),
    diagnose_from_list(Symptoms, Results),
    format('Input: ~w~n', [Symptoms]),
    ( Results = [[Score,Disease,_,_]|_] ->
        format('Top diagnosis: ~w (~w%)~n', [Disease, Score])
    ;   format('No diagnosis met the threshold.~n')
    ),
    ( urgent_for(Symptoms) ->
        format('Safety flag: URGENT referral~n')
    ;   format('Safety flag: none~n')
    ).

:- initialization(run_tests, main).
