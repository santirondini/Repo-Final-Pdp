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


-}