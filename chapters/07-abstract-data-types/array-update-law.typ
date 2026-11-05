Als Teil eines ADTs für Arrays soll eine Operation `at :: Array a -> Int -> a`
spezifiziert werden, die das Element an einer Position in einem Array zurückgibt.
Weiter soll `update :: Int -> a -> Array a -> Array a` einen Wert an
eine Position in ein Array schreiben.

Wie können wir spezifizieren, dass durch ein `update` nur das Element
an der gegebenen Position verändert wird?

#sample[
  ```haskell
  update k x a `at` k == x
  j /= k ==> update k x a `at` j == a `at` j
  ```
  Dabei müssen `j` und `k` gültige Positionen in `a` sein.
]
