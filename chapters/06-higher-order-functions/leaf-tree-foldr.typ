Wir haben `foldr :: (a -> b -> b) -> b -> [a] -> b` als natürliche
Faltungsfunktion kennengelernt, die einen Ausdruck erzeugt, der rechts
geklammert ist. Zum Beispiel gilt
#align(center)[`foldr (+) 0 [1, 2, 3] = 1 + (2 + (3 + 0))`.]

Das gleiche Ziel können wir mit anderen Typen verfolgen. Implementiere
eine Funktion `foldr :: (a -> b -> b) -> b -> Tree a -> b` für einen
blattbeschrifteten Binärbaum `data Tree a = Leaf a | Tree a :+: Tree a`,
die den gleichen Ausdruck erzeugt. Zum Beispiel soll
#align(center)[
  `foldr (+) 0 ((Leaf 1 :+: Leaf 2) :+: Leaf 3) = 1 + (2 + (3 + 0))`
]
gelten.

#remark[
  Das `foldr` für `Tree a` entspricht nicht der natürlichen
  Faltung auf diesem Typen.
]
