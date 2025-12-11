giorni(1..30).
opzione(1..4).

1{prenditi_cura(G,O):opzione(O)}1 :- giorni(G).

:- impegno(F,G),prenditi_cura(G,F).
:- #count{G : prenditi_cura(G,1)} > 4.
:- #count{G : prenditi_cura(G,2)} > 6.

:- prenditi_cura(N1,3),prenditi_cura(N2,3), N2-N1 >7.

costo_tata(C) :- #count {G : prenditi_cura(G,4)} = Tata, C = Tata*50.
costo_asilo :- prenditi_cura(G,3).

costo_tot(C):- costo_tata(C), not costo_asilo.
costo_tot(Ctot):- costo_tata(Ctata), costo_asilo, Ctot=Ctata+100.

#minimize{Ctot : costo_tot(Ctot)}.

#show costo_tot/1.
#show prenditi_cura/2.