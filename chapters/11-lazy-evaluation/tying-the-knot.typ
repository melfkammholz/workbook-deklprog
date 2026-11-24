_In dieser Lektion betrachten wir Beispiele, in denen wir Lazy Evaluation 
gezielt einsetzen können, um Probleme zu lösen. Diese sind für den weiteren
Verlauf der Vorlesung eher unwichtig, veranschaulichen allerdings sehr gut,
wie Lazy Evaluation genutzt werden kann._

= Dynamische Programmierung am Beispiel der LCS

Bei dynamischer Programmierung merkt man sich Zwischenergebnisse in einer Tabelle.
In Haskell kann diese Tabelle sich _selbst_ benutzen: Die Einträge werden mit
Ausdrücken beschrieben, die auf andere Einträge derselben Tabelle zeigen, und Lazy
Evaluation sorgt dafür, dass jeder Eintrag erst berechnet wird, wenn ihn jemand
braucht. Dieses Muster heißt _Tying the Knot_.

Gesucht ist die Länge der längsten gemeinsamen Teilfolge (LCS) von zwei Listen
`xs` und `ys`, etwa `"haskell"` und `"pascal"`. Mit $n = $ `length xs` und $m = $
`length ys` ist $"lcs"(i, j)$ die Antwort für die Suffixe ab Position $i$ bzw. $j$:
$
"lcs"(i, j) = cases(
  0 & quad "falls" i = n "oder" j = m\,,
  1 + "lcs"(i + 1, j + 1) & quad "falls" x_i = y_j\,,
  max("lcs"(i + 1, j), "lcs"(i, j + 1)) & quad "sonst"
)
$
Direkt rekursiv aufgeschrieben wertet man dieselben $(i, j)$ exponentiell oft aus.
Mit einer Tabelle, die aus ihren eigenen Einträgen besteht, jeweils nur einmal:

```haskell
lcs :: Eq a => [a] -> [a] -> Int
lcs xs ys = table `at` (0, 0)
  where
    n = length xs
    m = length ys
    table = [[go i j | j <- [0 .. m]] | i <- [0 .. n]]
    go i j
      | i == n || j == m   = 0
      | xs !! i == ys !! j = 1 + table `at` (i + 1, j + 1)
      | otherwise          = max (table `at` (i + 1, j)) (table `at` (i, j + 1))

at :: [[a]] -> (Int, Int) -> a
at g (x, y) = g !! x !! y
```

`table` kommt in seiner eigenen Definition vor. Das ist kein Problem, solange
beim Aufbau der Tabelle noch keine Einträge ausgewertet werden: Die Liste von
Listen hat ihre Form (Länge $n + 1$ mal $m + 1$), die Einträge sind unausgewertete
Thunks `go i j`.

= Was beim Auswerten passiert

Wir verfolgen `lcs "ab" "b"`. Die Tabelle hat $3 times 2$ Einträge, anfangs alle
Thunks.

#steps(
  step(label: "Start")[
    Wir fragen `table !! 0 !! 0` an, also den Thunk `go 0 0`. Alle anderen Einträge
    bleiben unberührt.
  ],
  step(label: "Abhängigkeiten")[
    ```haskell
    go 0 0   -- 'a' /= 'b'
      == max (table !! 1 !! 0) (table !! 0 !! 1)
    ```
    `max` braucht beide Argumente. Damit werden `go 1 0` und `go 0 1` angestoßen.
  ],
  step(label: "Basisfall")[
    ```haskell
    go 0 1 == 0   -- j == m
    ```
    Hier endet die Kette: Basisfälle brauchen keinen weiteren Tabelleneintrag.
  ],
  step(label: "Der andere Zweig")[
    ```haskell
    go 1 0   -- 'b' == 'b'
      == 1 + table !! 2 !! 1
      == 1 + 0
    ```
    `go 2 1` ist wieder ein Basisfall.
  ],
  step(label: "Ergebnis")[
    ```haskell
    go 0 0 == max 1 0 == 1
    ```
    Jeder Thunk wurde höchstens einmal berechnet; ein zweites Mal liest man das
    gespeicherte Ergebnis.
  ],
)

#quiz(
  [Was passiert, wenn man in `lcs` den Basisfall `i == n || j == m = 0` weglässt?],
  choice(correct: true)[Die Rechnung läuft in `xs !! i` oder in einen Tabellenzugriff außerhalb der Liste und bricht mit einem Fehler ab][Genau: Ohne Basisfälle gibt es keinen Eintrag, der ohne weitere Tabellenzugriffe auskommt.],
  choice[Haskell findet den Basisfall selbst][Nein: Lazy Evaluation rechnet nur aus, was man hinschreibt.],
  choice[Die Tabelle wird unendlich groß][Nein: Ihre Form wird durch die beiden Listenkomprehensionen festgelegt.],
)

Es gilt also die Regel: Das Muster funktioniert, wenn die Abhängigkeiten der
Einträge keinen Kreis bilden und es Einträge ohne Abhängigkeiten gibt (hier die
Basisfälle). Die _Reihenfolge_ der Auswertung muss man nicht planen; sie ergibt
sich aus den Abhängigkeiten.

#practice("edit-distance", comments: ("edit-distance": [Dasselbe Muster mit der Editierdistanz.]))

= Zeiger in Haskell

Die Tabelle zeigt auf sich selbst. In C oder Java würde man dafür Zeiger
benutzen: Ein Knoten hält einen Verweis auf einen anderen Knoten, vielleicht
sogar auf sich selbst oder auf einen Vorgänger.

#compare(pairs: (link: "Der Verweis auf den anderen Knoten"),
  notes: (link: [Python setzt den Zeiger nachträglich. Haskell beschreibt beide Knoten in einem `let` und lässt sie aufeinander zeigen.]),
  [```py
  one, two = Node(1), Node(2)
  [[link|one.next, two.next = two, one]]
  ```],
  [```haskell
  let one = Node 1 [[link|two]]
      two = Node 2 [[link|one]]
  ```])

Dahinter steckt dieselbe Idee: Ein Wert in Haskell ist im Speicher ein Objekt, und
andere Werte können darauf zeigen. Weil `let` rekursiv ist und Konstruktoren lazy
sind, kann ein Wert auf sich selbst zeigen, ohne dass man ihn danach ändern muss.
Ein solcher Kreis ist eine zyklische Struktur. Der Unterschied zu C und Java ist,
dass man die Verweise nie ändert: Man beschreibt die fertige Struktur auf einmal.

Das lässt sich über Listen hinaus verallgemeinern, etwa zu doppelt verketteten
Listen, in denen Vorgänger und Nachfolger gegenseitig aufeinander zeigen.

#practice("cyclic-list", "doubly-linked")
