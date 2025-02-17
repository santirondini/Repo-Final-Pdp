

% Ejemplo de programaEn

programaEn(nahuel, java).
programaEn(maria, c).
programaEn(juan, c).
programaEn(juan, ruby).
programaEn(pedro, javascript).
programaEn(lucia, haskell).
programaEn(martin, haskell).
programaEn(sofia, c).
programaEn(sofia, ruby ).
programaEn(mateo, wollok).
programaEn(caro, c).

% Todos programan en C

programaEn(_,c).

/*
 programaEn / 2  => deja de ser Inversible para persona
 programaEn / 2 es inversible tanto para la persona como para lenguaje. 
 Para poder acotar el universo y que sea inversible, hay que primero corroborar que sea una persona 
*/

programaEn(Persona,c) :-
    persona(Persona).

% Generador
persona(nahuel).
persona(juan).
persona(caro).

sonColegas(Persona1, Persona2) :-
    programaEn(Persona1,Lenguaje),
    programaEn(Persona2,Lenguaje),
    Persona1 \= Persona2.

irremplazable(Persona):-
    programaEn(Persona,Lenguaje),
    not((programaEn(Alguien,Lenguaje),Alguien \= Persona)).

% Lechuzas Mafiosas

% lechuza(Nombre,Sospechosidad,Nobleza)
lechuza(swi,10,60).
lechuza(duo,25,55).
lechuza(swi,60,20).
lechuza(swi,30,80).

% Violencia de una lechuza = 5 * sospechosidad + 42 / nobleza
% Tiene que ser de aridad 2, ya que relaciona una lechuza con su nivel de violencia

violencia(Lechuza,Violencia):-
    lechuza(Lechuza,Sospechosidad,Nobleza),
    Violencia is 5*Sospechosidad + 42 / Nobleza.

% Lechuza es vengativa <=> su violencia es mayor a 100

vengativa(Lechuza):-
    violencia(Lechuza,Violencia),
    Violencia > 100. 

% Lechuza es mafiosa <=> no es buena gente v su sospechosidad es al menor 75. 
% Es buena gente si no es vengativa y su nobleza es mayor a 50

esBuenaGente(Lechuza):-
    lechuza(Lechuza,_,Nobleza),
    not(vengativa(Lechuza)),
    Nobleza > 50.

esMafiosa(Lechuza):-
    lechuza(Lechuza,_,_), %% Sirve para que sea inversible. El not no lo es, entonces primero corroboramos que Lechuza exista 
    not(esBuenaGente(Lechuza)).
esMafiosa(Lechuza):-
    lechuza(Lechuza,Sospechosidad,_),
    Sospechosidad >= 75. 

% findall(Atributo de la BC, Condiciones, Nombre de la lista)
% Sacar la mayor cantidad de calles que pasan por una zona: 
/*

cuantasLineasPasan(Calle, Zona, Cantidad):-
    recorrido(_, Zona, Calle),
    findall(Calle, recorrido(_, Zona, Calle), Calles),
    length(Calles, Cantidad).
    
calleMasTransitada(Calle, Zona):-
    recorrido(_,Zona,Calle),
    cuantasLineasPasan(Calle, Zona, Cantidad),
    forall((recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), (cuantasLineasPasan(OtraCalle, Zona, CantidadMenor), Cantidad > CantidadMenor)).    

*/



