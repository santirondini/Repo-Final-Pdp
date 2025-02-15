
type Sintoma = String 
type Medicamento = [String] -> [String]

amoxicilina = cura "infeccion"
ibuprofeno = cura "dolor" . cura "hinchazon"

cura sintoma = filter (/= sintoma)

varicela = repeat "picazon"

sugestion :: [Sintoma] -> [Sintoma]
sugestion sintomas = []

curaTodosLos :: [Sintoma] -> Medicamento -> Bool 
curaTodosLos sintomas medicamento = medicamento sintomas == []

todosLosMedicamentos = [sugestion, amoxicilina , ibuprofeno]

find condicion = head . filter condicion

mejorMedicamentoPara sintomas = find (curaTodosLos sintomas) todosLosMedicamentos 

{-
2. Los dos conceptos mas imporantes aplicados en mejorMedicamento son:

- Aplicación parcial: en la parte de curaTodosLos sintomas, se aplica parcialemente curaTodosLos con sintomas para que 
se "cree" una nueva función que reciba unicamente un medicamento para ver si ese cura todos los sintomas. 

- Orden superior: find es una función de orden superior ya que recibe funciones como parametro (curaTodosLos sintomas)

3. Va a dar error ya que, cuando entre a la parte de curaTodosLos y le pasemos la lista infinita de sintomas, esta nunca va a quedar vacía.

Si hacemos el cambio con sugestion y lo agregamos a todosLosMedicamentos en la cabeza, va a devolvernos sugestión ya que deja la lista vacia
cumpliendo la condición de curaTodosLos. 


-}