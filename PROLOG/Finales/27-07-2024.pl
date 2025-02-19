%estaEn(Peli,Personaje)

estaEn(buscandoNemo,nemo).
estaEn(buscandoNemo,dory).
estaEn(quienEnganio,rogerRabbit).
estaEn(quienEnganio,doom).
estaEn(quienEnganio,eddie).
estaEn(naufrago,chuck).

% esAnimado(Personaje)

esAnimado(nemo).
esAnimado(dory).
esAnimado(rogerRabbit).
esAnimado(doom).

aptaParaAmargos(Peli):-
    findall(Pers,(estaEn(Peli,Pers),esAnimado(Pers)),Ps),
    length(Ps, C),
    C = 0. 

seDivierte(Personaje):-
    findall(Animado,(estaEn(Peli1,Personaje),estaEn(Peli2,Animado), Peli1 = Peli2, esAnimado(Animado)),Compas),
    length(Compas,C),
    C >= 1.

%% Arreglo de predicados

aptaParaAmargosM(Peli):-
    estaEn(Peli,_),
    forall(estaEn(Peli,Personaje),not(esAnimado(Personaje))).

seDivierteM(Personaje):-
    estaEn(Peli,Personaje),
    estaEn(Peli,Personaje2),
    esAnimado(Personaje2),
    Personaje \= Personaje2.

/*
1)
a. Una pelo se apta para amargos cuando la peli no tiene personajes animados. Un personaje se divierte cuando comparte pelicula con mas
de un personaje animado. 

b. 

> aptaParaAmargos(naufrago)
true.
> aptaParaAmargos(buscandoNemo)
> false.

> seDivierte(nemo).
true 
> seDivierte(chuck).
false.

c. ?? 

2) El problema que tienen es el mal uso del findall. En aptaParaAmargos/1 se usa para ver si una peli no tiene personajes animados y eso se puede hacer con un forall:

> forall(estaEnPeli(Peli,Personaje),not(esAnimado(Personaje))). 

El forall añade mas declaratividad. Es innecesario el uso del findall. En seDivierte/1 se pregunta si un personaje 
comparte pelicula con más de un personaje animado, usando otra vez mal un findall. Se podría haber hecho con consultas simples como:

estaEnPeli(Peli,Personaje),
estaEnPeli(Peli,Personaje2),
esAnimado(Personaje2),
Personaje \= Personaje2. 

Ya asegurandonos que existe un personaje animado en la pelicula del protagonista saitsfacemos el requerimiento.  


*/

