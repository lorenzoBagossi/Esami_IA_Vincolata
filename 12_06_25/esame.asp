% faccio assegnare un negozio ad un magazzino
1 {assegna(N,M) : magazzino(M,_)} 1 :- negozio(N).

% fallisco se ci sono più di 7 magazzini aperti
:- #count {M : assegna(_,M)} > 7.

% fallisco se un magazzino supera la sua capacità
:- magazzino(M,C), #count {N : assegna(N,M)} > C.

% un supermercato può essere assegnato ad un solo magazzino
:- assegna(N, M1), assegna(N, M2), M1 != M2.

somma(S) :- #sum { D, N, M : distanza(N, M, D), assegna(N, M) } = S.

#minimize{ S : somma(S) }.

#show somma/1.
