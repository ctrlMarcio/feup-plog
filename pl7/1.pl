knight_jump(X/Y, Xf/Yf) :-
    Xf is X+2,
    Yf is Y+1,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X+2,
    Yf is Y-1,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X+1,
    Yf is Y-2,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X-1,
    Yf is Y-2,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X-2,
    Yf is Y+1,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X-2,
    Yf is Y-1,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X+1,
    Yf is Y+2,
    on_board(Xf/Yf).

knight_jump(X/Y, Xf/Yf) :-
    Xf is X-1,
    Yf is Y+2,
    on_board(Xf/Yf).

on_board(X/Y) :-
    X >= 1,
    X =< 9,
    Y >= 1,
    Y =< 9.

knight_path([]).
knight_path([P1, P2|T]) :-
    knight_jump(P1, P2),
    knight_path([P2|T]).