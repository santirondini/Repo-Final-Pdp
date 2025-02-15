type Persona = String
type Habilidad = String 
type Problema = String 

habilidades :: Persona -> [Habilidad]
habilidades = undefined

sirve :: Problema -> Habilidad -> Bool 
sirve = undefined

tieneHabilidadParaProblema :: Persona -> Problema -> Bool 
tieneHabilidadParaProblema persona problema = any (sirve problema) (habilidades persona) 

podrianAyudar :: Problema -> [Persona] -> [Persona]
podrianAyudar problema = filter (tieneHabilidadParaProblema problema)  

{-
Orden superior => en las funciones filter y any que reciben otras funciones como parametros
Compoiscion => creo que no ya que no hay (.)
Aplicación parcial => en el tienenHabilidadParaProblema problema 
Pattern Matching => no 

3) 
-- Si una persona tuviera una lista infinita de habilidades, la función `podrianAyudar` podría comportarse de manera inesperada.
-- Esto se debe a que la función `tieneHabilidadParaProblema` utiliza `any`, que puede trabajar con listas infinitas siempre y cuando encuentre un elemento que satisfaga la condición.
-- Sin embargo, si ninguna habilidad de la persona sirve para el problema, `any` intentará recorrer toda la lista infinita, lo que resultará en una evaluación no terminante.
-- Por lo tanto, si una persona tiene una lista infinita de habilidades y ninguna de ellas sirve para el problema, la función `podrianAyudar` no terminará para esa persona.
-}
