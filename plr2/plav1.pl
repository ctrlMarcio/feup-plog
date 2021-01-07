:- use_module(library(clpfd)).

magic(Size, Sequence) :-
    length(Sequence, Size),

    Size1 is Size - 1,
    domain(Sequence, 0, Size1),

    lemagic(Sequence, Sequence, 0),

    labeling([], Sequence).

lemagic([], _, _).
lemagic([H|T], Sequence, Number) :-
    happen(Number, Sequence, Res),
    Res #= H,
    Number1 is Number + 1,
    lemagic(T, Sequence, Number1).

happen(_, [], 0).
happen(Number, [H|T], Res) :-
    Number #= H #<=> B,
    Res #= B + Res1,
    happen(Number, T, Res1).