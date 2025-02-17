
% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

puedenCombinarse(Linea1,Linea2):-
    recorrido(Linea1,Zona,Calle),
    recorrido(Linea2,Zona,Calle),
    Linea1 \= Linea2.

cruzaGeneralPaz(Linea):-
    recorrido(Linea,gba(_),_),
    recorrido(Linea,caba,_).

nacional(Linea):-
    cruzaGeneralPaz(Linea).

provincial(Linea,Provincia):-
    recorrido(Linea,Provincia,_),
    not(nacional(Linea)).

cuantasCallesPasanPor(Zona, Calle, Cantidad):-
    recorrido(_,Zona,Calle),
    findall(Calle,recorrido(_,Zona,Calle), Calles),
    length(Calles, Cantidad).

pasanAlMenos3(Calle):-
    recorrido(_,_,Calle),
    findall(Lineas,recorrido(Linea,_,Calle),Lineas),
    length(Lineas,Cantidad),
    Cantidad >= 3.

todasNacionales(Calle):-
    recorrido(_,_,Calle),
    findall(Lineas,recorrido(Linea,_,Calle),Lineas),
    forall(member(Linea,Lineas),nacional(Linea)).

trasbordo(Zona,Calle):-
    recorrido(_,Zona,Calle),
    pasanAlMenos3(Calle),
    todasNacionales(Calle).


    





