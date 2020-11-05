between(N1, N1, [N1]).

between(N1, N2, X) :-
    Np is N1 + 1,
    between(Np, N2, X2), !,
    X = [N1 | X2].