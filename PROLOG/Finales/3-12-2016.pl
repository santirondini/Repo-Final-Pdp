
% materia (nombre , año de cursada)

materia(troncal(ads),2).
materia(electiva(tadp,5),3).
materia(electiva(rrhh,3),3).
materia(obligatoria(pdep),2).

correlativa(tadp,pdep).
correlativa(NombreElectiva, NombreTroncal):-
    materia(troncal(NombreTroncal), Anio),
    Anio is Anio + 1, %% Esto esta mal. Anio nunca va a ser Anio + 1.
    materia(electiva(NombreElectiva,_), Anio).

/*

1. Esta mal la liena Anio is Anio + 1. Esto siempre va a dar falso. Nunca un numero es igual a sus siguiente. 

*/
% habilitan ( Lista de Materias Aprobadas , Materia que se quiere cursar)
habilitan(NombresMateriasAprobadas, NombreMateria):- 
    forall(correlativa(NombreMateria,NombreAprobada),member(NombreAprobada,NombresMateriasAprobadas)).

/*
2) 
Mis Respuestas: 

a. Falso. No es inversible respecto a su segundo paraemetro. La lista esta y se sabe cuales son los elementos. No se sabe cual es la materia. 

b. Falso. No es inversible a su segundo parametro. Justificado en 2) a. 

c. Verdadero.  // No supe justificar


ChatGPT: 

a) habilitan/2 no es inversible respecto a su primer parámetro.
Falso.

> El primer parámetro (NombresMateriasAprobadas) es una lista de materias aprobadas.

> Como member/2 se usa para verificar la pertenencia de elementos en una lista, el parámetro debe estar instanciado para 
que la consulta funcione correctamente.

> habilitan/2 no puede generar la lista de materias aprobadas que habilitan una 
materia dada, ya que forall/2 solo verifica si los elementos de una lista cumplen una condición, pero no puede inferir la lista desde la materia habilitada.

Mejor justificación: 

Falso. habilitan/2 sí es inversible respecto al primer parámetro, porque forall/2 verifica condiciones dentro de una lista dada. No hay problemas al instanciar
una lista de materias aprobadas y consultar qué materias se pueden cursar con ellas.

b) habilitan/2 es inversible respecto a su segundo parámetro.
Falso.

> El segundo parámetro (NombreMateria) representa la materia que se quiere cursar.

> Para que forall/2 sea verdadero, correlativa/2 debe generar todas las correlativas de NombreMateria.

> Sin embargo, correlativa/2 no está diseñado para generar todas las materias posibles que podrían ser habilitadas por una lista dada de aprobadas.

Mejor justificación: 

Falso. habilitan/2 no es inversible respecto al segundo parámetro porque forall/2 no genera soluciones, solo verifica condiciones. Esto impide que el
predicado produzca materias habilitadas a partir de una lista de aprobadas.


c) habilitan/2 no es inversible respecto a su segundo parámetro y convendría tratar polimórficamente a las materias para generar dicha variable.
Verdadero.

> Como mencionamos en (b), habilitan/2 no puede inferir NombreMateria dada una lista de aprobadas. Esto se debe a que forall/2 
solo verifica condiciones, pero no genera soluciones.

> Para hacer el predicado más declarativo y lograr inversibilidad, convendría reformular habilitan/2 de forma que:
       - Se genere una materia habilitada a partir de las correlativas.
       - Se trate polimórficamente a las materias (troncal/1, electiva/2, obligatoria/1) para que correlativa/2 pueda manejar diferentes estructuras de datos.

*/

