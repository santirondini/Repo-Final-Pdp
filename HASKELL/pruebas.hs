
data Destino = Lugar {
    nombre :: [Char],
    precio :: Int,
    atractivos :: [String]
}

type Requisito = Destino -> Bool

tieneAtractivo :: String -> Destino -> Bool
tieneAtractivo particular destino = elem particular (atractivos destino)

barato destino = precio destino < 50  

alguien = [tieneAtractivo "boliche", barato]

destinosElegidos requisitos = filter ( f requisitos ) 

f :: [Requisito] -> Destino -> Bool 
f requisitos destino = any (\requisito -> requisito destino) requisitos 

-- -------------------------------------------

