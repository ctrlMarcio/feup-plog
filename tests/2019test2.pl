:- use_module(library(clpfd)).
:- use_module(library(lists)).

% 6)

prat(Shelves, Objects, Vars) :-
    % gets the number of columns for later
    nth1(1, Shelves, SingleShelf),
    length(SingleShelf, Cols),

    % one var selection per object
    length(Objects, ObjectsAmount),
    length(Vars, ObjectsAmount),

    % the domain of the vars is 1..ShelvesAmount, the index is chosen
    flatten(Shelves, ShelvesList),
    length(ShelvesList, ShelvesAmount),
    domain(Vars, 1, ShelvesAmount),

    % strips the objects
    object_rip(Objects, Weights, Volumes),

    % puts objects into shelves with cumulatives, with objects as tasks and shelves as machines
    objects_tasks(Volumes, Vars, ObjectsTasks),
    shelves_machines(ShelvesList, 1, ShelvesMachines),

    cumulatives(ObjectsTasks, ShelvesMachines, [bound(upper)]),

    % restricts the weight of the one below
    length(ShelvesWeights, ShelvesAmount),
    all_weights(1, Weights, Vars, ShelvesWeights),
    lighter_than_below(ShelvesWeights, Cols),

    % labels :]
    labeling([], Vars).

flatten([], []).
flatten([H|T], List) :-
    flatten(T, Rest),
    append(H, Rest, List).

object_rip([], [], []).
object_rip([W-V|TO], [W|TW], [V|TV]) :-
    object_rip(TO, TW, TV).

objects_tasks([], [], []).
objects_tasks([Weight|TObj], [MachineIndex|TMac], [task(0, 1, 1, Weight, MachineIndex)|TTask]) :-
    objects_tasks(TObj, TMac, TTask).

shelves_machines([], _, []).
shelves_machines([Capacity|TCap], Index, [machine(Index, Capacity)|TMac]) :-
    Index1 is Index + 1,
    shelves_machines(TCap, Index1, TMac).

all_weights(_, _, _, []).
all_weights(ShelfIndex, Weights, Vars, [SWeight|ST]) :-
    shelf_weight(ShelfIndex, Weights, Vars, SWeight),
    SH1 is ShelfIndex + 1,
    all_weights(SH1, Weights, Vars, ST).

shelf_weight(_, [], [], 0).
shelf_weight(Index, [Weight|TW], [Var|TV], SWeight) :-
    Var #= Index #<=> Same,
    SWeight #= Same * Weight + RestWeight,
    shelf_weight(Index, TW, TV, RestWeight).

lighter_than_below(Shelves, Cols) :-
    length(Shelves, Length),
    Length #=< Cols.
lighter_than_below([Weight|T], Cols) :-
    element(Cols, T, WeightBelow),
    WeightBelow #>= Weight,
    lighter_than_below(T, Cols).

% 7)

objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).
homens(4).
tempo_max(60).

furniture :-
    % the name (replaced by number bc clpfd) of the obj are the indexes
    % findall(Amount-Time, objeto(_, Amount, Time), Objects),
    findall(Amount, objeto(_, Amount, _), Amounts),
    findall(Time, objeto(_, _, Time), Times),

    homens(MachineCapacity),
    tempo_max(MaxTime),

    % will find a list of beginnings and ends
    length(Amounts, ObjectsAmount),
    length(Beginnings, ObjectsAmount),
    length(Ends, ObjectsAmount),

    domain(Beginnings, 0, MaxTime),
    domain(Ends, 0, MaxTime),

    % creates the tasks
    furniture_tasks(Amounts, Times, Beginnings, Ends, 1, Tasks),
    % verifies if the max time was reached
    maximum(End, Ends),
    End #=< MaxTime,

    cumulative(Tasks, [limit(MachineCapacity)]),

    labeling([], Beginnings),
    
    write_values(Beginnings, Ends).

furniture_tasks([], [], [], [], _, []).
furniture_tasks([Amount|TA], [Time|TT], [Beginning|TB], [End|TE], Index, [task(Beginning, Time, End, Amount, Index)|TTasks]) :-
    Index1 is Index+1,
    furniture_tasks(TA, TT, TB, TE, Index1, TTasks).

write_values([], []).
write_values([B|TB], [E|TE]) :-
    write(B-E), nl,
    write_values(TB, TE).