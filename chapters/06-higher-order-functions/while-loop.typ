Mit Funktionen höherer Ordnung können wir Kontrollstrukturen aus der
imperativen Programmierung definieren. Hier ist eine mögliche Definition einer
bedingten Wiederholung.
```haskell
while :: (a -> Bool) -> (a -> a) -> a -> a
while p f x | p x       = while p f (f x)
            | otherwise = x
```

In #xref("imperative-variables") haben wir zwei Funktionen gesehen, die diese Kontrollstruktur
verwenden. In Haskell können wir `clz` mithilfe von `while` wie
folgt definieren.
```haskell
clz :: Int -> Int
clz n = 64 - snd (while cond step (n, 0))
  where
    cond (n, k) = n > 0
    step (n, k) = (n `div` 2, k + 1)
```
Oder alternativ so
```haskell
clz :: Int -> Int
clz = go 0
  where
    go k n | n > 0     = go (k + 1) (n `div` 2)
           | otherwise = 64 - k
```
Beide Funktionsdefinitionen sind semantisch äquivalent. Argumentiere unter
verschiedenen Aspekten, warum die eine Implementierung besser als die andere
sein könnte -- z.B. in Hinsicht auf Lesbarkeit, Idiomatik und Wartbarkeit.
