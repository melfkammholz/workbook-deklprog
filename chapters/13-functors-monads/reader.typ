Die `Reader`-Monade ermöglicht es, eine gemeinsame Umgebung mit vielen
Berechnungen zu teilen.
```haskell
newtype Reader r a = Reader { runReader :: r -> a }

instance Monad (Reader r) where
  return x = Reader (\_ -> x)

  r >>= k = Reader (\s -> let x = runReader r s
                              y = runReader (k x) s
                           in y)
```
Woran kannst du erkennen, dass die Berechnung `r` vor dessen
Weiterführung mit `k` und dem Ergebnis von `r` stattfindet?
