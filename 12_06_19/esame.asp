% UTILE: posso creare una lista di fatti con operazioni all'interno
deadline(0..E-1):- endtime(E).

% creo una coppia ID,Tempo per ogni fatto ordine che abbia un ID e prende i valori di 
% tempo da deadline
1{assegna(ID,T):deadline(T)}1 :- ordine(ID,_). 

:- assegna(ID1,T1), precedenza(ID1,ID2), assegna(ID2,T2), T2 < T1, ID1 != ID2.

:- assegna(ID1,T), assegna(ID2,T), ID1 != ID2.

% guadagno sugli assegnamenti corretti, quindi il mio predicato guadagno aggiunge elementi
% all'insieme se e solo se ho un guadagno(la sua deadline è rispettata) posso usare T
% o ID purché sia una delle var che io faccio assegnare al solver
guadagno(ID) :- assegna(ID,T), ordine(ID,Deadline), T < Deadline.

% maximize fa in modo che l'insieme di ordini che producono guadagno sia maggiore possibile
#maximize{1,ID: guadagno(ID)}.

#show guadagno/1.
#show assegna/2.