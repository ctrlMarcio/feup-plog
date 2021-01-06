% DIDN'T UNDERSTAND THE ASSIGNMENT THAT WELL ANYWAY HERE'S SOMETHING

% tweety is a bird
species(tweety, bird).
species(goldie, fish).
species(molie, worm).
species(silvester, cat).

% name of my pets
pet(silvester). % useless

% birds like worms
like(bird, worm).
like(cat, fish).
like(cat, bird).
like(me, silvester).
like(silvester, me).

% name of the ones who silvester eats
eats(X, Y) :-
    like(X, Y);
    species(X, Xspecie),
    species(Y, Yspecie),
    like(Xspecie, Yspecie).

% | ?- eats(silvester, Y).