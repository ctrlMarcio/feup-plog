% Element member_of List
:- op(200, xfx, member_of).

X member_of [X].
X member_of [X|_].
X member_of [_|T] :-
    X member_of T.

% concatenate List1 with List2 to List
:- op(200, fx, concatenate).
:- op(150, xfx, to).
:- op(100, xfx, with).

concatenate [] with L to L.
concatenate [H1|T1] with L2 to [H1|T3] :-
    concatenate T1 with L2 to T3.

% delete Element from List to Res
:- op(200, fx, delete).
:- op(100, xfx, from).

delete _ from [] to [].
delete X from [X|T] to Res :-
    !, delete X from T to Res.
delete X from [H1|T1] to [H1|T2] :-
    delete X from T1 to T2.