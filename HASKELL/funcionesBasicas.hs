
----- Funciones Basicas 
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

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




