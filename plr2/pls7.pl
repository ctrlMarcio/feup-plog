% SOMETHING IS MISSING HERE AND I DONT WANT TO REDO IT BUT TAKE IN MIND THAT THIS SOLUTION IS INCORRECT

:- use_module(library(clpfd)).

set_prolog_flag(answer_write_options,[max_depth(0)]).

:- op(800, xfx, dislike).
Persons dislike Drinks :-
    dislike_people(Persons, Drinks).

% people are ordered as such
%   1      2     3       4       5        6         7       8      9      10      11        12
% João, Miguel, Nádia, Sílvia, Afonso, Cristina, Geraldo, Júlio, Maria, Máximo, Manuel and Ivone
camping(Drinks) :-
    % one drink per person
    % drinks will be in the same order as the names above
    % each drink as a number associated as such
    %     1       2        3      4        5       6       7       8     9      10      11     12
    % lemonade, guaraná, whisky, wine, champagne, water, orange, coffe, tea, vermouth, beer e vodka
    Lemonade is 1, Guarana is 2, Whisky is 3, Whine is 4, Champagne is 5, Water is 6, Orange is 7, Coffe is 8,
    Tea is 9, Vermouth is 10, Beer is 11, Vodka is 12, % increase readibility

    length(Drinks, 12), 
    domain(Drinks, 1, 12),
    all_distinct(Drinks),

    % get the drink for every person right here tau
    element(1, Drinks, Joao),
    element(2, Drinks, Miguel),
    element(3, Drinks, Nadia),
    element(4, Drinks, Silvia),
    element(5, Drinks, Afonso),
    element(6, Drinks, Cristina),
    element(7, Drinks, Geraldo),
    element(8, Drinks, Julio),
    element(9, Drinks, Maria),
    element(10, Drinks, Maximo),
    element(11, Drinks, Manuel),
    element(12, Drinks, Ivone),

    [Geraldo, Julio, Maria, Maximo, Ivone, Manuel] dislike [Vodka, Beer, Vermouth, Tea, Coffe, Orange],
    [Joao, Miguel, Julio, Geraldo, Nadia, Maria] dislike [Tea, Coffe, Guarana, Whisky, Orange, Lemonade],
    [Geraldo, Maximo, Joao, Silvia] dislike [Water, Whisky, Tea, Vodka],
    % [Julio, Miguel, Maximo, Manuel, Silvia, Afonso] dislike [Champagne, Water, Guarana, Vodka, Coffe],
    [Julio] dislike [Champagne, Water],
    [Miguel] dislike [Guarana, Vodka],
    [Maximo, Manuel] dislike [Guarana],
    [Silvia, Afonso] dislike [Coffe],

    labeling([], Drinks).

dislikes(_, []).
dislikes(Person, [H|T]) :-
    Person #\= H,
    dislikes(Person, T).

dislike_people([], _).
dislike_people([H|T], Drinks) :-
    dislikes(H, Drinks),
    dislike(T, Drinks).