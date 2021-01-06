reverse([X], [X]).
reverse(L1, L2) :-
    rev_help(L1, [], L2).

rev_help([], L2, L2).
rev_help([H1|T1], LT, L2) :-
    rev_help(T1, [H1|LT], L2).