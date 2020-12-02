:-use_module(library(clpfd)).

magic_square3(Quad) :-
    Quad = [Q11, Q12, Q13, Q21, Q22, Q23, Q31, Q32, Q33],
    domain(Quad,1,9),
    all_distinct(Quad),

    Q11 + Q12 + Q13 #= Sum,
    Q21 + Q22 + Q23 #= Sum,
    Q31 + Q32 + Q33 #= Sum,
    Q11 + Q21 + Q31 #= Sum,
    Q21 + Q22 + Q23 #= Sum,
    Q31 + Q32 + Q33 #= Sum,
    Q11 + Q22 + Q33 #= Sum,
    Q13 + Q22 + Q31 #= Sum,

    Q1 #< Q2, Q1 #< Q3, Q1 #< Q4, Q2 #< Q4,

    labeling([], Quad).