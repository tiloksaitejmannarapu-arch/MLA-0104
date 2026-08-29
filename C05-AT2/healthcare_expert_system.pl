% Rule-Based Healthcare Diagnostic Expert System
% Educational / preliminary triage demonstration only.
% Implemented for the C05-AT2 Artificial Intelligence and Expert Systems assignment.

:- dynamic patient_symptom/1.

valid_symptom(fever).
valid_symptom(cough).
valid_symptom(breathing_difficulty).
valid_symptom(body_pain).
valid_symptom(fatigue).
valid_symptom(sore_throat).
valid_symptom(headache).
valid_symptom(chills).
valid_symptom(runny_nose).
valid_symptom(nausea).
valid_symptom(loss_of_taste_smell).
valid_symptom(chest_pain).

condition(common_cold, [runny_nose, sore_throat, cough, fatigue]).
condition(influenza_flu, [fever, cough, body_pain, fatigue, headache, chills]).
condition(covid19, [fever, cough, breathing_difficulty, fatigue, loss_of_taste_smell]).
condition(pneumonia, [fever, cough, breathing_difficulty, chest_pain, fatigue]).
condition(bronchitis, [cough, breathing_difficulty, fatigue, chest_pain]).
condition(migraine, [headache, nausea, fatigue]).
condition(malaria, [fever, chills, body_pain, headache, nausea]).
condition(typhoid_fever, [fever, body_pain, fatigue, headache, nausea]).
condition(allergic_rhinitis, [runny_nose, sore_throat, fatigue]).
condition(gastroenteritis, [nausea, body_pain, fatigue, fever]).

severity(covid19, high).
severity(pneumonia, high).
severity(malaria, high).
severity(bronchitis, medium).
severity(typhoid_fever, medium).
severity(influenza_flu, medium).
severity(gastroenteritis, medium).
severity(migraine, low).
severity(common_cold, low).
severity(allergic_rhinitis, low).

has(Symptom) :-
    patient_symptom(Symptom).

matched_symptoms([], [], []).
matched_symptoms([S|Rest], [S|Matched], Missing) :-
    has(S), !,
    matched_symptoms(Rest, Matched, Missing).
matched_symptoms([S|Rest], Matched, [S|Missing]) :-
    matched_symptoms(Rest, Matched, Missing).

match_score(Required, Matched, Missing, Score) :-
    length(Required, Total),
    length(Matched, Count),
    length(Missing, _),
    Total > 0,
    Score is round((Count * 100) / Total).

candidate(Disease, Matched, Missing, Score) :-
    condition(Disease, Required),
    matched_symptoms(Required, Matched, Missing),
    length(Matched, Count),
    Count >= 2,
    match_score(Required, Matched, Missing, Score),
    Score >= 40.

compare_scores(Order, [S1,D1,_,_], [S2,D2,_,_]) :-
    ( S1 > S2 -> Order = (<)
    ; S1 < S2 -> Order = (>)
    ; compare(Order, D1, D2)
    ).

diagnose(Results) :-
    findall([Score,Disease,Matched,Missing],
            candidate(Disease, Matched, Missing, Score),
            Raw),
    predsort(compare_scores, Raw, Results).

red_flag(urgent) :-
    has(fever),
    has(breathing_difficulty),
    has(chest_pain), !.

red_flag(normal).

diagnose_from_list(Symptoms, Results) :-
    retractall(patient_symptom(_)),
    maplist(assert_patient_symptom, Symptoms),
    diagnose(Results),
    retractall(patient_symptom(_)).

assert_patient_symptom(S) :-
    valid_symptom(S),
    assertz(patient_symptom(S)).

print_report(Symptoms) :-
    diagnose_from_list(Symptoms, Results),
    format('Reported symptoms : ~w~n~n', [Symptoms]),
    print_candidates(Results),
    ( memberchk([_,_,_,_], Results) -> true ; true ),
    ( urgent_for(Symptoms) ->
        format('*** URGENT: Refer immediately for emergency evaluation~n')
    ;   true
    ).

urgent_for(Symptoms) :-
    memberchk(fever, Symptoms),
    memberchk(breathing_difficulty, Symptoms),
    memberchk(chest_pain, Symptoms).

print_candidates([]) :-
    format('No candidate cleared the 40% / 2-symptom threshold.~n').
print_candidates([[Score,Disease,Matched,Missing]|Rest]) :-
    severity(Disease, Level),
    format('Condition : ~w~n', [Disease]),
    format('Confidence : ~w%~n', [Score]),
    format('Severity : ~w~n', [Level]),
    format('Matched symptoms : ~w~n', [Matched]),
    format('Missing/absent : ~w~n~n', [Missing]),
    print_candidates(Rest).

start :-
    format('Healthcare Diagnostic Expert System~n'),
    format('Enter symptoms as a Prolog list.~n'),
    format('Example: [fever,cough,fatigue]~n> '),
    read(Symptoms),
    print_report(Symptoms).
