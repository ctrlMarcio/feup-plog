:- use_module(library(lists)).

solve(Res) :-
    solve(0, 0, [0-0], List),
    reverse(List, Res).

% solution
solve(2, _, States, States).

% empty
solve(L, R, States, Res) :-
    L \= 0,
    \+member(0-R, States),
    solve(0, R, [0-R|States], Res).
solve(L, R, States, Res) :-
    R \= 0,
    \+member(L-0, States),
    solve(L, 0, [L-0|States], Res).

% fulfill
solve(L, R, States, Res) :-
    L \= 4,
    \+member(4-R, States),
    solve(4, R, [4-R|States], Res).
solve(L, R, States, Res) :-
    R \= 3,
    \+member(L-3, States),
    solve(L, 3, [L-3|States], Res).

% transfer
solve(L, R, States, Res) :-
    RemainR is 3 - R,
    L >= RemainR,
    NewL is L - RemainR,
    \+member(NewL-3, States),
    solve(NewL, 3, [NewL-3|States], Res).

solve(L, R, States, Res) :-
    RemainR is 3 - R,
    L < RemainR,
    NewR is R + L,
    \+member(0-NewR, States),
    solve(0, NewR, [0-NewR|States], Res).

solve(L, R, States, Res) :-
    RemainL is 4 - L,
    R >= RemainL,
    NewR is R - RemainL,
    \+member(4-NewR, States),
    solve(4, NewR, [4-NewR|States], Res).

solve(L, R, States, Res) :-
    RemainL is 4 - L,
    R < RemainL,
    NewL is R + L,
    \+member(NewL-0, States),
    solve(NewL, 0, [NewL-0|States], Res).