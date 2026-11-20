Betrachte die folgende Definition von polymorphen, knoten- und blattbeschrifteten Binärbäumen `BTree a` sowie die zugehörige Faltungsfunktion `foldBTree`.

```haskell
data BTree a = Leaf a
             | Node (BTree a) a (BTree a)
  deriving Show

foldBTree :: (a -> b) -> (b -> a -> b -> b) -> BTree a -> b
foldBTree fleaf fnode bt = case bt of
  Leaf x     -> fleaf x
  Node l n r -> fnode (foldBTree fleaf fnode l) n (foldBTree fleaf fnode r)
```

Implementiere durch je _einen_ Aufruf von `foldBTree` die beiden folgenden Funktionen.

- `maxBTree :: BTree Int -> Int` liefert die größte Beschriftung in einem mit ganzen Zahlen beschrifteten Binärbaum.
- `replace :: BTree a -> b -> BTree b` ersetzt alle Beschriftungen in einem Binärbaum durch die gegebene Beschriftung.

#hint[Welche Typen haben `fleaf` und `fnode` für `maxBTree`? Was ist `b`?]
#hint[Bei `replace` ist `b` der Typ `BTree b`: `fleaf` baut ein neues Blatt, `fnode` einen neuen Knoten aus den bereits ersetzten Teilbäumen.]
