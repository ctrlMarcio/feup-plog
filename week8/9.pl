:-use_module(library(clpfd)).

zero_zeros(Vars) :-
    Vars = [X, Y],
    X in 0..1000000000,
    Y in 0..1000000000,

    X mod 10 #\= 0,
    Y mod 10 #\= 0,
    X * Y #= 1000000000,
    
    labeling([], Vars).