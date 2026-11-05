Ob sich Forschende der Kulturanthropologie in ferner Zukunft fragen werden,
warum die Menschheit im frühen 21. Jahrhundert scheinbar eine große Nachfrage
für
#link("https://www.youtube.com/results?search_query=guess+the+number")["Guess The Number Challenge"-Videos]
hatte?

Wenn die Spielenden Zahlen aus einer festgelegten Menge mit gleicher
Wahrscheinlichkeit wählen, dann ist die binäre Suche die beste Strategie, um das Spiel zu gewinnen. Gegeben sei folgende Funktion.
```haskell
binarySearch :: Int -> [Int] -> Bool
binarySearch _ [] = False
binarySearch x xs = x == y || if x < y
                                then binarySearch x (take m xs)
                                else binarySearch x (drop (m + 1) xs)
  where
    y = xs !! m
    n = length xs
    m = n `div` 2
```
Warum ist die binäre Suche auf Listen in Haskell ein eher ungeeignetes
Verfahren? Wie würde man stattdessen vorgehen?
