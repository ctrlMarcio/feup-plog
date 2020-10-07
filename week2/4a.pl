factorial(0, 1).

factorial(N, V) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, V1),
    V is N * V1.