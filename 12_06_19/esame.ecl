:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [production].

csp(L):-
    endtime(E),

    findall(ID,ordine(ID,_),ListaOrdini),
    findall(D,ordine(_,D),ListaDeadline),
    length(ListaOrdini, N),
    length(L,N),
    L :: 0..E,

    findall((ID1,ID2),precedenza(ID1,ID2),Precedenze),
    vincolo_precedenza(Precedenze,L),

    funzione_obiettivo(ListaOrdini,ListaDeadline,L,Guadagno),

    X #= -Guadagno,
    minimize(labeling(L),X).
    
funzione_obiettivo([],[],_,0):-!.
funzione_obiettivo([H1|T1],[H2|T2],L,Guadagno):- 
    nth1(H1,L,S1),
    S1 #=< H2 #<=> B,
    funzione_obiettivo(T1,T2,L,Guadagno1),
    Guadagno #= Guadagno1 + B.

vincolo_precedenza([],_):-!.
vincolo_precedenza([(ID1,ID2)|T],L):-
    nth1(ID1,L,S1),
    nth1(ID2,L,S2),
    S1 #< S2,
    vincolo_precedenza(T,L).