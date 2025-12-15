%posizione(X):- car(X,_).

1 {ordine(Nuova,Vecchia,Colore) : car(Nuova,_)} 1 :- car(Vecchia,Colore).

%fallisco se mi sposto più di Maxd
:- ordine(Nuova,Vecchia,_), maxd(E), |Nuova - Vecchia| > E.


% fallico se due auto da posizioni diverse finiscono nella stessa
:- ordine(Nuova,Vecchia1,_),ordine(Nuova,Vecchia2,_), Vecchia1 != Vecchia2.

% creo fatto conta per ogni volta che ho maccchine vicine con colore divreso (da penalizzare)
conta(S) :- ordine(S,_,Col1), ordine(S+1,_,Col2), Col1 != Col2.

#minimize {1,S : conta(S)}.

#show ordine/3.      
