is_prime(2).

is_prime(N) :-
    N > 2,
    N mod 2 =\= 0,
    not_divisible_by(N, 3).

not_divisible_by(N, X) :-
    X * X > N;
    N mod X =\= 0,
    X1 is X + 2,
    not_divisible_by(N, X1).