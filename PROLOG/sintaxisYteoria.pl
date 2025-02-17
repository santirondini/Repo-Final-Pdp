/*

Introducción a Lógico
 
make. => para cargar el programa

Ejemplo clásico 
1. Socrates es humano
2. Los humanos son mortales
3. Por lo tanto: Sócrates es mortal

En este caso Sócrates es el individuo, 1 y 2 son los conocimientos y 3 es la deducción

Base de conocimiento: programa donde volcamos las ideas que sabemos. Se definen predicados

humano(socrates).

mortal(Alguien):-
    humano(Alguien).


Principio de Universo Cerrado: si algo no se puede inferir como verdadero a partir de la base de conocimientoes, se la considera 
como falso. Ej

? - mortal(platon).
false.

Agregamos a la BC: 

mortal(lassie).

? - mortal(lassie).
true.

? - mortal(_).
true.

? - mortal(Quien) => Variable 
Quien = socrates;
Quien = lassie.

Tipos de consultas:

1) Individual: consulta por alguien en particular
2) Existencial : se pregunta por un conjunto general

INVERSIBILIDAD : capacidad de los predicados de porder pasarles variables y que den respuesta en base a esa variable.
Pasar valores para ver quien podria satifacer la consulta. Ejemplo de preguntar quienes son mortales

Hechos y Reglas

Cada predicado se identifica por su nombre y su aridad
- humano/1
- mortal/1

Hecho: afirmación que no depende de nada. Definción por extensión Ej: mortal(lassie).
Regla: contiene una condición. Definición por comprensión. mortal(Alguien):- humano(Alguien).

Clasulas => definiciones que terminan con punto. Por ejemplo: el predicado mortal/1 tiene dos clausulas, una es un hecho
y la otra es una regla. 

Disyunción: predicados de mismo nombre uno arriba del otro. Si no cumple uno, baja y prueba en el otro.

------------------------------

INVERSIBILIDAD y NEGACIÓN 

Individuos => atomos. Palabras sueltas.

Que un predicado sea inversible significa que los argumentos del mismo pueden usarse tanto de entrada como de salida.

Negacion: not/1 (predicado). Es de orden superior ya que recibe una consulta en vez de orden superior.
Se puede negar consultas individuales o existenciales. No es inversible, no nos va a responder quienes no
cumplen la consulta recibida   

> not(programaEn(nauhuel,ruby))
true. 

El orden importa. Si escribiamos el irremplazable asi 

1)

irremplazable(Persona) :-
    programaEn(Persona,Lenguaje),
    not((Alguien \= Persona , programaEn(Alguien,Lenguaje))).

Si hacemos: 
? - Alguien \= nahuel
false 

El predicado \= no es inversible. Además su valor de verdad es verdadero si ambos terminos no pueden unificarse.
Alguien esta libre, bien podría ser nahuel. Necesito usar el \= sabiendo quien es Alguien y quien es Persona. Ants
de consultar si algo es distinto a algo, hay que primero saber bien quienes son esos algo.

2) 

irremplazable(Persona) :-
    not((Alguien \= Persona , programaEn(Alguien,Lenguaje))),
    programaEn(Persona,Lenguaje).

Cuando consultamos el not, Persona y Lenguaje no estan asociadas a ningun individuo. 
Si preguntamos: 

? - irremplazable(juan).
false. 

El not no liga variables. El Lenguaje se comporta como un _.

Es muy importante agregar el Alguien \= Persona dentro del not. 

Casos de no inversibilidad: 
- Hechos con variables
- Comparación por distinto 
- Negación 

---------------------------

Existencia, No existenia y Para todo 

Usar el not como primer predicado en una consulta, genera que no sea inversible:

predicado(...) :-
    not(...),
    .....

> forall / 2 . Para todo (antecedente), se cumple (consecuente). Si todos los que cumplen con algo, tambien cumplen
con otra cosa. Es de orden superior. Siempre tiene que haber una variable libre, no puede estar ligada de antes. 
Si no hay individuos que cumplan con el antecedente, el forall da true. 
 
Inversibilidad en el para todo: 

Tiene problemsa de inversibilidad cuando hacemos la consulta por consola. Tenemos que 
hacer lo mismo que con el not, primero asegurarnos su existencia en la base de 
conocimientos y despues hacer el forall.

---------------------------

Tipos Compuestos - Polimorfismo 

Ejemplo de los palos en el truco. 

carta => tiene un Numero(1..12 - {8,9}) y un Palo

Functores => individuos con mas de un argumento. Carta va a ser un individuo / 2. Un functor no es un predicado 
Ejemplos:
> carta(3,oro)
> carta(2,copa)

Relacionar Functores:

valeMas(carta(1,espada), carta(1, basto)).
valeMas(carta(1,basto), carta(7, espada)).
valeMas(carta(7,espada), carta(7, oro)).

valeMas(carta(7,oro), carta(3,_)). % el 7 de oro vale más que cualquier carta
valeMas(carta(3,_),carta(2,_)).

falsoAs(carta(1,oro)).
falsoAs(carta(1,copa)).

valeMas(carta(2,_),As):- falsoAs(As).

% Inversibilidad de valeMas/2

% Los hechos con variables son problematicos.
% > valeMas(carta(3,oro), CartaMenor)
% CartaMenor = carta(2, cualquiercosa)

% Hacer que el predicado valeMas/2 sea inversible y transitivo 

cartaDeTruco(carta(Numero,Palo)) :-
    palo(Palo),
    numeroValido(Numero).

palo(basto).
palo(copa).
palo(espada).
palo(oro).

numeroValido(Numero) :-
    between(1,12,Numero),
    not(between(8,9,Numero)).

% Acotamos el universo de las cartas para que pueda ser inversible 

mata(MasValiosa,MenosValiosa):-
    cartaDeTruco(MasValiosa),
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa,MenosValiosa).

Para agregar la transitividad:

mata(MasValiosa,MenosValiosa):-
    cartaDeTruco(MasValiosa),
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa,OtraCarta),  Regla Recursiva 
    mata(OtraCarta,MenosValiosa).

Los dos predicados de mata/2 tienen que ir en el codigo

CASO BASE: 
mata(MasValiosa,MenosValiosa):-
    cartaDeTruco(MasValiosa),
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa,MenosValiosa).

CASO RECURSIVO
mata(MasValiosa,MenosValiosa):-
    cartaDeTruco(MasValiosa),
    cartaDeTruco(MenosValiosa),
    valeMas(MasValiosa,OtraCarta), 
    mata(OtraCarta,MenosValiosa).

Pattern Matching : el vale mas. 



*/
