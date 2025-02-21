
marca(cindor,laSerenisima).
marca(latuna,nereida).
marca(serenito,laSerenisima).
cliente(Cliente):-
    compro(Cliente,_).

compro(martina,latuna).
compro(martina,cindor).
compro(aye,cindor).
compro(aye,serenito).

obsesivo1(Cliente):-
    cliente(Cliente),
    forall(compro(Cliente,Producto),marca(Producto,Marca)).

obsesivo2(Cliente):-
    marca(_,Marca),
    forall(compro(Cliente,Producto),marca(Producto,Marca)).

obsesivo3(Cliente):-
    marca(Producto,_),
    forall(compro(Cliente,Producto),marca(Producto,Marca)).

obsesivo(Cliente):-
    compro(Cliente,_),
    not(comproMarcasDistintas(Cliente)).

comproMarcasDistintas(Cliente):-
    cliente(Cliente),
    compro(Cliente,Producto1), 
    marca(Producto1,Marca1), 
    compro(Cliente,Producto2),
    marca(Producto2,Marca2), 
    Marca1 \= Marca2.