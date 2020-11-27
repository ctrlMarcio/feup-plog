% assignment

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% 1)

maxTime(120).

madeItThrough(Participant) :-
	performance(Participant, List),
	maxTime(Max),
	oneEqualTo(List, Max).
	
oneEqualTo([N|_], N) :- !.
oneEqualTo([_|T], N) :-
	oneEqualTo(T, N).
	
% 2)

juriTimes([], _, [], 0).
juriTimes([HP|TP], JuriMember, [HT|TT], Total) :-
	performance(HP, Times),
	nth(JuriMember, Times, HT),
	juriTimes(TP, JuriMember, TT, Total1),
	Total is Total1 + HT.
	
nth(1, [H|_], H).	
nth(Index, [_|T], Element) :-
	Index1 is Index - 1,
	nth(Index1, T, Element).
	
% 3)

patientJuri(JuriMember) :-
	performance(X, Lx),
	maxTime(Max),
	nth(JuriMember, Lx, Max),
	performance(Y, Ly),
	X \= Y,
	nth(JuriMember, Ly, Max).
	
% 4)

sumList([], 0).
sumList([H|T], Total) :-
	sumList(T, Total1),
	Total is Total1 + H.

totalPerformance(Id, TotalTime) :-
	performance(Id, List),
	sumList(List, TotalTime).
	
higher(P1-T1, _-T2, P1) :-
	T1 > T2.
	
higher(_-T1, P2-T2, P2) :-
	T2 > T1.
	
bestParticipant(P1, P2, P) :-
	totalPerformance(P1, T1),
	totalPerformance(P2, T2),
	higher(P1-T1, P2-T2, P).
	
% 5)

allPerfs :-
	participant(Id, _, Performance),
	performance(Id, List),
	write(Id), write(':'), write(Performance), write(:), write(List), nl,
	fail.
allPerfs.

% 6)

juries(4).

maxPossibleTime(X) :-
	maxTime(Max), juries(Juries),
	X is Max * Juries.

nSuccessfulParticipants(T) :-
	maxPossibleTime(Max),
	findall(Id, totalPerformance(Id, Max), List),
	length(List, T).
	
% 7)

indexesWhereEqual(List, Value, Indexes) :-
	indexesWhereEqual(List, Value, 1, Indexes).
	
indexesWhereEqual([], _, _, []).
indexesWhereEqual([H|T], H, Starting, [Starting | Indexes1]) :-
	Starting1 is Starting + 1,
	indexesWhereEqual(T, H, Starting1, Indexes1).
indexesWhereEqual([H|T], Value, Starting, Indexes) :-
	H \= Value,
	Starting1 is Starting + 1,
	indexesWhereEqual(T, Value, Starting1, Indexes).

juriesDontClick(Id, Juries) :-
	maxTime(Max),
	performance(Id, Times),
	indexesWhereEqual(Times, Max, Juries).
	
juriFans(L) :-
	findall(Id-Juries, juriesDontClick(Id, Juries), L).
	
% 8)

:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).
	
nextPhase(N, Participants) :-
	findall(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), List),
	sort(List, List1),
	reverse(List1, List2),
	getFirst(List2, N, Participants).

getFirst(_, 0, []).	
getFirst([H|T], N, [H|T1]) :-
	N > 0,
	N1 is N - 1,
	getFirst(T, N1, T1).
	
% 11)

impoe(X, L) :-
    length(Mid, X),
    append(L1,[X|_], L), append(_, [X|Mid], L1).
	
langford(N, L) :-
	N2 is N * 2,
	length(L, N2),
	buildLangford(N, L).
	
buildLangford(0, _).
buildLangford(Left, List) :-
	Left > 0,
	impoe(Left, List),
	Left1 is Left - 1,
	buildLangford(Left1, List).
