Gegeben sei der Datentyp für knotenbeschriftete Binärbäume
#align(center)[`data Tree a = Empty | Node (Tree a) a (Tree a)`.]

Mithilfe einer Pfadbeschreibung können wir uns durch so einen Baum navigieren.
Diese Beschreibung soll durch eine Liste von Werten vom Typ
`data D = L | R` dargestellt sein.

Implementiere eine Funktion `(!?) :: Tree a -> [D] -> Maybe a`, die
die Beschriftung des Knotens zurückgibt, der durch die gegebene
Pfadbeschreibung gefunden wird. Hier sind kleine Beispiele:
- `Node Empty 3 Empty !? []  = Just 3`
- `Node Empty 3 Empty !? [L] = Nothing`
- `Node Empty 3 Empty !? [R] = Nothing`
- `Node (Node Empty 1 (Node Empty 2 Empty)) 3 Empty !? [L, R] = Just 2`

#remark[
  Da Datenkonstruktoren in Haskell nicht überladen werden können, können wir hier leider nicht `Left` und `Right` verwendet werden, solange
  die Datenkonstruktoren des `Either`-Typs im scope sind.
]
