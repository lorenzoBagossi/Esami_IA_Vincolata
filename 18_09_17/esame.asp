invitato(1..20).
tavolo(1..4).

% conflitto(X,Y):- conflitto(Y,X).
% conosce(X,Y):- conosce(Y,X).

1{seduta(I,T):tavolo(T)}1:-invitato(I).


:- seduta(I1,T),conflitto(I1,I2), seduta(I2,T), I1 != I2.
% :- seduta(X,T1),seduta(X,T2), T1!=T2.
:- #count{I:seduta(I,T)}=Num, Num > C, capacita(C), tavolo(T).

count(I1,I2) :- seduta(I1,T),seduta(I2,T),conosce(I1,I2),I1!=I2.
#maximize{1,I1,I2:count(I1,I2)}.

#show count/2.
#show seduta/2.