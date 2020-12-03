:-use_module(library(clpfd)).

sum_product(N1, N2, N3, Min-Max) :-
    domain([N1, N2, N3], Min, Max),

    fd_batch([
        % optimize
        N3 #>= N2,
        N2 #>= N1,

        N1 * N2 * N3 #= N1 + N2 + N3,
    ])

    labeling([], [N1, N2, N3]).