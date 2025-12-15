tempi(0..E-1) :- endtime(E).

1{trattore(ID,Start): tempi(Start)}1 :- ordine(ID,_).
:- trattore(ID1,Start1), trattore(ID2,Start2), precedenza(ID1,ID2), Start1>Start2.
:- trattore(ID2,Start), trattore(ID1,Start), ID1!=ID2.

soddisfatto(ID):-trattore(ID,Start), ordine(ID,Deadline), Start<Deadline.
#maximize{1,ID: soddisfatto(ID)}.
#show trattore/2.