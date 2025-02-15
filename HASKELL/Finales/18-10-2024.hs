
data Producto = Prod {
     nombre :: String,
     precio :: Float,
     precioCantidad :: Float
}

queEmpieceCon :: Char -> Producto -> Bool
queEmpieceCon inicial = ( == inicial) . head . nombre   

barato :: Producto -> Bool
barato = (<50) . precio 

type Persona = [Producto -> Bool] 

juan :: Persona
juan = [queEmpieceCon 'a', barato ]

cumpleRequisitos :: Producto -> Persona -> Bool 
cumpleRequisitos producto = all (\requisito -> requisito producto)    

elegidosPor :: Persona -> [Producto] -> [Producto]
elegidosPor persona = filter (\producto -> cumpleRequisitos producto persona)   

