:-set_prolog_flag(toplevel_print_options, [quoted(true), portrayed(true), max_depth(0)]). % show long lists

:-use_module(library(clpfd)).

% the cells are numered, e.g. starting in the top right one as 1, and going clockwise
% stupid way of doing it, im sure there is a mathematical approach like X / 4 or something, will think about that later (never)
sees(1, [1, 2, 3, 4, 12, 11, 10]).
sees(2, [1, 2, 3, 4]).
sees(3, [1, 2, 3, 4]).
sees(4, [1, 2, 3, 4, 5, 6, 7]).
sees(5, [4, 5, 6, 7]).
sees(6, [4, 5, 6, 7]).
sees(7, [4, 5, 6, 7, 8, 9, 10]).
sees(8, [7, 8, 9, 10]).
sees(9, [7, 8, 9, 10]).
sees(10, [7, 8, 9, 10, 11, 12, 1]).
sees(11, [10, 11, 12, 1]).
sees(12, [10, 11, 12, 1]).

guards(Positions) :-
    Positions = [G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12],

    % domain(Positions, 1, 12), % the domain is already explicited in sees/2

    % this is probably dumb, but it gets the cells that are being watched
    % another implementation would be to store in 12 variables the amount of times a cell is being watched, but well
    % im already halfway wont stop cant stop
    sees(G1, L1),
    sees(G2, L2),
    sees(G3, L3),
    sees(G4, L4),
    sees(G5, L5),
    sees(G6, L6),
    sees(G7, L7),
    sees(G8, L8),
    sees(G9, L9),
    sees(G10, L10),
    sees(G11, L11),
    sees(G12, L12),

    % optimizations (still slowy)
    fd_batch([
        G12 #>= G11,
        G11 #>= G10,
        G10 #>= G9,
        G9 #>= G8,
        G8 #>= G7,
        G7 #>= G6,
        G6 #>= G5,
        G5 #>= G4,
        G4 #>= G3,
        G3 #>= G2,
        G2 #>= G1
    ]),

    % write(Positions), nl, % this is for debug and because its fun watching them go
    append_lists([L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12], Res),

    % verifies if there are 5 guards on each side
    amount(2, Res, Top),
    amount(5, Res, Right),
    amount(8, Res, Bottom),
    amount(11, Res, Left),

    % kk it doesn't say "exactly" 5 guards
    % i like simmetry, yes
    Top     #>= 5,
    Right   #>= 5,
    Bottom  #>= 5,
    Left    #>= 5,

    labeling([], Positions).

% appends a bunch of lists into a single one
append_lists([], []).
append_lists([H|T], Res) :-
    append(H, Next, Res),
    append_lists(T, Next).

% finds the number of occurences of an element in a list
amount(Element, List, Amount) :-
    amount4(Element, List, 0, Amount).

amount4(_, [], Until, Until).
amount4(Element, [Element|T], Until, Amount) :-
    !, Until1 is Until + 1,
    amount4(Element, T, Until1, Amount).
amount4(Element, [_|T], Until, Amount) :-
    amount4(Element, T, Until, Amount).
