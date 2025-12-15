:- lib(fd).
:- lib(listut).
:- [production].

vincoli_precedenza([],_):-!.
vincoli_precedenza([(A,B)|C],Piselli):-
nth1(A,Piselli,Primo),
nth1(B,Piselli,Secondo),
Primo#<Secondo,
vincoli_precedenza(C,Piselli).

function_obbiettente([],_,0):-!.
function_obbiettente([Hitler|Partorito],[Mussolini|Appeso],Costo):-
Mussolini+1#=<Hitler#<=>Testicular,
function_obbiettente(Partorito,Appeso,Torsion),
Costo#= Testicular + Torsion.


incula(Piselli):-
endtime(T),
findall(ID,ordine(ID,_),Num_task_lista_ordini),
findall(Tito,ordine(_,Tito),Deadline),
length(Num_task_lista_ordini,N),
length(Piselli,N),
Piselli::0..T,
alldifferent(Piselli),
findall((F,G), precedenza(F,G),Precedutos),
vincoli_precedenza(Precedutos, Piselli),
function_obbiettente(Deadline,Piselli,Costo),
Mano #= -Costo,
minimize(labeling(Piselli),Mano).
