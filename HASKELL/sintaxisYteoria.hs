
{- 

-----------------

type NombreTipo = Tipo

Ejemplos: 

type Nombre = String
type Edad = Int
type Universo = [Personaje]
type Gema = Personaje->Personaje

Puedes ser datos como tambien listas y funciones 

-----------------

Declaraciones de personajes o de estructuras en base al data

ironman :: Personaje
ironman = UnPersonaje 50 10 ["plata"] "tony" "tierra"

hulk :: Personaje
hulk = UnPersonaje 45 50 ["ponerse verde", "crecer 20 metros"] "bruce" "tierra"

spiderman :: Personaje
spiderman = UnPersonaje 20 25 ["sentido aracnido", "inteligencia", "tia may"] "peter" "tierra"

mcu = [ironman, hulk, spiderman] / Lista de personajes

--------------------------

Funciones 

nombreFuncion :: VariableEntrada1 -> VariableEntrada2 -> ... -> VariableSalida
nombreFuncion nombreVariable1 nombreVariable2 ... = Expresion 

--------------------------

Pattern Matching 

f :: Int -> String 
f 0 = "recibi 0"
.
.
.
f _ = "recibi otra cosa" 

Siempre se pone ultima la opción con el guion bajo. Las variables comunes tambien son patrones

f :: Int -> Int 
f 0 = 1
f n = n*2

----------------------------

Guardas 

f :: Int -> Int 
f x 
    | condición (expresion boolena) = defición 
    | 
    |...

Uso del otherwise 

g :: Int -> Int 
g x 
    | x < 3 = 10
    | x >= 3 && x <= 10 = 455
    | otherwise = 0

El otherwise siempre se pone al final. Si no se cumplen ninguna 
de las condicioens anteriores, entra ahi. Siempre da True. 

En las guardas tampoco se pueden mezclar los tipos. Todos los casos
de guardas, inclusive el otherwise, deben devolver el mismo tipo. 

Restricción del dominio. No siempre se pone el othwerise:

dividir :: Int -> Int -> Int 
dividir dividendo divisor 
        | divisor /= 0 = div dividendo divisor 

Si el divisor es 0, automaticamente dará error. Si hay un valor al cual no puedo darle una respuesta,
es mejor no incluirlo dentro del dominio para que de error.
Primero el programa se fija que conicidan los tipos y despues se fija que esten dentro del dominio. 

Guardas innecesarias

f :: Int -> Bool 
f x 
    | x > 0 = True 
    | otherwise = False

Se podia hacer mas facil con 

f :: Int -> Bool
f x = x > 0 


-------------------------

Tipado, typeclasses, data y tuplas 

Si tenemos una función sin los tipos, ponemos en la consola 
:t nombreDeLaFuncion 
Y nos va a devovler los tipos 

Funciones Genericas 

Función Identidad: dado un valor se retorna ese mismo valor 

f :: a -> a
f x = x

"a" se la llama Variable de Tipo, no se necesita definir. 

ERROR: 

doble :: a -> a            Alternativa demasiado generica
doble x = x*2

Hay muchos tipos (bool, string, etc) que no pueden multiplicarse por 2
Si le preguntamos a haskell de que tipo es doblem nos va a decir 

doble :: Num a => a -> a             Cumple siempre y cuando a sea un número (entero o flotante)

Esa palabra Num es una Typeclass

- Eq : siginfica que pueden ser comparados por igualdad. Ejemplo 
(==) :: Eq a => a -> a -> Bool

- Ord : significa que se pueden ordenar. Ejemplo
(>) :: Ord a -> a -> a -> Bool 

- Num : es un numero- Ejemplo
(*) :: Num a => a -> a -> a

- Fractional : se pueden expresar en fraciones. Los enteros no lo son
(/) :: Fractional a => a -> a -> a 

- Integral : enteros

- Show : sirve apara mostrar. 

En los equiparables entran los caracteres, los booleanos o los string. No se puede comprar booleano con caracter. Las funciones no son equiparables. 

Los typeclasses no son tipos, son restricciones que se ponen en variables de tipos. Esto es un error:

doble :: Num -> Num 

Las funciones uqedan afuera de todo tipo de typeclasses. 

-----------------------------------------------------

Data

data NombreVariable = Constructor {
    campo1 :: Tipo1,
    campo2 :: Tipo2,
    ...
    campon :: Tipo3
} deriving (Eq,Show)

Hacer función para ver si un estudiantes aprobó

Primera Forma

data Estudiante = UnEstudiante {
    nombre :: String,
    legajo :: String, 
    nota :: Int
}

Segunda Forma:

juanita :: Estudiante 
juanita :: UnEstudiante "Juana" "2140883" 8       Se crea en base a la primera forma. Fundamental respetar el orden 

pepito :: Estudiante 
pepito = UnEstudiante {
    legajo = "1547897",
    nombre "Pepe",
    nota = 6
}

Haskell nos define automaticamente funciones de acceso:

> nombre juanita 
"Juana"

> :t nombre 
nombre :: Estudiante -> String            nombre es una función que recibe un estudiante y devuelve un string 

> :t nota 
nota :: Estudiante -> Int 

Los "atributos" o caracteristicas de los estudiantes, son funciones. 

aprobo :: Estudiante -> Bool
aprobo estudiante = nota estudiante >= 6

Aplicamos la funcion nota (que recibe un estudiante y nos devuelve un numero/nota) y preguntamos si es mayor a 6 

El constructor del data es una funcion. Si le preguntamos su tipo nos dice que recibe como parametros los tipos de las funciones 
dentro del data y nos devuelve un estudiante: 

> :t UnEstudiante 
UnEstudiante :: String -> String -> Int -> Estudiante 

Además sirve para trabajar con pattern matching. 

legajoYNombre :: Estudiante -> String 
legajoYNombre (UnEstudiante legajo nombre _) = legajo ++ " " ++ nombre 

> legajoYNombre pepito 
"Pepe 1547897"

Una función para saber si a un estudiante le fue mejor que a otro

# Con Patter Matching 
leFueMejor(UnEstudiante _ _ mejorNota) (UnEstudiante _ _ otraNota) = mejorNota > otraNota

# Sin Pattern Matching  --> Nos permite desentedernso de la forma del data 
leFueMejor estudianteConMejorNota otroEstudiante = nota estudianteConMejorNota > nota otroEstudiante

En la opción sin PM, si en un futuro se agrega otra componente al data, no tenemos que cambiar todas las funciones agregando otro _. 

Inmutabilidad

Le quiero cambiar la nota a juanita de 8 a 9. Cambiandole la nota de por si seria tener una función que genere efecto, traicionando la transparencia referencial. 
Para resolver esto se define una función: 

cambiarNota :: Int -> Estudiante -> Estudiante 
cambiarNota nuevaNota (UnEstudiante nombre legajo _) = UnEstudiante nombre legajo nuevaNota

Si preguntamos por:

> nota (cambiarNota 10 juanita) 
10

Ahora si le preguntamos la nota de juanita 

> nota juanita 
8

Esto sucede ya que no estamos generando efecto. Estamos creando un nuveo valor de tipo estudiante con la nueva nota
Los datos son inmutables, no pueden cambiarse. 

subirNota :: Estudiante -> Estudiante
subirNota estudiante = cambiarNota(nota estudiante + 1) estudiante 

Si preguntamos la nota cuando la subimos, nos devuelve el 9 

> nota (subirNota juanita)
9

Juanita sigue estando ahi, si pregutamos su nota nos va a seguir dando 8. Si queremos producit un cambio, no cambiamos los origianles
si no que producimos nuevos en base a lo que queramos cambiar.  


Podemos agregar el deriving(Show,Eq) para que sean mostrables y comparables

-----------------------------

Tuplas 

Tipos de datos compuestos.  

-}