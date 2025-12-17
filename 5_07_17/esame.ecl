:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [pack_inst].

scegli(L) :-

    % ricavo lista acchetti e lista installati
    package(Pacchetti),
    installed(Installati),

    % creo lista decisioni L lunga quanto Pacchetti con dominio 0..1
    length(Pacchetti,N),
    length(L,N),
    L::0..1,

    % vincolo conflitti
    findall((X1,X2), conflict(X1,X2), Conflitti),
    vincolo_conflitti(Conflitti,L),

    % dipendenze
    findall((X1,X2), requires(X1,X2), Dipendenze),
    vincolo_dipendenze(Dipendenze,L),

    % installo il pacchetto richiesto
    findall(X,install(X), Obbligato),
    installa_obbligatori(L,Obbligato),

    % funzione obiettivo
    funzione_obiettivo(L,Installati,Costo),

    %minimize
    minimize(labeling(L),Costo).

funzione_obiettivo([],[],0) :- !.
funzione_obiettivo([H1|T1], [H2|T2], Costo) :-
    H1 #\= H2 #<=> B,
    funzione_obiettivo(T1,T2,Costo1),
    Costo #= Costo1 + B.

installa_obbligatori(_,[]) :- !.
installa_obbligatori(L,[H|T]) :-
    nth1(H,L,S1),
    S1 #= 1,
    installa_obbligatori(L,T).

vincolo_conflitti([],_) :- !.
vincolo_conflitti([(X1,X2)|T], L) :-
    nth1(X1,L,S1),
    nth1(X2,L,S2),
    S1 + S2 #=< 1,
    vincolo_conflitti(T,L).

vincolo_dipendenze([],_) :- !.
vincolo_dipendenze([(X1,X2) | T], L) :-
    nth1(X1,L,S1),
    nth1(X2,L,S2),
    S1 #=< S2,
    vincolo_dipendenze(T,L).