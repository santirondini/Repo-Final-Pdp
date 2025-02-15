-- SACAR TIPO DE LAS FUNCIONES 

f x y = (>10) . head . filter (x y) . map y 

m :: (t -> a -> Bool) -> t -> [a] -> Bool
m p q  = (>0) . length . filter (p q)  

m' :: (b -> Bool) -> (a -> b) -> [a] -> Bool
m' p q  = (>0) . length . filter (p . q)  

{-
ATENTO: 
No es lo mismo p q que p . q
En el primero caso, q es un valor, en el segundo es una función 
-}

n :: (Ord b, Num b) => (t1 -> t2 -> a -> b) -> t1 -> t2 -> [a] -> Bool
n u v w = (<5) . sum . map (u v w)

-- Nos estabamos olvidado de recibir el elemento de la lista para el filter
-- estabamos haciendo esto f' :: (c -> (a -> b) -> Bool) -> c -> (a -> b) -> [a] -> b
-- Nos faltaba que r, ademas de recibir sus parametros c y la función que va de a -> b, tambien reciba el elemento b de la lista para filtarla 

f' :: (c -> (a -> b) -> b -> Bool) -> c -> (a -> b) -> [a] -> b
f' r s t = head . filter (r s t) . map t 


