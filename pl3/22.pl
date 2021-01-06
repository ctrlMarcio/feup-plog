% complex_solution.
%   yes
% i_dont_care.
%   yes
% is_it_good.
%   no

% only working for positive rotations, coming back later :(

get_first(List, 0, [], List).
get_first([H|T], N, [Hf|Tf], Res) :-
    N > 0,
    Hf = H,
    N1 is N-1,
    get_first(T, N1, Tf, Res).

rotate(List, 0, List).
rotate(List, N, Res) :-
    N > 0,
    get_first(List, N, Removed, PreResult),
    append(PreResult, Removed, Res).
