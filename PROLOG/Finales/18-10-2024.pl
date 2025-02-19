
precio(lata(atun,100,nereida), 70).
precio(lata(atun,200,nereida), 120).
precio(lacteo(laSerenisima,leche), 15).
precio(lacteo(sancor,leche), 22).

cliente(Cliente):-
    compro(Cliente,_).

compro(martina, lata(atun,100,nereida)).
compro(martina, lacteo(sancor,leche)).
compro(aye, lacteo(sancor,leche)).

% 1)

comproMarca(Persona,Marca):-
    cliente(Persona),
    compro(Persona, lata(_,_,Marca)).
comproMarca(Persona,Marca):-
    cliente(Persona),
    compro(Persona,lacteo(Marca,_)).

% 2) 

marcaPopu1(Marca):-
    forall(cliente(Cliente),comproMarca(Cliente,Marca)).

marcaPopu2(Marca):-
    cliente(Cliente),
    forall(cliente(Cliente),comproMarca(Cliente,Marca)).

/*

Mis respuestas: 
 
marcaPopu1: Creo que tiene problemas de inversibilidad debido al forall. Ya que para saber que marcas son populares, habria que primero
establecer cuales son marcas. 

marcaPopu2: El Problema con la segunda es que al poner el predicado cliente(Cliente), no esta quedando ninguna variable libre en el antecedente del forall.

ChatGPT: 

marcaPopu1: Menciona el problema de inversibildiad que tiene el forall/2. Tambien dice que Prolog no tiene ninguna 
forma natural de recorrer todas las marcas dentro de forall/2 porque Marca nunca se genera a partir de hechos de la 
base de conocimientos. Basicamente, Prolog no sabe que valores puede tomar Marca.

marcaPopu2: La variable Cliente queda fija en el predicado cliente(Cliente), esto genera que el forall / 2 solo verifique 
ese cliente pero no todos. 
*/