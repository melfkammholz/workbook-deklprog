Für Listen gibt es neben `foldr` auch `foldl`. Sie sieht ähnlich aus, ist aber keine Faltung im Sinn der letzten
Lektionen: Sie tauscht keine Konstruktoren aus, sondern läuft mit einem Akkumulator durch die Liste. Hier schauen wir
uns an, was das ändert.

= Zwei Rechnungen für dieselbe Summe

Nur `foldr` folgt dem Verfahren und tauscht die Konstruktoren aus. `foldl` hat dagegen einen Akkumulator, der bei jedem
Schritt neu berechnet wird.

```
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f z []     = z
foldl f z (x:xs) = foldl f (f z x) xs
```

An der Summe von `[1, 2, 3]` sieht man den Unterschied. Bei `foldr` entsteht das Ergebnis Element für Element um den
rekursiven Aufruf herum:

```
  foldr (+) 0 [1, 2, 3]
= 1 + foldr (+) 0 [2, 3]
= 1 + (2 + foldr (+) 0 [3])
= 1 + (2 + (3 + foldr (+) 0 []))
= 1 + (2 + (3 + 0))
```

Bei `foldl` ist das Ergebnis der Akkumulator, und den bekommen wir erst, wenn das Ende der Liste erreicht ist:

```
  foldl (+) 0 [1, 2, 3]
= foldl (+) (0 + 1) [2, 3]
= foldl (+) ((0 + 1) + 2) [3]
= foldl (+) (((0 + 1) + 2) + 3) []
= ((0 + 1) + 2) + 3
```

Beide Rechnungen enden bei `6`. Bei anderen Operationen wäre das nicht so, darum geht es in der Lektion über Monoide.
Als Baum gezeichnet sieht man, was sich ändert: Bei `foldr` klammert die Rechnung nach rechts, und der Startwert `z`
sitzt ganz unten rechts. Bei `foldl` klammert sie nach links, und `z` sitzt ganz unten links.

#expr-trees(
  colors: (f: 3, z: 1),
  (expr: "f 1 (f 2 (f 3 z))", caption: "foldr f z [1, 2, 3] = f 1 (f 2 (f 3 z))"),
  (expr: "f (f (f z 1) 2) 3", caption: "foldl f z [1, 2, 3] = f (f (f z 1) 2) 3"),
)

= Warum `foldl (flip (:)) []` umdreht

Beide Faltungen unten legen jedes Element vorn an eine Liste, die mit `[]` beginnt. Der Unterschied steckt in den
Klammern, genau wie bei der Summe oben: `foldl` klammert nach links, `foldr` nach rechts. Hier heißt die Funktion bei
`foldl` kurz `f`, mit `f acc x = x : acc`, also `f = flip (:)`.

#expr-trees(
  colors: (f: 3, "(:)": 3, "[]": 1),
  (expr: "f (f (f [] 1) 2) 3", caption: "foldl f [] [1, 2, 3]"),
  (expr: "(:) 1 ((:) 2 ((:) 3 []))", caption: "foldr (:) [] [1, 2, 3]"),
)

Ausgerechnet wird von innen nach außen, also bei `foldl` von unten links und bei `foldr` von unten rechts:

```
  foldl f [] [1, 2, 3]
= f (f (f [] 1) 2) 3
= f (f [1] 2) 3          -- f acc x = x : acc
= f [2, 1] 3
= [3, 2, 1]

  foldr (:) [] [1, 2, 3]
= 1 : (2 : (3 : []))
= [1, 2, 3]
```

Bei `foldl` kommt das erste Element als Erstes vorn an `[]` und rutscht nach hinten, wenn weitere davor gelegt werden:
Die Liste dreht sich um. Bei `foldr` sitzt das erste Element außen, es kommt zuletzt nach vorn, und die Reihenfolge
bleibt erhalten.

= Verständnisfragen

#quiz(
  [Was ist `foldl (flip (:)) []`?],
  choice[`id`][Das wäre `foldr (:) []`. Probiere beide im Widget oben aus.],
  choice(correct: true)[`reverse`][Genau: Jedes Element wird vorn an den Akkumulator gelegt.],
  choice[`sort`][Die Elemente werden nicht verglichen, nur umgelegt.],
)

#quiz(
  [Was ergibt `head (foldl (flip (:)) [] [1..100])`?],
  choice[`1`][Das wäre `foldr (:) []`. Diese Faltung dreht die Liste um.],
  choice(correct: true)[`100`][Genau: Nach dem Umdrehen steht `100` vorn.],
  choice[`[100]`][`head` liefert ein Element, keine Liste.],
)

#quiz(
  [Welcher Ausdruck wird schneller ausgewertet: `head (foldl (flip (:)) [] [1..100])` oder
    `head (foldr (:) [] [1..100])`?],
  choice(correct: true)[Der mit `foldr`][Genau: `foldr (:) []` liefert sofort `1 : …`, und `head` braucht den Rest nie
    auszuwerten. `foldl` verarbeitet zuerst alle 100 Elemente. Die Ergebnisse unterscheiden sich auch: `1` gegen
    `100`.],
  choice[Der mit `foldl`][`foldl` muss die ganze Liste durchlaufen, bevor es den Akkumulator zurückgibt.],
  choice[Beide gleich schnell][Sie unterscheiden sich. Überlege, wie viele Elemente `head` jeweils braucht.],
)

#quiz(
  [Warum kann `foldr` manchmal mit unendlichen Listen umgehen, `foldl` aber nicht?],
  choice(correct: true)[`foldr` ruft `f` sofort auf, und `f` muss den Rest nicht auswerten][Genau. Wie Haskell dabei
    nur auswertet, was gebraucht wird, ist Thema der Laziness, die später in der Vorlesung kommt. `foldl` muss dagegen
    erst die ganze Liste durchlaufen.],
  choice[`foldr` läuft die Liste von hinten ab][Eine unendliche Liste hat kein Ende, bei dem man anfangen könnte.],
  choice[`foldl` akzeptiert keine unendlichen Listen als Typ][Der Typ erlaubt das. Das Problem zeigt sich erst bei der
    Auswertung.],
)

Jetzt bist du dran: Probier `foldl` und `foldr` an zwei Aufgaben aus.

#practice("fold-maximum", "foldl-vs-foldr")
