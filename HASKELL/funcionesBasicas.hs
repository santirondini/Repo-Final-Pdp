
----- Funciones Basicas 
esPar :: Int -> Bool
esPar = even

esMayor :: Int -> Bool
esMayor edad = edad >= 18

esMenor :: Int -> Bool
esMenor = not . esMayor

nombreFormateado :: String -> String -> String
nombreFormateado nombre apellido = apellido ++ ", " ++ nombre

----- Pattern Matching y Guardas

factorial :: Int -> Int
factorial 0 = 1 -- caso base 
factorial n = n * factorial (n-1) -- caso recursivo 

alMenosCero :: (Num a, Ord a) => a -> a
alMenosCero = max 0

maximo :: Int -> Int -> Int
maximo = max

miLast :: [a] -> a
miLast [x] = x
miLast (_:xs) = miLast xs
miLast [] = error "Empty list"

filtrarMayoresA :: Int -> [Int] -> [Int]
filtrarMayoresA n = filter (> n)

resolventeConSuma :: Float -> Float -> Float -> Float
resolventeConSuma a b c = (b + discriminante a b c) / 2*a

resolventeConResta :: Float -> Float -> Float -> Float
resolventeConResta a b c = (b - discriminante a b c) / 2*a

discriminante :: Float -> Float -> Float -> Float
discriminante a b c = b^2 - 4*a*c

baskara :: Float -> Float -> Float -> (Float,Float)
baskara a b c
            | discriminante a b c >= 0 = (resolventeConSuma a b c, resolventeConResta a b c )
            | otherwise = error "No tiene raices reales"

data Alumno = UnAlumno {
    nombre :: String,
    apellido :: String, 
    legajo :: String,
    nota :: Int,
    edad :: Int 
} deriving(Show,Eq)


juanCruz = UnAlumno "Juan Cruz" "Rodriguez" "2140883" 7

aprobo :: Alumno -> Bool
aprobo =  (> 6) . nota

mayorDeEdad :: Alumno -> Bool
mayorDeEdad = (> 21) . edad 

mayoresAprobados :: [Alumno] -> [Alumno]
mayoresAprobados = filter mayorDeEdad . aprobados  

aprobados :: [Alumno] -> [Alumno]
aprobados = filter aprobo 

sumaCuadrados :: [Int] -> Int 
sumaCuadrados  = sum . map (^ 2)  

filtrarYDuplicar :: [Int] -> [Int]
filtrarYDuplicar = filter even . map (*2)

longitudes :: [String] -> [Int]
longitudes = filter (> 5). map length 

iniciales :: [String] -> [Char]
iniciales = map . take 1 

