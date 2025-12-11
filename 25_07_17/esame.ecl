:- lib(fd).
:- lib(fd_global).
:- lib(listut).
:- [impegni].

prenditi_cura(Giorni):-
    length(Giorni,30),
    Giorni::1..4,
    findall(G,impegno(1,G),Impegni_daddy),
    findall(G,impegno(2,G),Impegni_mommy),
    vincolo_impegni_padre(Giorni,Impegni_daddy),
    vincolo_impegni_madre(Giorni,Impegni_mommy),

    [InizioAsilo, FineAsilo] :: 1..30,
    Iscritto_asilo::0..1,
    vincolo_asilo(Giorni,1, InizioAsilo,FineAsilo,Iscritto_asilo),
    
    occurrences(4,Giorni,Tata),
    Costo #= 100*Iscritto_asilo + 50*Tata,
    append(Giorni,[InizioAsilo,FineAsilo], Variabili),
    minimize(labeling(Variabili),Costo).
    

vincolo_asilo([],_,_,_,_):-!.
vincolo_asilo([H|T], N, InizioAsilo,FineAsilo,Iscritto_asilo):-
    FineAsilo - InizioAsilo #=< 7,
    H #=3 #<=> Iscritto_asilo,
    InizioAsilo #=< N #<=> InizioPrimaDiN,
    FineAsilo #>= N #<=> FineDopoDiN,
    Iscritto_asilo#=< InizioPrimaDiN,
    Iscritto_asilo#=< FineDopoDiN,
    N1 is N + 1,
    vincolo_asilo(T, N1, InizioAsilo,FineAsilo,Iscritto_asilo).

vincolo_impegni_padre(_,[]):-!.
vincolo_impegni_padre(Giorni,[H|T]):-
    nth1(H,Giorni,S1),
    S1#\=1,
    occurrences(1,Giorni,P),
    P#=<4,
    vincolo_impegni_padre(Giorni,T).

vincolo_impegni_madre(_,[]):-!.
vincolo_impegni_madre(Giorni,[H|T]):-
    nth1(H,Giorni,S1),
    S1#\=2,
    occurrences(1,Giorni,P),
    P#=<6,
    vincolo_impegni_madre(Giorni,T).