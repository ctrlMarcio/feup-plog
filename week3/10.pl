ordered([]).

ordered([_]).

ordered([H|T]) :-
    T = [T1|_],
    H =< T1,
    ordered(T).