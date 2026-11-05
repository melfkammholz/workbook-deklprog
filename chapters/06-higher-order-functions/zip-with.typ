Es gibt viele andere hilfreiche Funktionen höherer Ordnung in der Haskell
Prelude. Eine von diesen ist `zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]`.
Sie verknüpft jeweils zwei Elemente aus den jeweiligen Listen unter der
gegebenen Funktion.
- Implementiere `zipWith` mithilfe von `map, uncurry, zip`.
- Implementiere `zip` mithilfe von `zipWith`.
- Implementiere das Prädikat `isSorted` mithilfe von `zipWith`.
