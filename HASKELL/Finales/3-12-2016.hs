
--f :: ((a -> b) -> b -> Bool) -> (a -> b) -> [a] -> Bool 

f' :: (Ord b, Num b) => ((a -> b) -> b -> Bool) -> (a -> b) -> [a] -> Bool
f' x y = ( > 10 ) . head . filter (x y) . map y  

lista :: [Int]
lista = [1,5,8,9,2] ++ lista

x :: (Ord b, Num b) => (a -> b) -> b -> Bool 
x s z = z > 2

y :: Num a => a -> a
y x = x + 2

{-

ghci> f' x y lista
False

Esto ya que la lazy evaluation de haskell va de afuera hacia adentro 

-}