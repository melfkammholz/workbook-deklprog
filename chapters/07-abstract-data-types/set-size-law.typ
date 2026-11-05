Eine Teilmenge der Operationen für eine Menge sind
- `insert :: a -> Set a -> Set a` zum Einfügen von einem Wert in eine
  Menge und
- `size :: Set a -> Int` zum Bestimmen der Kardinalität einer Menge.

Gegeben ist folgendes Gesetz:
#align(center)[
  `size (insert y (insert x s)) == size s + 2` #h(1em) für alle
  Werte `x, y`, alle Mengen `s`.
]
Das Gesetz ist falsch. Warum und wie können wir es korrigieren?
