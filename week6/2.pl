vowel(a).
vowel(e).
vowel(i).
vowel(o).
vowel(u).

separate([H1|T1], Pred, Res) :-
    sep([H1|T1], Pred, True, False),
    append(True, False, Res).

sep([], _, [], []).

sep([H1|T1], Pred, [H1|T2], False) :-
    Rule =.. [Pred, H1],
    Rule, !,
    sep(T1, Pred, T2, False).

sep([H1|T1], Pred, Res, [H1|T3]) :-
    sep(T1, Pred, Res, T3).
