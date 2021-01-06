delete_one(X, L1, L2) :-
    append(F, [X|T], L1),
    append(F, T, L2).

delete_all(_, [], []).

delete_all(X, [X|T1], L2) :-
    delete_all(X, T1, L2).

delete_all(X, [H1|T1], [H2|T2]) :-
    X \= H1,
    H2 = H1,
    delete_all(X, T1, T2).

delete_all_list([], L1, L1).

delete_all_list([XH|XT], L1, L2) :-
    delete_all(XH, L1, L3),
    delete_all_list(XT, L3, L2).