:- use_module(library(clpfd)).

zebra(Zebra, Water) :-
  % homes will be from 1 to 5 
  Nationalities = [English, Spanish, Norwegian, Ukrainian, Portuguese],
  Colors = [Red, Yellow, Blue, Green, White],
  Animals = [Dog, Fox, Iguana, Horse, Zebra],
  Tobbaco = [Marlboro, Chesterfield, Winston, LukyStrike, SGLights],
  Drinks = [OrangeJuice, Tea, Coffee, Milk, Water],

  append_lists([Nationalities, Colors, Animals, Tobbaco, Drinks], All),
  domain(All, 1, 5),

  % constraints baby
  all_distinct(Nationalities),
  all_distinct(Colors),
  all_distinct(Animals),
  all_distinct(Tobbaco),
  all_distinct(Drinks),

  fd_batch([
    English #= Red,
    Spanish #= Dog,
    Norwegian #= 1,
    Yellow #= Marlboro,
    abs(Fox - Chesterfield) #= 1, % next door
    abs(Blue - Norwegian) #= 1,
    Winston #= Iguana,
    LukyStrike #= OrangeJuice,
    Ukrainian #= Tea,
    Portuguese #= SGLights,
    abs(Horse - Marlboro) #= 1,
    Green #= Coffee,
    Green #= White + 1,
    Milk #= 3
  ]),

  labeling([], All).


% appends a bunch of lists into a single one
append_lists([], []).
append_lists([H|T], Res) :-
    append(H, Next, Res),
    append_lists(T, Next).