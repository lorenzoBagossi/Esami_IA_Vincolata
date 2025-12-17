{install(P)} :- package(P).

:- install(P1),conflict(P1,P2),install(P2).

:- install(P1),requires(P1,P2),not install(P2).

conta(P) :- install(P), not installed(P).

conta(P) :- not install(P), installed(P).

#minimize{1,P:conta(P)}.

#show conta/1.
#show install/1.