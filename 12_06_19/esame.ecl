:- lib(fd).
:- lib(listut).
:- [production].

vincoli_precedenza([],_):-!.
vincoli_precedenza([(A,B)|C],L):-
nth1(A,L,Primo),
nth1(B,L,Secondo),
Primo#<Secondo,
vincoli_precedenza(C,L).

function_obbiettente([],_,0):-!.
function_obbiettente([H1|T1],[H2|T2],Costo):-
H2+1#=<H1#<=>Bool,
function_obbiettente(T1,T2,Costo1),
Costo#= Bool + Costo1.


ordine(L):-
endtime(T),
findall(ID,ordine(ID,_),Num_task_lista_ordini),
findall(Orario,ordine(_,Orario),Deadline),
length(Num_task_lista_ordini,N),
length(L,N),
L::0..T,
alldifferent(L),
findall((F,G), precedenza(F,G),Precedenza),
vincoli_precedenza(Precedenza, L),
function_obbiettente(Deadline,L,Costo),
X #= -Costo,
minimize(labeling(L),X).
