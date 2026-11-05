Manche Funktionen lassen sich nur partiell sinnvoll definieren. Implementiere
die Funktionen
- `head, last :: [a] -> a`, die das erste und letzte Element einer
  Liste zurückgeben,
- `init, tail :: [a] -> [a]`, die die ersten und letzten $n - 1$
  Elemente einer $n$-elementigen Liste zurückgeben,
- `(!!) :: [a] -> Int -> a`, das ein Element an einer bestimmten
  Position in einer Liste zurückgibt,
- `minimum, maximum :: Ord a => [a] -> a`, die das Minimum bzw. Maximum
  in einer Liste zurückgeben,
- `fromJust :: Maybe a -> a`, die das Element aus einem
  `Just`-Wert herausholt,
und überlege dir, für welche Elemente des Definitionsbereichs du keine
sinnvolle Regel angeben kannst. Überlege es dir ebenso für die Funktionen
`div, mod :: Int -> Int -> Int` und
`read :: Read a => String -> a`, die du nicht implementieren musst.
