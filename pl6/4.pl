functor2(Term, F, Arity) :-
    Term =.. [F | Args],
    length(Args, Arity).

arg2(N, Term, Arg) :-
    Term =.. [_ | Args],
    element(N, Args, Arg).

% gets the N element of a list
element(1, [H|_], H).
element(N, [_|T], Elem) :-
    N > 1,
    N1 is N - 1,
    element(N1, T, Elem).