% assignment

%airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country).
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% 1)

shortFlight(90).

short(Flight) :-
    flight(Flight, _, _, _, Duration, _),
    shortFlight(ShortDuration),
    Duration < ShortDuration.

% 2)

% gets the min atom according to its value
min(Atom1-Value1, _-Value2, Atom1) :- Value1 < Value2.
min(_-Value1, Atom2-Value2, Atom2) :- Value2 < Value1.

shorter(Flight1, Flight2, Res) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    min(Flight1-Duration1, Flight2-Duration2, Res).

% 3)

minToHours(Min, Hours) :-
    H is Min // 60,
    M is Min mod 60,
    Hours is H * 100 + M.

hoursToMin(Hours, Min) :-
    H is Hours // 100,
    M is Hours mod 100,
    Min is H * 60 + M.

arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, Departure, Duration, _),
    hoursToMin(Departure, DepartureMin),
    ArrivalMin is DepartureMin + Duration,
    minToHours(ArrivalMin, ArrivalTime).

% 4)

operatesCountry(Company, Country) :-
    airport(_, ICAO, Country),
    operatesAirport(Company, ICAO).

operatesAirport(Company, ICAO) :-
    flight(_, ICAO, _, _, _, Company).
operatesAirport(Company, ICAO) :-
    flight(_, _, ICAO, _, _, Company).

in(Value, [Value|_]) :- !.
in(Value, [_|T]) :-
    in(Value, T).

countries3(Company, ListUntil, FinalList) :-
    operatesCountry(Company, Country),
    \+in(Country, ListUntil), !,
    countries3(Company, [Country | ListUntil], FinalList).
countries3(_, List, List).

countries(Company, ListOfCountries) :-
    countries3(Company, [], ListOfCountries).

% 5)

minScaleMinutes(30).
maxScaleMinutes(90).

pairableFlights :-
    flight(Id1, _, Destination, _, _, _),
    flight(Id2, Destination, _, DepartureTime2, _, _),
    arrivalTime(Id1, ArrivalTime),
    hoursToMin(ArrivalTime, ArrivalMin),
    hoursToMin(DepartureTime2, DepartureMin),
    Diff is DepartureMin - ArrivalMin,
    minScaleMinutes(MinScale),
    maxScaleMinutes(MaxScale),
    Diff >= MinScale,
    Diff =< MaxScale,
    write(Destination), write(' - '), write(Id1), write(' \\ '), write(Id2), nl,
    fail.
pairableFlights.

% 6)

addMinutes(Hour, Mins, Res) :-
    hoursToMin(Hour, Min1),
    Min2 is Min1 + Mins,
    minToHours(Min2, Res).

countries_flight(Origin, Destination, Flight) :-
    airport(_, OriginICAO, Origin),
    airport(_, DestinationICAO, Destination),
    flight(Flight, OriginICAO, DestinationICAO, _, _, _).

tripDays(Countries, Hour, Hours, Days) :-
    tripDays(Countries, Hour, 1, Hours, Days).

% in case the travel is complete
tripDays([_], _, PastDays, [], PastDays).

% in case everything goes well
tripDays([H|[N|T]], Hour, PastDays, [DepartureTime | NextDepartures], Days) :-
    airport(_, OriginICAO, H),
    airport(_, DestinationICAO, N),
    flight(Flight, OriginICAO, DestinationICAO, DepartureTime, _, _),
    DepartureTime >= Hour, !,

    arrivalTime(Flight, ArrivalTime),
    minScaleMinutes(MinScale),
    addMinutes(ArrivalTime, MinScale, NextDeparture),

    tripDays([N|T], NextDeparture, PastDays, NextDepartures, Days).

% in case there's no other flight in that day
tripDays([H|[N|T]], _, PastDays, [DepartureTime | NextDepartures], Days) :-
    airport(_, OriginICAO, H),
    airport(_, DestinationICAO, N),
    flight(Flight, OriginICAO, DestinationICAO, DepartureTime, _, _),

    arrivalTime(Flight, ArrivalTime),
    minScaleMinutes(MinScale),
    addMinutes(ArrivalTime, MinScale, NextDeparture),

    PastDays1 is PastDays + 1,
    tripDays([N|T], NextDeparture, PastDays1, NextDepartures, Days).

