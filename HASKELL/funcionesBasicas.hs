
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
factorial n = n * factorial(n-1) -- caso recursivo 

