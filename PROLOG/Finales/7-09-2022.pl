
toma(juan,coca).
toma(juan,vino(malbec,3)).
toma(daiana,cerveza(golden,18,0)).
toma(gisela,cerveza(ipa,52,7)).
toma(gisela,vino(malbec,3)).
toma(edu,cerveza(stout,28,6)).


%% Solución dada por el final

tieneProblemas(Persona):-
    toma(Persona,_), %% agrego para que sea inversible 
    findall(C,(toma(Persona, cerveza(C,_,A)),A > 0), Cs),
    findall(V,toma(Persona, vino(V,_)), Vs),
    findall(T,toma(Persona, T), Ts), %% Esto es la cantidad de bebidas totales que toma 
    length(Cs, CCs),
    length(Vs, CVs),
    length(Ts, CTs),
    CTs is CCs + CVs.

%% Primera mejora sin Polimorfismos 

cantidadDeCervezas(Persona,CantidadDeCervezas):-
    toma(Persona,_), %% agrego para que sea inversible 
    findall(C,(toma(Persona, cerveza(C,_,A)),A > 0), Cervezas),
    length(Cervezas,CantidadDeCervezas).

cantidadDeVinos(Persona,CantidadDeVinos):-
    toma(Persona,_), %% agrego para que sea inversible 
    findall(Vino,toma(Persona,vino(V,_)),Vinos),
    length(Vinos,CantidadDeVinos).

bebidasTotales(Persona,CantidadDeBebidasTotales):-
    toma(Persona,_),
    findall(Bebida,toma(Persona,Bebida),Bebidas),
    length(Bebidas,CantidadDeBebidasTotales).

tieneProblemasMejor(Persona):-
    toma(Persona,_),
    cantidadDeCervezas(Persona,Cervezas),
    cantidadDeVinos(Persona,Vinos),
    bebidasTotales(Persona,Bebidas),
    Bebidas is Cervezas + Vinos.

%% Segunda mejora con polimorfismo 


cantidadDeBebidasPorTipo(Persona,TipoDeBebida,Cantidad):- %% predicado polimorfico. Acepta mas de un tipo de bebida cuando son functores de distinta cantidad de atomos
    toma(Persona,_),
    findall(Bebida,toma(Persona,TipoDeBebida),Bebidas),
    length(Bebidas,Cantidad).
cantidadDeBebidasPorTipo(Persona,cerveza,Cantidad):-
    toma(Persona,_),
    findall(CervezasConAlcohol,(toma(Persona,cerveza(CervezasConAlcohol,_,Porcentaje)),Porcentaje > 0), CervezasAlcoholicas),
    length(CervezasAlcoholicas,Cantidad).


tieneProblemasMejorado(Persona):-
    toma(Persona,_),
    cantidadDeBebidasPorTipo(Persona,cerveza, Cervezas),
    cantidadDeBebidasPorTipo(Persona,vino(_,_),Vinos),
    cantidadDeBebidasPorTipo(Persona,_,Totales),
    Totales is Cervezas + Vinos. 

/*

1) El objetivo del predicado tieneProblemas/1 es identificar que persona consume unicamente bebidas alcoholicas, esto con ayuda del calculo:
Cantidad de Bebidas Totales = Cantidad De Cervezas + Cantidad De Vinos
Si la persona no toma otro tipo de bebida (por ejemplo coca) entonces tiene probleamas. 

? - tieneProblemas(juan).
false.

Esto porque la cantidad de bebidas que toma juan es 2 (coca y vino) y la cantidad de vinos es 1. 2 /= 1. 

2) 
a - Verdadero. No es inversible ya que el findall tiene problemas de inversibilidad. Para que lo sea, deberiamos primero
aseguranos que la variable libre Persona exista en la BdC: 
toma(Persona,_),
findal.....

b - Verdadero. Es declarativa ya que describe en terminos de relaciones lógicas la forma de obtener si una persona tiene 
problemas, sin especificar como calcularlas paso a paso. Además aprovecha mecanismos propios de prolog como la unificación y la busqueda 
implicita

c - Verdadero. Se puede mejorar usando polimorfismo, teniendo un predicado que relacione una persona, con un tipo de bebida especifica
y la cantidad de bebidas que tiene esa persona. 

*/