% 7)

:- use_module(library(lists)).

sum([], 0).
sum([H|T], Sum) :-
    sum(T, S1),
    Sum is H + S1.

average(List, Average) :-
    sum(List, Sum),
    length(List, Length),
    Average is Sum / Length.

avgFlightLengthFromAirport(Airport, AvgLength) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _), Durations),
    average(Durations, AvgLength).

% 8)

operatesCountries(Company, Countries) :-
    findall(Country, operatesCountry(Company, Country), CList),
    sort(CList, Countries).

operatesCountriesAmount(Company, Amount) :-
    operatesCountries(Company, List),
    length(List, Amount).

mostValuedEntities([], _, []).
mostValuedEntities([Value-Entity|T], Value, [Entity|TR]) :-
    !, mostValuedEntities(T, Value, TR).
mostValuedEntities(_, _, []).

companies(Companies) :-
    companies([], Companies).

companies(Past, Res) :-
    company(Name, _, _, _),
    \+member(Name, Past), !,
    companies([Name | Past], Res).
companies(Res, Res).

companiesCountriesAmount([], []).
companiesCountriesAmount([H|T], [Value-H|TR]) :-
    operatesCountriesAmount(H, Value),
    companiesCountriesAmount(T, TR).

mostInternational([MaxCompany | Res]) :-
    companies(AllCompanies),
    companiesCountriesAmount(AllCompanies, List),
    sort(List, L1),
    reverse(L1, L2),

    L2 = [Max-MaxCompany|T], % uglier in the reverse tbh
    mostValuedEntities(T, Max, Res).

% 9)

dif_max_2(X, Y) :- X < Y, X >= Y - 2.

make_pairs([], _, []).
make_pairs(List, Predicate, [X-Y|T]) :-
    select(X, List, L1),
    select(Y, L1, L2),
    Rule =.. [Predicate, X, Y], Rule,
    make_pairs(L2, Predicate, T).

% 10)

make_pairs10(List, Predicate, [X-Y|T]) :-
    select(X, List, L1),
    select(Y, L1, L2),
    Rule =.. [Predicate, X, Y], Rule,
    make_pairs10(L2, Predicate, T).
make_pairs10(_, _, []).

% 11)

length_lists([], []).
length_lists([H|T], [Len-H|TR]) :-
    length(H, Len),
    length_lists(T, TR).

make_max_pairs(List, Predicate, Res) :-
    findall(Pairs, make_pairs10(List, Predicate, Pairs), AllCombinations),
    length_lists(AllCombinations, Lengths),
    sort(Lengths, L1),
    reverse(L1, L2),
    L2 = [Max-_|_],
    append(_, [Max-Res|_], L2). % could've get only the first member but it returns all the solutions this way

% 12)

intersects([Row-_|_], Row-_) :- !.
intersects([_-Col|_], _-Col) :- !.
intersects([Rowi-Coli|_], Row-Col) :-
    Same is Row - Rowi,
    Same is Col - Coli, 
    !.
intersects([_|T], Row-Col) :-
    intersects(T, Row-Col).

get_row(Already, Col, Row) :-
    get_row(Already, Col, 1, Row).

get_row(Already, Col, Row, Row) :-
    \+intersects(Already, Row-Col).
get_row(Already, Col, CurrentRow, Row) :-
    CurrentRow < Col,
    Row1 is CurrentRow + 1,
    get_row(Already, Col, Row1, Row).

whitoff(Side, List) :-
    whitoff(Side, [1-1], 2, List).

whitoff(Side, Already, Col, Already) :-
    Col > Side, !.
whitoff(Side, Already, Col, List) :-
    get_row(Already, Col, Row), !,
    Col1 is Col + 1,
    whitoff(Side, [Row-Col|[Col-Row|Already]], Col1, List).
whitoff(Side, Already, Col, List) :-
    Col1 is Col + 1,
    whitoff(Side, Already, Col1, List).