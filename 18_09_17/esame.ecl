:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [matrimonio].

vincolo_capacita(T,_,_):-!.
vincolo_capacita(Index,C,L) :-
occurrences(Index,L,Num),
Num #=< C,
Next_index is Index+1,
vincolo_capacita(Next_index,C,L).

vincolo_conflitti([],_):-!.
vincolo_conflitti([(I1,I2)|T],L):-
    nth1(I1,L,S1),
    nth1(I2,L,S2),
    S1 #\= S2,
    vincolo_conflitti(T,L).

funzione_obiettivo([],_,0):-!.
funzione_obiettivo([(I1,I2)|T],L,Costo):-
    nth1(I1,L,S1),
    nth1(I2,L,S2),
    S1 #= S2 #<=> B,
    funzione_obiettivo(T,L,Costo1),
    Costo #= Costo1 + B.

siedi(L):-
num_invitati(N),
num_tavoli(T),
length(L,N),
L:: 1..T,
capacita(C),
vincolo_capacita(1,C,L),
findall((I1,I2),conflitto(I1,I2),Conflitti),
vincolo_conflitti(Conflitti,L),

findall((I1,I2),conosce(I1,I2),Conoscenze),
funzione_obiettivo(Conoscenze,L,Costo),

X #= -Costo,
minimize(labeling(L),X).