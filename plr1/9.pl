:-use_module(library(clpfd)).

zero_zeros(X, Y) :-
    domain([X, Y], 1, 1000000000),

    % limlit repetitions, conheses
    fd_batch([X #> Y, X * Y #= 1000000000]),
    
    doesnt_contain(0, X),
    doesnt_contain(0, Y),
    
    labeling([], [X, Y]).

doesnt_contain(_, 0).
doesnt_contain(Digit, Number) :-
    Number mod 10 #\= Digit,
    NextNumber #= Number // 10,
    doesnt_contain(Digit, NextNumber).