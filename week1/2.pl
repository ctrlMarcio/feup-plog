pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

% team name, pilot
team(breitling, lamb).
team(red_bull, besenyei).
team(red_bull, chambliss).
team(mediterranean_racing_team, maclean).
team(cobra, mangold).
team(matador, jones).
team(matador, bonhomme).

% plane, pilot
plane(mx2, lamb).
plane(edge540, besenyei).
plane(edge540, maclean).
plane(edge540, mangolde).
plane(edge540, jones).
plane(edge540, bonhomme).

circuit(istanbul).
circuit(budapest).
circuit(porto).

% circuit, pilot
winner(porto, jones).
winner(budapest, mangold).
winner(istanbul, mangold).

% circuit, nr of gates
gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

team_winner(Race, Team) :-
    winner(Race, Pilot),
    team(Pilot, Team).

% a) | ?- team_winner(porto, X).
% b) | ?- win(porto, X).
% c) | ?- winner(Y, X), winner(Z,X), pilot(X), Y \= Z.
% d) | ?- gates(X, Y), Y > 8.  
% e) | ?- plane(X, Y), X \= edge540.