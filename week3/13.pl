% descresing because im lazy
list_until(0, []).
list_until(N, [H|T]) :-
    N > 0,
    H = N,
    N1 is N-1,
    list_until(N1, T).

list_between(Max, Max, [Max]).
list_between(Min, Max, [H|T]) :-
    Min < Max,
    H = Min,
    Min1 is Min + 1,
    list_between(Min1, Max, T).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, NewSum),
    Sum is NewSum + H.

even(N) :-
    (N mod 2) =:= 0.

list_even(0, []).
list_even(N, [H|T]) :-
    N > 0,
    even(N),
    H is N,
    N1 is N - 2,
    list_even(N1, T).

list_even(N, List) :-
    N > 0,
    \+even(N),
    N1 is N-1,
    list_even(N1, List).

list_odd(1, [1]).
list_odd(N, [H|T]) :-
    N > 1,
    \+even(N),
    H is N,
    N1 is N - 2,
    list_odd(N1, T).

list_odd(N, List) :-
    N > 1,
    even(N),
    N1 is N-1,
    list_odd(N1, List).