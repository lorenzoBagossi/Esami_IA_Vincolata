:- lib(fd).
:- lib(listut).
:- lib(fd_global).
:- [warehouse_data].

assegna(Negozi) :- 

    % salvo dati
    findall(N, negozio(N), LNegozi),
    findall(M, magazzino(M,_), LMagazzini),
    findall(C, magazzino(_,C), LCapacita),
    findall(D, costo_negozio(_,D), LDistanze),

    % creo lista Negozi per decisioni
    length(LMagazzini, NMag),
    length(LNegozi, L),
    length(Negozi, L),
    Negozi :: 1..NMag,


    % creo lista per tenere traccia se un magazzino è aperto
    length(Magazzini_aperti, NMag),
    Magazzini_aperti :: 0..1,

    % collego magazzini_aperti con Negozi
    popola(Magazzini_aperti, Negozi, 1),

    % non ci devono essere più di 7 magazzini aperti
    sum(Magazzini_aperti) #=< 7,

    % vincolo apacità ciascun magazzino
    vincolo_capacita(Negozi, LCapacita, 1),

    % calcolo funzione obiettivo
    funzione_obiettivo(Negozi, LDistanze, Costo),

    % minimize
    minimize(labeling(Negozi), Costo).

popola(_,_,10) :- !.
popola(Magazzini_aperti, Negozi, Index) :-
    occurrences(Index, Negozi, C),
    C #> 0 #<=> Bool,
    nth1(Index, Magazzini_aperti, Bool),
    Index1 is Index + 1,
    popola(Magazzini_aperti, Negozi, Index1).

vincolo_capacita(_,_,10) :- !.
vincolo_capacita(Negozi, [H|T], Index) :-
    occurrences(Index, Negozi, C),
    C #=< H,
    Index1 is Index + 1,
    vincolo_capacita(Negozi, T, Index1).

funzione_obiettivo([],[],0) :- !.
funzione_obiettivo([H1|T1], [H2|T2], Costo) :- % H2 è a sua volta una lista da scorrere 
    element(H1, H2,Distanza),
    funzione_obiettivo(T1,T2,Costo1),
    Costo #= Distanza + Costo1.