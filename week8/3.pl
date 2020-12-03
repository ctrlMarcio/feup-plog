:-use_module(library(clpfd)).

queens4(Queens) :-
    Queens = [Q1, Q2, Q3, Q4],

    % the result will be numbers between 1 and 16 which are like from the board like extended like horizontally like
    % 4 x 4 = 16
    domain(Queens, 1, 16),

    % faster boy
    fd_batch(
        [Q1 #< Q2,
        Q2 #< Q3,
        Q3 #< Q4]
    ),

    safe(Q1, Q2, 4),
    safe(Q1, Q3, 4),
    safe(Q1, Q4, 4),
    safe(Q2, Q3, 4),
    safe(Q2, Q4, 4),
    safe(Q3, Q4, 4),

    labeling([], Queens).

queens(N, Queens) :-
    % the number of queens be the number of columns
    length(Queens, N),

    % the result will be numbers between 1 and 16 which are like from the board like extended like horizontally like
    % 4 x 4 = 16
    NSquare is N * N,
    domain(Queens, 1, NSquare),

    % faster boy
    cresciendo(Queens),

    all_safe(Queens, N),
    labeling([], Queens).

% checks that a list is sorted
cresciendo([A, B]) :-
    A #< B.
cresciendo([H|[HT|T]]) :-
    H #< HT,
    cresciendo([HT|T]).

% verifies if they're all safe
all_safe([], _).
all_safe([H|T], N) :-
    safe_from(H, T, N),
    all_safe(T, N).

safe_from(_, [], _).
safe_from(Pos1, [H|T], N) :-
    safe(Pos1, H, N),
    safe_from(Pos1, T, N).

% verifies if thats safe between two positions
safe(Pos1, Pos2, N) :-
    (Pos1 - 1) // N #\= (Pos2 - 1) // N,    % horizontal
    (Pos1 - 1) mod N #\= (Pos2 - 1) mod N,  % vertical
    Pos1 mod (N + 1) #\= Pos2 mod (N + 1).  % diagonal right down
    % Pos1 mod (N - 1) #\= Pos2 mod (N - 1).  % diagonal left down % FIXME not working because like think about a 4x4, 9 and 15 can do be together, but this contraint doesnt let them
