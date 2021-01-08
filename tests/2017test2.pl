:- use_module(library(clpfd)).

% 4)

sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
    length(Cookings, 3),
    all_distinct(Cookings),

    Eggs in 1..NEggs,

    count_eggs(RecipeEggs, Cookings, Eggs),
    time(RecipeTimes, Cookings, Time),
    Time #< MaxTime,

    labeling([maximize(Eggs)], Cookings).

count_eggs(_, [], 0).
count_eggs(RecipeEggs, [HC|TC], Eggs) :-
    element(HC, RecipeEggs, HEggs),
    Eggs #= HEggs + RestEggs,
    count_eggs(RecipeEggs, TC, RestEggs).

time(_, [], 0).
time(RecipeTimes, [HC|TC], Time) :-
    element(HC, RecipeTimes, HTime),
    Time #= HTime + RestTime,
    time(RecipeTimes, TC, RestTime).

% 5)

cut(Shelves, Boards, SelectedBoards) :-
    length(Shelves, ShelvesAmount),
    length(SelectedBoards, ShelvesAmount),
    
    length(Boards, BoardsAmount),
    domain(SelectedBoards, 1, BoardsAmount),

    shelves_tasks(Shelves, SelectedBoards, Tasks),
    boards_machines(Boards, 1, Machines),

    cumulatives(Tasks, Machines, [bound(upper)]),

    labeling([], SelectedBoards).

shelves_tasks([], [], []).
shelves_tasks([HS|TS], [HB|TB], [task(0, 1, 1, HS, HB)|TT]) :-
    shelves_tasks(TS, TB, TT).

boards_machines([], _, []).
boards_machines([HB|TB], Index, [machine(Index, HB)|TM]) :-
    Index1 is Index+1,
    boards_machines(TB, Index1, TM).