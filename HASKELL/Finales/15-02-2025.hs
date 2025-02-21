
data Producto = Producto {
    nombre :: String,
    marca :: String 
}

-- Bien : 

--deMarca :: String -> [Producto] -> [Producto]
--deMarca unaMarca prodcutos = filter (== UnaMarca) . marca prodcutos

todosSeLLaman :: String -> [Producto] -> Bool 
todosSeLLaman unNombre = all((== unNombre) . nombre)

type Criterio = Producto -> Bool

primerosQueCumplen :: Criterio -> [Producto] -> [String]
primerosQueCumplen criterio = map nombre . take 3 . filter criterio 

leche = Producto "leche" "La Serenisma "

listaInfinita :: [Producto]
listaInfinita = repeat leche

criterio :: Criterio 
criterio = (<3) .length . nombre 

criterio2 :: Criterio
criterio2 = (== "leche") . nombre 


{-

De marca tiene los problemas al aplicar la función marcas a la lista de productos 


3. Todos se llaman no se podria hacer con listas infinitas de productas ya que nunca terminaría de corroborar
si todos cumplen la condición. Por otro lado, primerosQueCumplen depende:

ghci> primerosQueCumplen criterio2 listaInfinita
["leche","leche","leche"]

ghci > primerosQueCumplen criterio1 listaInfinita
vacio 


-}

deMarcaPremiun :: String -> [Producto] -> [Producto]
deMarcaPremiun unaMarca productos = filter (\producto -> (== unaMarca) . marca $ producto) productos 