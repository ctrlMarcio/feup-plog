:- use_module(library(clpfd)).

jam(Colors) :-
    Yellow is 1, Green is 2, Red is 3, Blue is 4,
    length(Colors, 12),
    global_cardinality(Colors, [Yellow-4, Green-2, Red-3, Blue-3]),

    element(1, Colors, Color1), element(12, Colors, Color1),
    element(2, Colors, Color2), element(11, Colors, Color2),
    element(5, Colors, Blue),
    three_diff(Colors),
    ygrb(Colors, Amount),
    Amount #= 1,

    labeling([], Colors).

three_diff(List) :-
    length(List, L),
    L #< 3.
three_diff([A, B, C|Rest]) :-
    all_distinct([A, B, C]),
    three_diff([B, C | Rest]).

ygrb(List, 0) :-
    length(List, L),
    L #< 4.
ygrb([A, B, C, D|Rest], Amount) :-
    A #= 1 #/\ B #= 2 #/\ C #= 3 #/\ D #= 4 #<=> Oh,
    Amount #= Oh + Amount1,
    ygrb([B, C, D|Rest], Amount1).
