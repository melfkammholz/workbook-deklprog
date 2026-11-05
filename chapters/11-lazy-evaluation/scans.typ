`scanl :: (b -> a -> b) -> b -> [a] -> [b]` und
`scanr :: (a -> b -> b) -> b -> [a] -> [b]` sind ähnlich zu
`foldl` und `foldr`. Beide Funktionen speichern die
Zwischenergebnisse der jeweiligen Funktion in Listen.
```haskell
scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanl _ e []     = [e]
scanl f e (x:xs) = e : scanl f (f e x) xs

-- scanl (+) 0 [1..4] = [0, 1, 3, 6, 10]

scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr _ e []     = [e]
scanr f e (x:xs) = f x y : ys
  where ys@(y:_) = scanr f e xs

-- scanr (+) (0) [1..4] = [10, 9, 7, 4, 0]
```
- Welche der beiden Funktionen kann auf unendlichen Listen arbeiten?
- (Implementiere die Fibonacci-Folge `fibs :: [Integer]` mithilfe
  von einer der beiden Funktionen.)
