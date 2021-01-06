:- op(950, fx, if).
:- op(900, xfx, then).
:- op(850, xfx, else).
:- op(800, xfx, :=).

if Op then A else _ :-
    Op, !,
    A.

if Op then _ else B :-
    \+ Op,
    B.

Var := Value :-
    Var = Value.
