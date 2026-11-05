Argumentiere anhand der Gesetze, die für `Functor`-Instanzen
gelten sollen, dass die folgenden `Functor`-Instanzen keine gültigen
Instanzen sind. Gib auch Beispiele an, die zeigen, dass die Gesetze nicht
erfüllt sind.
```haskell
instance Functor [] where
  fmap f [] = []
  fmap f (x:xs) = f x : f x : fmap f xs

data Tree a = Empty | Leaf a | Tree a :+: Tree a

instance Functor Tree where
  fmap _ Empty     = Empty
  fmap f (Leaf _)  = Empty
  fmap f (l :+: r) = fmap f l :+: fmap f r
```
