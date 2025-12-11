{inserito(P)} :- package(P).

:- inserito(P1), conflict(P1,P2), inserito(P2), P1 != P2.

:- inserito(P1), requires(P1,P2), not inserito(P2), P1 != P2.

conta(P) :- package(P), inserito(P), not installed(P).

conta(P) :- package(P), not inserito(P), installed(P).

#minimize{1, P : conta(P)}.

#show conta/1.
#show inserito/1.