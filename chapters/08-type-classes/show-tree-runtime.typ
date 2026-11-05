Eine `Show`-Instanz für den Typ
`data Tree a = Leaf a | Tree a :+: Tree a`
könnte wie folgt aussehen:
```haskell
instance Show a => Show (Tree a) where
  show (Leaf x)  = "Leaf " ++ show x
  show (l :+: r) = "(" ++ show l ++ ") :+: (" ++ show r ++ ")"
```
Welche Werte vom Typ `Tree a` führen zur worst-case Laufzeit
und welche zur best-case Laufzeit? Die Anzahl der Blätter soll hier frei sein. Welche Eigenschaften von `(++)` führen zu den jeweiligen
Laufzeiten?
