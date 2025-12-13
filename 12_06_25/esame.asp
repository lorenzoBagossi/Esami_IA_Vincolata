% faccio assegnare un negozio ad un magazzino
1 {assegna(N,M) : magazzino(M,_)} 1 :- negozio(N).

% Un magazzino M è aperto se c'è almeno un negozio N assegnato ad esso
aperto(M) :- assegna(_, M).

% fallisco se ci sono più di 7 magazzini aperti
:- #count {M : aperto(M)} > 7.

% fallisco se un magazzino supera la sua capacità
:- magazzino(M,C), #count {N : assegna(N,M)} > C.

#minimize { D,N,M : assegna(N,M), distanza(N,M,D) }.

#show assegna/2.
#show calcolo/1.

