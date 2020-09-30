male(aldo_burrous).
male(lincoln_burrous).
male(lj_burrous).
male(michael_scofield).
male(aldo_burrous).

female(christina_rose_scofield).
female(lisa_rix).
female(sara_tancredi).
female(ella_scofield).

% parent, child
parent(aldo_burrous, lincoln_burrous).
parent(christina_rose_scofield, lincoln_burrous).
parent(aldo_burrous, michael_scofield).
parent(christina_rose_scofield, michael_scofield).
parent(lisa_rix, lj_burrous).
parent(lincoln_burrous, lj_burrous).
parent(michael_scofield, ella_scofield).
parent(sara_tancredi, ella_scofield).

% a) | ?- parent(X, michael_scofield).
% b) | ?- parent(aldo_burrous, X).