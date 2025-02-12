{- 
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

Ejemplo con la función truncar:

truncar :: Int -> String -> (String, Int)
truncar cantidadDeCaracteres palabra = 
    (take cantidadCaracteres palabra, length palabra - cantidad caracteres)

> truncar 7 "paradigmas"
("paradig",3) 

(como queda la palabra , letras que faltan)

Duplas: tipo de dato con dos componentes. Funciones de acceso

fst (x,_) = x  ==> Retorna la primera compotente de la dulpa.  fst :: (a,b) -> a
snd (_,y) = y  ==> Retorna la segunda compotente de la dulpa   snd :: (a,b) -> b

Las tuplas son comparables por igualdad (Eq), se pueden mostrar (Show) y 
son ordenables si alguna de sus componentes lo son (Ord), por ejemplo: 

> (pepe,juana) > (lolo, santino) ==> esto da error

Las tuplas no son numericas incluso si sus componentes lo son: 

> (1,2) + (3,4) ==> ERROR

Los data tienen tipos propios, dan mayor expresividad, hay mejor acceso
y es mejor para modelar datos del dominio. 

Las tuplas ya tienen tipos predefinidos y solo hay funciones predefinidas para las duplas. 

------------------------------------------------

Alias de tipo

type NombreTipo = Tipo

Ejemplos: 

type Nombre = String
type Edad = Int
type Universo = [Personaje]
type Gema = Personaje->Personaje

Puedes ser datos como tambien listas y funciones. Aporta mas expresividad 

------------------------------------------------

Aplicación Parcial

Las funciones pueden ser aplciadas con menos parametros de los que realmente espera.
Si una función que espera una cantidad N de parametros, le aplicamos M valores / M < N, la estamos aplicando parcialmente
Al aplicar parcialmente una función de N parametros con M valores, obtenemos otra función de N - M parametros. Los parametros
se aplican en el orden que la función original los espera

Ejemplos: 

conjuncion :: Bool -> Bool -> Bool 
truncar :: Int -> String -> (String, Int)

> :t conjuncion True 
conjuncion True :: Bool -> Bool 

> :t truncar 4
truncar 4 :: String -> (String, Int)

Se crea una nueva función que recibe un parametro menos y devuelve el mismo tipo que la función original 

Evaluar una función prefija de dos parametros de forma infija: 

> 4 ´truncar´ "hola mundo"
("hola",6)
 
> :t (4 ´truncar´)
String -> (String,Int)

> :t (´truncar´ "hola")
Int -> (String,Int)

Otros ejemplos: 

1) 

(==) :: Eq a => a -> a -> Bool
Si pasamos la función 

> :t (== 'a')
(== 'a') :: Char -> Bool 

Nos da una función que espera un char y devuelve un booleano. Es una función 
que dice si un caracter es igual o no a 'a'. 

2) 

(min) :: Ord a => a -> a -> a
Si la pasamos como 

> :t min "hola"
min "hola" :: [Char] -> [Char]

A partir de un string, evalua si ese string es menor a hola y devuelve ese u "hola" (dependiendo que dió el booleano)

>(min "hola") "mickey"
"hola"

3) 

(+) :: Num a => a -> a -> a 
La pasamos como 

> :t (+ 22)
(+ 22) :: Num a => a -> a

Es una función que espera un número y devuelve otro más 22. Espera un número para sumarle 22

> (+ 22) 2
24

DEFINIR FUNCIONES EN TÉRMINOS DE OTRAS 

esMayor :: Edad -> Bool
esMayor = (>= 18)

doble :: Num a => a -> a -> a
doble = (2 *)

alMenosCero :: (Num a, Ord a) => a -> a
alMenosCero = max 0

----------------------------------------

Composición 

Ejemplo de los pianos

piano :: Midi -> Audio 
bajarTono :: Midi -> Midi

pianoMasGrave :: Midi -> Audio 
pianoMasGrave = piano . bajarTono 

Lo que sale de bajarTono, tiene que ser consistente con lo que entra en piano.

> :t not . even 
not . even :: Integral a => a -> Bool 

Precedencia

> :t not . even 7 
ERROR 

Esto falla porque "even 7" es falso (un valor), no es una función. No se pueden componer 
con "not", que si es función. Se componen funciones con funciones, no funciones con valores. Se puede solucionar asi: 

1) > (not . even) 7 
True 

2) > not . even $ 7 
True 

El operador ($) sirve para aplicar y tiene menor precedencia que el operador (.), por eso se puede hacer de esta forma 

> (not . even . length) "paradigmas"
False

O tambien puede ser: 

> not.even.length $ "hola"
False

Se lee de derecha a izquierda la composición 

Con mas parametros 

ajustarTono :: Int -> Midi -> Midi
piano :: Midi -> Audio 

pianoAjustable :: Int -> Midi -> Audio 
pianoAjustable delta midi = piano . (ajustarTono delta midi)

lo mismo que: 


pianoAjustable :: Int -> Midi -> Audio 
pianoAjustable delta midi = piano . ajustarTono delta 


No se puede scar el delta ya que, si lo sacamos, nos queda la función ajustarTono de tipo Int -> Midi -> Midi. Cuando 
la función piano es de Midi -> Audio (estaria recibiendo un parametro mas que es el Int). La función piano recibi un Midi
y si nosotros no ponemos el delta para que remplace el Int del input, fallaría la composición. 
Poniendo el delta, remplazamos el Int para que a la función piano le llegue unicamente el Midi 
 
Aplicación de funciones compuestas con aplicación parcial 

1)
> :t take 3 . (++ "pdep")
take 3 . (++ "pdep") :: Strings -> String 

> take 3 . (++ "pdep") $ "wi"
"wip"

2)
> :t (==0).(`mod` 2) 
(==0).(`mod` 2) :: Integral a => a -> Bool 

> (==0).(`mod` 2) $ 10
True

3)
> even . (*3) . (+ 5) $ 2
False 

Tres formas distintas de escribir la misma función 

f a b = ((+ a).(*2)) b

f' a b = (+ a) . (*2) $ b

f'' a = (+ a).(*2)

Si el parametro aparece mas de una vez, no se va poder cancelar 

g a = (a *).(+ a)

h = max



-}