{- 

-----------------------------------

Formato del data

data NombreVariable = Constructor {
    campo1 :: Tipo1,
    campo2 :: Tipo2,
    ...
    campon :: Tipo3
} deriving (Eq,Show)

El Eq sirve para poder comprar los datos de la estructura 
El Show sirve para poder mostrar los datos de la estructura 

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

-----------------

Funciones 

nombreFuncion :: VariableEntrada1 -> VariableEntrada2 -> ... -> VariableSalida
nombreFuncion nombreVariable1 nombreVariable2 ... = Expresion 

-----------------

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







-}