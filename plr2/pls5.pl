:- use_module(library(clpfd)).

cars(First) :-
    % cars = [1st, 2nd, 3rd, 4th]
    
    % 1 - yellow, 2 - green, 3 - blue, 4 - black
    length(Colors, 4),
    domain(Colors, 1, 4),
    all_distinct(Colors),

    % sizes go from 1 to 4
    length(Sizes, 4),
    domain(Sizes, 1, 4),
    all_distinct(Sizes),

    % car right before blue is smaller than the one right after
    element(BlueCarPosition, Colors, 3),
    BeforeBlue #= BlueCarPosition - 1,
    AfterBlue #= BlueCarPosition + 1,
    element(BeforeBlue, Sizes, SizeBeforeBlue),
    element(AfterBlue, Sizes, SizeAfterBlue),
    SizeBeforeBlue #< SizeAfterBlue,
    % the green car is the smallest
    element(GreenCarPosition, Colors, 2),
    element(GreenCarPosition, Sizes, 1),
    % the green car is after the blue car
    GreenCarPosition #> BlueCarPosition,
    % the yellow car is after the black car
    element(YellowCarPosition, Colors, 1),
    element(BlackCarPosition, Colors, 4),
    YellowCarPosition #> BlackCarPosition,

    % gets the answer for the first car
    element(1, Colors, First),
    % yes idc about other colors.
    labeling([], Colors).