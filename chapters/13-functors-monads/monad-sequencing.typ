Wir nutzen Monaden zur Sequenzierung von Berechnungen. Identifiziere diese
Sequenzierung in den folgenden `Monad`-Instanzen bzw. stelle fest, dass
`m` in `m >>= k` zuerst berechnet wird, bevor die Berechnung mit
`k` fortgesetzt wird.
```haskell
instance Monad Maybe where
  return x = Just x

  Nothing >>= _ = Nothing
  Just x  >>= k = k x

instance Monad [] where
  return x = [x]

  []     >>= _ = []
  (x:xs) >>= k = k x ++ (xs >>= k)
```
