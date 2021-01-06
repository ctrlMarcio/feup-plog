:-use_module(library(lists)).

connected(a,b).
connected(f,i).
connected(a,c).
connected(f,j).
connected(b,d).
connected(f,k).
connected(b,e).
connected(g,l).
connected(b,f).
connected(g,m).
connected(c,g).
connected(k,n).
connected(d,h).
connected(l,o).
connected(d,i).
connected(i,f).

depth_first_search(Last, Last, [Last]).
depth_first_search(First, Last, List) :-
    connected(First, Next),
    depth_first_search(Next, Last, RemainList, [First]),
    List = [First | RemainList].

depth_first_search(Last, Last, [Last], _).
depth_first_search(First, Last, List, Elements) :-
    connected(First, Next),
    \+member(Next, Elements),
    NewElements = [Next | Elements],
    depth_first_search(Next, Last, RemainList, NewElements),
    List = [First | RemainList].

/* Didn't finish, code below is copy pasted from the assignment */

membro(X, [X|_]):- !.
membro(X, [_|Y]):- membro(X,Y).
concatena([], L, L).
concatena([X|Y], L, [X|Lista]):- concatena(Y, L, Lista).
inverte([X], [X]).
inverte([X|Y], Lista):- inverte(Y, Lista1), concatena(Lista1, [X], Lista). 

% Acha todos os X onde Y esta satisfeito e retorna numa lista Y
ache_todos(X, Y, Z):- bagof(X, Y, Z), !.
ache_todos(_, _, []).

% Estende a fila ate um filho N1 de N, verificando se N1
% não pertence à fila, prevenindo, assim, ciclos
estende_ate_filho([N|Trajectoria], [N1,N|Trajectoria]):-
    connected(N, N1),
    \+membro(N1, Trajectoria).

% Encontra o caminho Solucao entre No_inicial e No_Meta
breadth_first_search(No_inicial, No_meta, Solucao):-
    largura([[No_inicial]], No_meta, Sol1),
    inverte(Sol1, Solucao).

% Realiza a pesquisa em largura
largura([[No_meta|T]|_],No_meta,[No_meta|T]).
largura([T|Fila],No_meta,Solucao):-
    ache_todos(ExtensaoAteFilho,estende_ate_filho(T,ExtensaoAteFilho),Extensoes),
    concatena(Fila, Extensoes, FilaExtendida),
    largura(FilaExtendida, No_meta, Solucao). 
    