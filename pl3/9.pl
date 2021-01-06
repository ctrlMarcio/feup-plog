replace(_, _, [], []).

replace(X, Y, [X|T1], [H2|T2]) :-
    H2 = Y,
    replace(X, Y, T1, T2).

replace(X, Y, [H1|T1], [H2|T2]) :-
    X \= H1,
    H2 = H1,
    replace(X, Y, T1, T2).

has(X, [X|_]).

has(X, [H|T]) :-
    X \= H,
    has(X, T).

delete_duplicates([], []).

delete_duplicates([H1|T1], ResList) :-
    has(H1, T1),
    delete_duplicates(T1, ResList).

delete_duplicates([H1|T1], [H2|T2]) :-
    \+has(H1,T1),
    H2 = H1,
    delete_duplicates(T1, T2).
