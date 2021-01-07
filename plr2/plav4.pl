:- use_module(library(clpfd)).

golomb(Size, List) :-
    length(List, Size),

    domain(List, 1, 10000),

    rising(List),
    differentDistances(List),

    sum(List, #=, Sum),

    labeling([minimize(Sum)], List).

rising(List) :-
    length(List, Length),
    Length #< 2.
rising([A, B|T]) :-
    A #< B,
    rising([B|T]).

differentDistances(List) :-
    buildDiffList(List, 2, DiffList),
    all_distinct(DiffList).

buildDiffList(List, Index, []) :-
    length(List, Length),
    Index > Length.
buildDiffList(List, Index, DiffList) :-
    diffForIndex(List, 1, Index, SingleDiff),
    Index1 is Index + 1,
    append(SingleDiff, RestDiff, DiffList),
    buildDiffList(List, Index1, RestDiff).

diffForIndex(_, Index, Index, []).
diffForIndex(List, Starting, Index, Diff) :-
    element(Starting, List, Element),
    element(Index, List, Pre),
    Num #= Pre - Element,
    Diff = [Num | ResDiff],
    Starting1 is Starting+1,
    diffForIndex(List, Starting1, Index, ResDiff).   