:- lib(fd).
:- lib(listut).
:- [pack_inst].

csp(LPacchetti):-
    %creo una lista dei pack
    package(Pino),
    length(Pino,N),
    length(LPacchetti,N),
    LPacchetti:: 0..1,
    % creo una lista di quali pacchetti sono installati e quali no da scorrere insieme a
    % quella dei pack
    installed(Installati),

    findall((PK1,PK2), conflict(PK1,PK2),LConflitti),
    vincolo_conflitti(LConflitti,LPacchetti),

    findall((PK1,PK2), requires(PK1,PK2),LDipendenze),
    vincolo_dipendenze(LDipendenze,LPacchetti),

    findall(ID,install(ID),Pacchi),
    installa_obbligatori(Pacchi,LPacchetti),

    conta_cambiamenti(Installati,LPacchetti,Costo),

    minimize(labeling(LPacchetti),Costo).

conta_cambiamenti([],[],0) :- !.
conta_cambiamenti([H1|T1],[H2|T2],Costo):-
    H1 #\= H2 #<=> B,
    conta_cambiamenti(T1,T2,Costo1),
    Costo #= Costo1 + B.

installa_obbligatori([],_) :- !.
installa_obbligatori([H|T],LPacchetti):-
    nth1(H,LPacchetti,1),
    installa_obbligatori(T,LPacchetti).

vincolo_conflitti([],_):-!.
vincolo_conflitti([(X1,X2)|T],LPacchetti):-
    nth1(X1,LPacchetti,S1),
    nth1(X2,LPacchetti,S2),
    S1 + S2 #=< 1,
    vincolo_conflitti(T,LPacchetti).

vincolo_dipendenze([],_):-!.
vincolo_dipendenze([(X1,X2)|T],LPacchetti):-
    nth1(X1,LPacchetti,S1),
    nth1(X2,LPacchetti,S2),
    S1 #=< S2,
    vincolo_dipendenze(T,LPacchetti).


