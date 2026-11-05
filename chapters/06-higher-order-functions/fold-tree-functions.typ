Gegeben sei die Faltungsfunktion
`foldTree :: r -> (r -> a -> r -> r) -> Tree a -> r`
für einen knotenbeschrifteten Binärbaum gegeben durch
#align(center)[`data Tree a = Empty | Node (Tree a) a (Tree a)`.]

Eine Reihe von Funktionen, die du bereits für Listen kennengelernt
hast, lassen sich auch auf Bäume übertragen.

Implementiere die Funktionen
- `any :: (a -> Bool) -> Tree a -> Bool` und
  `all :: (a -> Bool) -> Tree a -> Bool`,
- `elem :: Int -> Tree Int -> Bool` und
  `notElem :: Int -> Tree Int -> Bool`,
- `toList :: Tree a -> [a]`,
- `null :: Tree a -> Bool` (überprüft, ob der Baum leer ist),
- `length :: Tree a -> Int`,
- `maximum :: Tree Int -> Int` und `minimum :: Tree Int -> Int` für nicht-leere Bäume, und
- `sum :: Tree Int -> Int` und `product :: Tree Int -> Int`.

#remark[
  Diese Funktionen lassen sich auf alle faltbaren Datentypen verallgemeinern.
  Dies wird mithilfe der
  #link("https://hackage.haskell.org/package/base-4.21.0.0/docs/Data-Foldable.html")[Typklasse `Foldable`]
  festgehalten.
]
