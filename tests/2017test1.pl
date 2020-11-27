% assignment

:-dynamic(played/4).

%player(Name, Username, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked).
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% 1)

aLotAchieved(80).

achievedALot(Player) :-
    played(Player, _, _, Percent),
    aLotAchieved(ALot),
    Percent >= ALot.

% 2)

isAgeAppropriate(Name, Game) :-
    player(Name, _, PlayerAge),
    game(Game, _, GameAge),
    PlayerAge >= GameAge.

% 3)

timePlayingGames(_, [], [], 0).
timePlayingGames(Player, [G1|GR], [T1|TR], SumTimes) :-
    played(Player, G1, T1, _),
    timePlayingGames(Player, GR, TR, SumTimesRest),
    SumTimes is SumTimesRest + T1.
timePlayingGames(Player, [_|GR], [0|TR], SumTimes) :-
    timePlayingGames(Player, GR, TR, SumTimes).

% 4)

in(Element, [Element|_]).
in(Element, [_|Rest]) :-
    in(Element, Rest).

gameCategory(Game, Cat) :-
    game(Game, Categories, _),
    in(Cat, Categories).

listGamesOfCategory(Cat) :-
    gameCategory(Game, Cat),
    write(Game), nl,
    fail.
listGamesOfCategory(_Cat).

% 5)

updatePlayer(Player, Game, Hours, Percentage) :-
    played(Player, Game, PastHours, PastPercentage),
    retractall(played(Player, Game, _, _)),

    NewHours is PastHours + Hours,
    NewPercentage is PastPercentage + Percentage,
    asserta(played(Player, Game, NewHours, NewPercentage)).

% 6)

fewHours(Player, Already, Res) :-
    played(Player, Game, Hours, _),
    \+in(Game, Already),
    Hours < 10, !,
    fewHours(Player, [Game | Already], Res).
fewHours(_P, Already, Already).

fewHours(Player, Res) :-
    fewHours(Player, [], Res).

% 7)

ageRange(MinAge, MaxAge, Already, Players) :-
    player(Name, _, Age),
    \+in(Name, Already),
    Age >= MinAge,
    Age =< MaxAge, !,
    ageRange(MinAge, MaxAge, [Name | Already], Players).
ageRange(_Min, _Max, Already, Already).

ageRange(MinAge, MaxAge, Players) :-
    ageRange(MinAge, MaxAge, [], Players).

% 8)

sum([], 0).
sum([H|T], Res) :-
    sum(T, Res1),
    Res is Res1 + H.

ageGame(Age, Game) :-
    player(_, Name, Age),
    played(Name, Game, _, _).

averageAge(Game, AverageAge) :-
    findall(Age, ageGame(Age, Game), Ages),
    sum(Ages, Sum),
    length(Ages, Length),
    AverageAge is Sum / Length.