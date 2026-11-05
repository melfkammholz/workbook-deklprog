Gegeben sei der Datentyp `data Tree a = Leaf a | Tree a :+: Tree a`.
- Implementiere eine Funktion `splits :: [a] -> [([a], [a])]`, die
  alle nicht-leeren Aufteilungen der Eingabeliste berechnet.

  Zum Beispiel soll `splits [1..4]` die Liste
  #align(center)[`[([1], [2, 3, 4]), ([1, 2], [3, 4]), ([1, 2, 3], [4])]`]
  ergeben.
- Implementiere eine Funktion `allTrees :: [a] -> [Tree a]`, die alle
  Binärbäume generiert, deren Blätter von links nach rechts die Eingabeliste
  lesen. Versuche, `allTrees` mithilfe von list comprehensions oder der
  Listenmonade zu implementieren.
