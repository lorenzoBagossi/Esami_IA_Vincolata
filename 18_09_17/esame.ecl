:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [matrimonio].

vincolo_capacita(T,_,_):-!.
vincolo_capacita(Index,C,Idioti) :-
occurrences(Index,Idioti,Num),
Num #=< C,
Next_index is Index+1,
vincolo_capacita(Next_index,C,Idioti).

vincolo_conflitti([],_):-!.
vincolo_conflitti([(I1,I2)|T],Idioti):-
    nth1(I1,Idioti,S1),
    nth1(I2,Idioti,S2),
    S1 #\= S2,
    vincolo_conflitti(T,Idioti).

funzione_obiettivo([],_,0):-!.
funzione_obiettivo([(I1,I2)|T],Idioti,Costo):-
    nth1(I1,Idioti,S1),
    nth1(I2,Idioti,S2),
    S1 #= S2 #<=> B,
    funzione_obiettivo(T,Idioti,Costo1),
    Costo #= Costo1 + B.

siedi(Idioti):-
num_invitati(N),
num_tavoli(T),
length(Idioti,N),
Idioti:: 1..T,
capacita(C),
vincolo_capacita(1,C,Idioti),
findall((I1,I2),conflitto(I1,I2),Conflitti),
vincolo_conflitti(Conflitti,Idioti),

findall((I1,I2),conosce(I1,I2),Conoscenze),
funzione_obiettivo(Conoscenze,Idioti,Costo),

X #= -Costo,
minimize(labeling(Idioti),X).