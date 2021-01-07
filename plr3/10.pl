:- use_module(library(clpfd)).

sequence(Sequence) :-
    % 1,2,3,4,5 being machines and 6 being start and end node
    length(Sequence, 6),
    domain(Sequence, 1, 6),

    circuit(Sequence),

    element(6, Sequence, OutNone),
    element(1, Sequence, Out1),
    element(2, Sequence, Out2),
    element(3, Sequence, Out3),
    element(4, Sequence, Out4),
    element(5, Sequence, Out5),

    graph_weight(OutNone, [1, 2, 3, 4, 5], [4, 5, 8, 9, 4], WNone),
    graph_weight(Out1, [2, 3, 4, 5, 6], [7, 12, 10, 9, 0], W1),
    graph_weight(Out2, [1, 3, 4, 5, 6], [6, 10, 14, 11, 0], W2),
    graph_weight(Out3, [1, 2, 4, 5, 6], [10, 11, 12, 10, 0], W3),
    graph_weight(Out4, [1, 2, 3, 5, 6], [7, 8, 15, 7, 0], W4),
    graph_weight(Out5, [1, 2, 3, 4, 6], [12, 9, 8, 16, 0], W5),

    Weight #= WNone + W1 + W2 + W3 + W4 + W5,
    labeling([minimize(Weight)], Sequence).

graph_weight(_, [], [], _).
graph_weight(Destination, [DestinationHeader | Destinations], [WeightHeader | Weights], RealWeight) :-
    Destination #= DestinationHeader #=> RealWeight #= WeightHeader,
    graph_weight(Destination, Destinations, Weights, RealWeight).