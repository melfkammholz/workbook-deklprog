Gegeben sei der Datentyp
#align(center)[`data Tree a = Empty | Node (Tree a) a (Tree a)`.]

- Implementiere eine Funktion `preorder :: Tree a -> [a]`, die
  Knotenwerte in #link("https://de.wikipedia.org/wiki/Bin%C3%A4rbaum#Traversierung")[pre-order]
  zurückgibt. Das heißt, zuerst wird ein Knoten betrachtet und anschließend
  dessen linker und danach dessen rechter Teilbaum.
- Implementiere einen unendlichen Baum `tree :: Tree Int`, der die Menge
  $ { f(i, j) | i, j in NN, i <= j } "mit" f(i, j) = i + j + 2 i j $
  darstellt. Die Wurzel soll den Wert $f(1,1)$ haben. Für einen beliebigen
  Knoten mit Beschriftung $f(i,j)$  soll die Wurzel des linken Teilbaums mit
  $f(i+1,j)$ beschriftet sein und die Wurzel des rechten Teilbaums mit
  $f(i,j+1)$. Falls $i > j$ erreicht wird, soll in den Baum ein
  `Empty`-Knoten gesetzt werden.
- Wende `preorder` auf `tree` an. Welches Problem haben wir
  hinsichtlich der Werte, die wir in den jeweiligen Teilbäumen von `tree` sehen, und der Ergebnisliste von `preorder`? Wie hängt deine
  Beobachtung mit `[f i j | i <- [1..], j <- [i..]]` zusammen?
- Implementiere eine Funktion `merge :: Ord a => [a] -> [a] -> [a]`, die zwei sortierte (unendliche) Listen zusammenführt, und eine Abwandlung `preorderMerge` von `preorder`, die statt `(++)` die Funktion `merge` verwendet.
- Implementiere als Nächstes die Mengendifferenz als Funktion
  `diff :: Ord a => [a] -> [a] -> [a]`. Du darfst dabei annehmen, dass
  die Eingabelisten bereits sortiert sind.
- Was berechnet ```hs 2 : map (\x -> 2 * x + 1) ([1..] `diff` preorder tree)```?

#remark[
  Das Verfahren ist als #link("https://en.wikipedia.org/wiki/Sieve_of_Sundaram")[Sieb von Sundaram]
  bekannt. Die Konstruktion der oben angegebenen Menge mithilfe von
  unendlichen Bäumen ist nicht Teil des Verfahrens.
]
