unifiable1([], _, []).

unifiable1([H1|T1], Term, Res) :-
    not(H1 = Term), !,
    unifiable1(T1, Term, Res).

unifiable1([H1|T1], Term, [H1|T2]) :-
    unifiable1(T1, Term, T2).
    