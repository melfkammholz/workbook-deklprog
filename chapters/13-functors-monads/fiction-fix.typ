Gegeben sei folgender Datentyp:
#align(center)[`data Fiction a = Real a | Fake (Fiction a)`.]

Korrigiere die Fehler in den folgenden Definitionen und Ausdrücken.
- ```haskell
  instance Functor (Fiction a) where
    fmap f (Real x) = Real (f x)
    fmap f (Fake x) = x
  ```
- ```haskell
  instance Monad (Fiction a) where
    return x = Fake (Real x)

    Real x >>= f = Real (f x)
    Fake x >>= f = f x
  ```
- ```haskell
    Fake (Real 42) >>= \x -> Fake (Real (x + 31))
  = Fake (Real 73)
  ```

Prüfe für deine korrigierten `Functor`- und `Monad`-Instanzen
die Identitätsgesetze, also `fmap id = id` und `m >>= return = m`.

#remark[
  In der Klausur kann es hilfreich sein, die definierten `Functor`- und
  `Monad`-Instanzen mithilfe der Gesetze, die gelten sollen, zu prüfen.
]
