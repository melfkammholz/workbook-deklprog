Das Pendant zum Falten #strike[ist das Bügeln] mit `foldr` ist
`unfoldr` (aus `Data.List`). Anstatt eine Liste von Werten zu
falten, können wir mit `unfoldr` aus einem Wert eine Liste erzeugen.
Die Funktion hat den Typ `(b -> Maybe (a, b)) -> b -> [a]`.
- Überlege dir anhand des Typs, wie diese Funktion implementiert sein könnte.
  Implementiere sie anschließend.
- Können wir `foldr (+) 0 [3, 1, 4, 1, 5]` mit `unfoldr`
  rückgängig machen? Das heißt, können wir die Eingabeliste rekonstruieren,
  ohne Annahmen darüber zu machen, wie die Eingabeliste entstanden ist?
- Berechne die Binärdarstellung einer natürlichen Zahl mithilfe von
  `unfoldr`. (Das LSB soll an erster Stelle der Ausgabeliste stehen.)
  Implementiere dies als Funktion `bits :: Int -> [Int]`.
- Implementiere `map` mithilfe von `unfoldr`.
