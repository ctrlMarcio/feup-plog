climb(Stairs, Stairs, []).

climb(Stairs, Already, List) :-
    Already < Stairs,
    Already1 is Already + 1,
    climb(Stairs, Already1, Nl),
    List = [1|Nl].

climb(Stairs, Already, List) :-
    Already < Stairs,
    Already2 is Already + 2,
    climb(Stairs, Already2, Nl),
    List = [2|Nl].

stairs(Stairs, N, L) :-
    findall(List, climb(Stairs, 0, List), L),
    length(L, N).