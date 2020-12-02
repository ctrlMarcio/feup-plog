:-use_module(library(clpfd)).

turkey(Price) :-
    domain([MSN, LSN], 0, 9),
    Price in 9..134, % 9 = ceil(670/72), 134 = floor(9679/72)

    MSN * 1000 + 670 + LSN #= Price * 72,

    labeling([], [Price, MSN, LSN]).
