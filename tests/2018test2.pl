:- use_module(library(clpfd)).
:- use_module(library(lists)).

% 3)

prog2(N, M, L1, L2) :-
    length(L1, N),
    N1 is N-1, length(L2, N1),
    all_distinct(L1),
    all_distinct(L2),
    domain(L1, 1, M),
    domain(L2, 1, M),
    check(L1, L2),
    labeling([], L1).

check([_], []).
check([A,B|R], [X|XS]) :-
    A+B #= X,
    check([B|R], XS).

% 4)

gym_pairs(Men, Women, Delta, Pairs) :-
    % it will be assigned a woman to each man, a new list of women, with the men indexes is then built
    length(Women, Length),
    length(NewWomen, Length),
    all_distinct(NewWomen),

    domain(NewWomen, 1, Length),

    height_restriction(Men, Women, NewWomen, Delta),

    labeling([], NewWomen),
    build_pairs(NewWomen, 1, Pairs).

height_restriction(_, [], [], _).
height_restriction(Men, [HWomen|TWomen], [HNewWomen|TNewWomen], Delta) :-
    single_restriction(Men, HWomen, HNewWomen, Delta),
    height_restriction(Men, TWomen, TNewWomen, Delta).

single_restriction(Men, Woman, ManIndex, Delta) :-
    element(ManIndex, Men, Man),
    Man - Woman #> 0 #/\ Man - Woman #< Delta.

build_pairs([], _, []).
build_pairs([H|T], WomanIndex, [H-WomanIndex|TPairs]) :-
    WI1 is WomanIndex + 1,
    build_pairs(T, WI1, TPairs).