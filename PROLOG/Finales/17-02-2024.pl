/*
Asumiendo que se tiene una base de conocimientos 

tiene(Persona,Cosa).
vale(Cosa,Valor).
*/
tiene(Persona,Cosa).
vale(Cosa,Valor).

valorTotal(Persona,ValorDeTodo):-
    tiene(Persona,_),
    findall(Valor,(tiene(Persona,Cosa),vale(Cosa,Valor)),Valores),
    sum_list(Valores, ValorDeTodo).
    
todoLoQueTieneEsMasValioso1(Persona1,Persona2):-
    forall((valorTotal(Persona1, ValorCosaValiosa),valorTotal(Persona2,OtroValor)), ValorCosaValiosa > OtroValor).

%% ------------------------------

todoLoQueTieneEsMasValioso2(Persona1,Persona2):-
    forall((tiene(Persona1,Cosa), vale(Cosa,ValorCosaValiosa),tiene(Persona2,Cosa2),vale(Cosa2,OtroValor)), ValorCosaValiosa > OtroValor).

%% Para mi es mas correcto el 2

/*

2. 
a) Falso ya que todoLoQueTieneEsMasValioso2 / 2 no es inversible. Debido al forall /2, ya que no estan inicializadas las personas antes. 

b) forall(tiene(Persona,_), not(todoLoQueTieneEsMasValioso(Persona,pedro))).


*/
