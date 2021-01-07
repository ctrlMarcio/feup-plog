:- use_module(library(clpfd)).

race(Brands, Nationalities) :-
    % numbers being the indexes

    % 1 - German, 2 - English, 3 - Brazilian, 4 - Spanish, 5 - Italian, 6 - French
    length(Nationalities, 6),
    % 1 - LVC, 2 - SV, 3 - FA
    length(Brands, 6),
    
    % HELPERS
    German is 1, English is 2, Brazilian is 3, Spanish is 4, Italian is 5, French is 6,
    LVC is 1, SV is 2, FA is 3,

    % domain
    domain(Nationalities, 1, 6),
    global_cardinality(Brands, [LVC-2, SV-2, FA-2]),

    % gets the numbers of the nationalities
    element(GermanNo, Nationalities, German),
    element(EnglishNo, Nationalities, English),
    element(BrazilianNo, Nationalities, Brazilian),
    element(SpanishNo, Nationalities, Spanish),
    element(ItalianNo, Nationalities, Italian),
    element(FrenchNo, Nationalities, French),

    % the number 1 and the german are from LVC
    element(1, Brands, LVC), element(GermanNo, Brands, LVC), GermanNo #\= 1,
    % the number 5 and the brazilian are from SV
    element(5, Brands, SV), element(BrazilianNo, Brands, SV), BrazilianNo #\= 5,
    % the spanish and the number 3 are from FA
    element(SpanishNo, Brands, FA), element(3, Brands, FA), SpanishNo #\= 3,
    % spanish is not 2 and 6
    SpanishNo #\= 2, SpanishNo #\= 6,
    % french and italian are not number 3
    FrenchNo #\= 3, ItalianNo #\= 3,
    % the number 2 and the german abandoned
    GermanNo #\= 2, ItalianNo #\= 2,
    % italian is not number 1
    ItalianNo #\= 1, GermanNo #\= 1,

    labeling([], Nationalities).