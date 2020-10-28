square(X,Y) :- Y is X*X.

double(X,Y) :- Y is 2*X. 

map([], _, []).
map([H1|T1], Term, [H2|T2]) :-
    Function =.. [Term, H1, H2],
    Function,
    map(T1, Term, T2).
