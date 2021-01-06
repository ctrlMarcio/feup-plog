% a)
is_member(X, [X|_]).
is_member(X, [Y|T]) :-
    X \= Y,
    member(X, T).

% b)
is_member_append(X, L) :-
    append(_, [X|_], L).

% c)
last(L, X) :-
    append(_, [X], L).

%d)
nth_member(0, [R|_], R).
nth_member(I, [_|T], R) :-
    I > 0,
    I1 is I - 1,
    nth_member(I1, T, R).