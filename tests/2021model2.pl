:- use_module(library(clpfd)).
:- use_module(library(lists)).

% 3)

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    test(L2),
    labeling([],Is).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    ((X1 #< X2 #/\ X2 #< X3) #\/ (X1 #> X2 #/\ X2 #> X3)),
    test(Xs).

% 4)

build(Budget, NPacks, ObjectCosts, ObjectPacks, Objects, UsedPacks) :-
    length(Objects, 3),
    length(ObjectCosts, Amount),

    domain(Objects, 1, Amount),
    all_distinct(Objects),

    price(ObjectCosts, Objects, Price),
    Price #=< Budget,
    calculate_packs(ObjectPacks, Objects, UsedPacks),
    UsedPacks #=< NPacks,

    labeling([maximize(UsedPacks)], Objects).

price(_, [], 0).
price(Costs, [H|T], Price) :-
    % Objects are the indexes
    element(H, Costs, ObjectPrice),
    Price #= ObjectPrice + RestPrice,
    price(Costs, T, RestPrice).

calculate_packs(_, [], 0).
calculate_packs(Packs, [H|T], UsedPacks) :-
    element(H, Packs, ObjectPacks),
    UsedPacks #= ObjectPacks + RestPacks,
    calculate_packs(Packs, T, RestPacks).

% 5)

corta(Pranchas, Prateleiras, PranchasSelecionadas) :-
    % PranchasSelecionadas is a list of indexes referring to the pranchas
    length(Prateleiras, PrateleirasAmount),
    length(PranchasSelecionadas, PrateleirasAmount),

    length(Pranchas, PranchasAmount),
    domain(PranchasSelecionadas, 1, PranchasAmount),

    tasks(Prateleiras, PranchasSelecionadas, Tasks),
    machines(Pranchas, 1, Machines),

    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([], PranchasSelecionadas).

tasks([], [], []).
tasks([Prateleira1|PrateleiraR], [PS1|PSR], [task(0, 1, 1, Prateleira1, PS1)|Tasks]) :-
    tasks(PrateleiraR, PSR, Tasks).

machines([], _, []).
machines([P1|PR], Index, [machine(Index, P1)|Machines]) :-
    Index1 is Index + 1,
    machines(PR, Index1, Machines).