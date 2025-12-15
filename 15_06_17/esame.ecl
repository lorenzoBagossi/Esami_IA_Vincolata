:- lib(fd).
:- lib(listut).
:- [istanza].

csp(L):-
    findall(M,car(M,_),Macchine),
    findall(C,car(_,C),Colori),
    length(Macchine,N),
    length(L,N),
    L :: 1..N,
    alldifferent(L),
    maxd(MaxD),

    cambi(L,Macchine,MaxD),

    calcolo(L,Colori,Costo),
    minimize(labeling(L), Costo).

cambi(_,[],_):-!.
cambi([Hf|Tf],[H|T],MaxD):-
    Hf #=< H+MaxD,
    Hf#>= H-MaxD,
    cambi(Tf,T,MaxD).


calcolo([_],_,0) :- !.
calcolo([H1,H2|T1], Colori, Costo) :-
    element(H1, Colori, Colore1) ,
    element(H2, Colori, Colore2) ,
    Colore1 #\= Colore2 #<=> Bool,
    calcolo([H2|T1], Colori, Costo1),
    Costo #= Costo1 + Bool. 