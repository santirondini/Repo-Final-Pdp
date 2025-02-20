/*

Introducción a Objetos 

Declaratividad vs Imperatividad 

Tanto funcional como prolog tienen naturaleza declarativa, mientras que imperativo es más común en lenguajes como Java, C, C++, etc.
Para aprender paradgimas declarativos se deja de pensar en:

> orden de ejecución
> producir efecto
> asignación destructiva 

En objetos, un programa va a ser un conjunto de objetos que se envian mensajes para alcanzar un objetivo determinado. 
Un objeto va a ser a su vez un valor que tiene un estado interno y un comportamiento asociado.

Primeros Pasos: Golondrina Pepita

Siempre en objetos se va a trabajar con modelos (simplificación de la realidad). 

> Pepita puede volar y comer
> Nos interesa saber su energia antes y despeus de volar y comer 
> Pepita es un objeto

Mensajes => pepita.volar(2) / pepita.comer(10) / pepita.energia()

Los primeros dos mensajes tienen que producir un efecto y el ultimo es una consulta.

Mensaje vs Método

Mensaje: pepita.volar(2)
Metodo => implementación de ese mensaje: 

method volar(kilometros) {
       ... 
    }

Referencias

Una variable es una referencia a un objeto. Se hace referencia a un objeto a través de una variable.
Pueden existir varias variables que hagan referencia al mismo objeto. 

Estado Interno: Los objetos pueden o no terner estado interno. Significa que puede tener sus referencias 
propias (atributos) mediante las cuales conoce a otros objetos. El estado interno es el conjunto de atributos. 
Los atributos solo pueden ser vistos y modificados por el objeto al que pertenecen. 

La unica forma de comunicarse con un objeto es a través de mensajes. Asi el objeto encaspula su estado interno y
solo puede ser modificado a través de los mensajes que recibe. Los atributos son privados. 

Encapsulamiento: ocultar aquellas cosas que son internas. Otros objetos no necesitan saber como esta implementado 
un objeto, solo necesitan saber como comunicarse con el.

object pepita{
    var energia = 100
    
    method volar(kilometros) {
        energia = energia - 40 - 5*kilometros
    }

    method comer(gramos) {
        energia = energia + 2*gramos
    }

    method energia() {
        return energia
    }
}

En este caso, el estado interno de pepita es la energia. Se declara el atributo y se lo incializa = 100. 

Encapsulamiento con otro objeto: Josefa

object josefa{
    var gramosComidos = 0
    var kilometrosVolados = 0
    const energiaInicial = 80

    methos comer(gramos) {
        gramosComidos = gramosComidos + gramos
    }

    method volar(kilometros) {
        kilometrosVolados = kilometrosVolados + kilometros
    }

    method energia() {
        return energiaInicial + 2*gramosComidos - 3*kilometrosVolados
    }

}

El estado interno es irrelevante para el uso, solo interesa la interfaz. La gracia del encapsulamiento es que
se puede cambiar el estado interno sin que los objetos que lo usan se den cuenta. No nos interesa saber como
josefa vuelva o come, solo nos interesa saber como comunicarnos con ella. No me importa como esta representado
por adentro, solo me importa la interfaz.

Valores dependientes e inependientes:

Los valores que dependen de otros valores se calculan en base a los valores independientes. Estos valores
no deben ser guardados, si no calculados por un metodo. Si me dicen que la velocidad de un gato es igual a 5 + 
la energia / 10, no debo guardar la velocidad, sino calcularla cada vez que la necesite.

object gato{
    var energia = 100

    method velocidad() = return 5 + energia / 10
}


Delegación

Auto-Delegación: Queremos saber como se siente josefa. 

estadoEmocional() -> String 

method estadoEmocional() {
    if(gramosComidos > kilometrosVolados) 
        return "Bonita y gordita"
    if(energiaInicial < self.energia())
        return "Energica"
}

self es una referencia que tienen todos los objetos a si mismos. 

Agregamos un entrenador que puedan entrenar pajaros

object entrenador {
    method entrenar(pajaro){
        pajaro.comer(10)
        pajaro.volar(20)
        if(pajaro.energia() < 20)
            pajaro.comer(10)
        else
            pajaro.comer(2)
        
        }
    }

El entrenador puede entrenar tanto a pepita como a josefa. Son polimorficas porque pueden ser tratadas de la misma
manera.

Objetos Polimorficos: Tanto josefa como pepita entienden los mensjaes comer, volar y energia. No importa que josefa entienda 
estadoEmocional. Para lo que le importa al entrenador, josefa y pepita son polimorficas.  

El paradigma se basa en Encapsulamiento, Delegación y Polimorfismo. 

El metodo para poder consultar el estado interno de un objeto se llama getter.
El metodo para poder modificar el estado interno de un objeto se llama setter.

var property => getter y setter
Ejemplo: 

>>> jerry.velocidad()
1
>>> jerry.velocidad(2)
cambia la velocidad de jerry a 2

method peso(){
    return 10
}

Es lo mismo que poner 

method peso() = 10

El = tiene la misma semantica que en Haskell. Solo para métodos de consulta de una sola línea .
Las llaves se usan para cambiar el estado interno del objeto.

Bloques

Los bloques son objetos que representan algo para hacer. Pueden o no esperar parametros. 

n.times({n => jerry.metodoDeJerry()})

-----------

Clases 

Una clase es un molde para crear objetos. Un objeto es una instancia de una clase. Las
clases definen como se comportan (metodos) y que estado interno tienen (atributos) los objetos. 
Tener la lógica de una clase evita repetirla en objetos independientes.

Instanciación: creación de un objeto a partir de una clase.

var unMorty = new Morty()

El var morty es el Referenciamiento. new Morty() es la Instanciación.

Cada instancia tiene su propio estado interno. Incluso si aputnan a los mismos valores
son objetos distintos (identidad). Nunca dos objetos creados por la misma clase van a 
ser iguales. 

Gargabe Collection: Se encarga de liberar la memoria de los objetos que ya no se usan. Ocurre
cuando un objeto deja de ser referenciado en el sistema. 

Inicialización

Se puede inicializar un objeto con valores por defecto. Ejemplo:

new Morty(energia = 150)
new Morty(energia = 150, fuerza = 10)

--------------

Colecciones

Las colecciones son objetos que contienen otros objetos.

Listas => colecciones ordenadas de objetos. Se puede acceder a los elementos por su posición.
Ejemplo: 

const lista = [1, 2, 3, 4, 5]

La lista es un objeto que tiene una bateria de mensajes:
-- Consultas:
> size()
> head()
> filter(criterio)
> map(transformacion)
> all(criterio)
> any(criterio)
> sum()
> contains(elemento)
-- Mensajes asociados a manipular el estado de la lista:
> add(elemento)
> remove(elemento)
> removeIf(criterio)
etc. 

Ejemplo: lista.filter(criterio) // Es responsabilidad de las listas sus operaciones.

vacas.filter { vaca => vaca.peso() > 100 } // Filtra las vacas que pesan más de 100

Igualdad, Identidad y Mutabilidad

Si creamos dos objetos de una misma clase: 
> const rosita = new Vaca()
> const petunia = new Vaca()

rosita y petunia son iguales pero no son el mismo objeto.
Si creo una lista: 

> const vacas = [rosita, petunia]

Si filtro esta lista:

> const flacas = vacas.filter { vaca => vaca.peso() > 100 }

No se modifica la lista original, se crea una nueva lista con los elementos que cumplen el criterio.

> flacas.remove(petunia)

Se elimina petunia de la lista flacas, pero no de la lista vacas.

> flacas.forEach{ vaca => vaca.ordeñar() } // Busca causar efecto 

Esto si va a afectar a las vacas originales, ya que se esta modificando el estado interno de las vacas.

--------------

Respondabilidades y Errores



*/