Betrachte die Funktion
```haskell
f :: [a] -> b
f []     = e
f (x:xs) = g x (f xs)
```
Nach diesem induktiven Muster sind viele Funktionen auf Listen implementiert.
Nimm als Beispiel die Funktion `sum :: [Int] -> Int`.
```haskell
sum :: [Int] -> Int
sum []     = 0
sum (x:xs) = x + sum xs
```
Dieses Muster haben wir in `foldr` abstrahiert. Wo wandern die
jeweiligen Bestandteile der abstrakten Funktion `f` hin, wenn wir
`f` mithilfe von `foldr` definieren? Was passiert insbesondere
mit dem rekursiven Aufruf von `f`?
