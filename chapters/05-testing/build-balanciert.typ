In dieser Aufgabe möchten wir einen höhenbalancierten, blattbeschrifteten
Binärbaum konstruieren. Dafür möchten eine Funktion `build :: [a] -> Tree a`
entwickeln. Ein Baum ist höhenbalanciert, wenn sich an jedem Knoten die Höhen
des linken und rechten Teilbaums um höchstens 1 unterscheiden. Ein Blatt hat die Höhe 0.

Die Werte sollen im Baum in der Reihenfolge der Liste stehen, also 
`toList (build xs) == xs`.

Das Gerüst enthält eine Implementierung, die die Reihenfolge einhält, aber nicht balanciert baut. Gegeben sind ebenso `toList` und `height`.

+ Schreibe das Prädikat `balanced :: Tree a -> Bool`. 
+ Schreibe Eigenschaften für `build`: Reihenfolge und Balance. Beachte die 
  Vorbedingung, dass die Liste nicht leer ist.
+ Korrigiere `build`.

#hint[Was passiert bei `build []`? Mit `(==>)` kannst du leere Listen ausschließen.]
#hint[Wenn die Liste mehr als ein Element hat, teile sie in der Mitte (`splitAt`) und baue beide Hälften.]
