:- use_module(library(clpfd)).

% musicians = [joao, antonio, francisco]
three_musicians(Instruments) :-
    % harp - 1, violin - 2, piano - 3
    length(Instruments, 3),
    domain(Instruments, 1, 3),
    all_distinct(Instruments),

    % tuesday - 1, thursday - 2
    length(Days, 3),
    domain(Days, 1, 2),

    % antonio is not a pianist
    element(2, Instruments, NotPianist), NotPianist #= 3,
    % pinanist practices alone on tuesdays
    element(Pianist, Days, 1), element(Pianist, Instruments, 3),
    % joao practices with violinist on thursdays
        % joao practices on thursdays
        element(1, Days, 2),
        % joao \= violinist
        element(1, Instruments, NotViolin), NotViolin #\= 2,
        % violinist on thursdays
        element(Violinist, Instruments, 2), element(Violinist, Days, 2),

    labeling([], Instruments).
