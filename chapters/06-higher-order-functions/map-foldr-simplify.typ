Wir können `map :: (a -> b) -> [a] -> [b]` mithilfe von
`foldr` wie folgt implementieren:
#align(center)[`map f xs = foldr (\x ys -> f x : ys) [] xs`]
Vereinfache den Lambda-Ausdruck mithilfe von Funktionen höherer Ordnung.
