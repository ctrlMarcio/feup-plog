% a) not sure ..
count([], 0).
count([_|T], N) :-
    N > 0,
    N1 is N-1,
    count(T, N1).

% b)
count_elem(_, [], 0).

count_elem(X, [X|T], N) :-
    N > 0,
    N1 is N-1,
    count_elem(X, T, N1).

count_elem(X, [H|T], N) :-
    N > 0,
    X \= H,
    count_elem(X, T, N).