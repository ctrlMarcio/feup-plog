% GIVEN IN THE ASSIGNMENT
bought(joao, honda).
bought(joao, uno).
year(honda, 1997).
year(uno, 1998).
value(honda, 20000).
value(uno, 7000).

can_sell(Person, Car, Current_year) :-
    bought(Person, Car),
    year(Car, Recent),
    Recent > Current_year - 10,
    value(Car, Value),
    Value < 10000.