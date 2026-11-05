Gegeben sei der Datentyp
#align(center)[`data Doubly a = Null | Node (Doubly a) a (Doubly a)`.]
- Implementiere eine Funktion `fromList :: [a] -> Doubly a`, die
  die gegebene Liste in eine doppelt-verkettete Liste umwandelt. `Null`
  soll sowohl das linke als auch das rechte Ende der Liste darstellen. Von diesem muss es nicht möglich sein, zum anderseitig verketteten Element zurückzukommen.
  `fromList` soll den Knoten zurückgeben, der mit dem ersten
  Listenelement korrespondiert.
- Weiter implementiere auch `prev :: Doubly a -> Doubly a`,
  `value :: Doubly a -> Maybe a` und
  `next :: Doubly a -> Doubly a`, die den vorherigen Knoten, die
  Beschriftung eines Knoten, und den nächsten Knoten zurückgeben sollen.
- Angenommen du möchtest einen weiteren Wert in die doppelt-verkettete Liste
  einfügen, auf welches Problem stößt du hinsichtlich Mutierbarkeit?

Der Wert des folgenden Ausdrucks soll `Just 8` sein.
```haskell
let xs = fromList [1, 6, 1, 8, 0, 3]
 in value . prev . next . next . next . next $ xs
```
