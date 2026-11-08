Bei einem rekursiven Typ kommt der Typ selbst in den Feldern seiner Konstruktoren vor. Das Verfahren aus der ersten
Lektion bleibt gleich, und es kommt genau ein Schritt dazu. Dafür gewinnst du etwas: Die Rekursion steckt dann in der
Faltung, und du musst sie nicht mehr selbst schreiben.

= Funktionen durch Induktion über den Datentyp

Auf Listen definierst du Funktionen oft durch Induktion: eine Gleichung für `[]` und eine für `(:)`, die den rekursiven
Aufruf auf dem Rest benutzt. Unten stehen drei solche Funktionen. Gehe die Schritte durch und frage dich, was an ihnen
gleich ist und was nicht.

#steps(
  step(label: "Drei Funktionen")[
    ```
    sum :: [Int] -> Int
    sum []       = 0
    sum (x : xs) = x + sum xs

    length :: [Int] -> Int
    length []       = 0
    length (x : xs) = 1 + length xs

    allEven :: [Int] -> Bool
    allEven []       = True
    allEven (x : xs) = even x && allEven xs
    ```
  ],
  step(label: "Gleich und verschieden")[
    Alle drei sind durch Induktion über die Liste definiert. Die Muster links sind gleich, und der rekursive Aufruf auf
    dem Rest `xs` ist es auch. Verschieden ist, was bei `[]` herauskommt und wie das Element mit dem Ergebnis des
    rekursiven Aufrufs verbunden wird:

    #table(
      columns: 4,
      table.header([Funktion], [bei `[]`], [bei `x : xs`], [Ergebnistyp]),
      [`sum`], [`0`], [`x + (sum xs)`], [`Int`],
      [`length`], [`0`], [`1 + (length xs)`], [`Int`],
      [`allEven`], [`True`], [`even x && (allEven xs)`], [`Bool`],
    )
  ],
  step(label: "Parameter statt Antworten")[
    Mit Parametern sind die drei Funktionen gleich. `fnil` ist die Antwort für die leere Liste. `fcons` bekommt das
    Element und das Ergebnis des rekursiven Aufrufs. Der Ergebnistyp wird zur Typvariable `r`.

    ```
    f :: [a] -> r
    f []       = fnil
    f (x : xs) = fcons x (f xs)
    ```
  ],
  step(label: "Die Faltung")[
    Das gemeinsame Gerüst ist `foldr`. Der rekursive Aufruf steht jetzt genau einmal, in `foldr` selbst. Du schreibst
    ihn nicht mehr in jeder Funktion.

    ```
    foldr :: (a -> r -> r) -> r -> [a] -> r
    foldr fcons fnil []       = fnil
    foldr fcons fnil (x : xs) = fcons x (foldr fcons fnil xs)

    sum     = foldr (+) 0
    length  = foldr (\_ y -> 1 + y) 0
    allEven = foldr (\x y -> even x && y) True
    ```
  ],
)

Die Faltung ist die gemeinsame Form solcher Definitionen. Wie sie aus dem Datentyp entsteht, sehen wir jetzt.

= Eine Liste ist ein Baum aus Konstruktoren

Die Liste `[3, 7]` ist eine Kurzform für `3 : (7 : [])`. Als Baum gezeichnet sind die inneren Knoten `(:)`, und ganz
unten steht `[]`.

Die Faltung `foldr fcons fnil` ersetzt jedes `(:)` durch `fcons` und das `[]` durch `fnil`. Mehr passiert nicht. Was
herauskommt, hängt nur davon ab, was du einsetzt. Wähle eine Faltung, sag das Ergebnis voraus und falte dann.

#fold-steps(
  "data [a] = a : [a] | []",
  "[3, 7]",
  type: "[Int]",
  predict: ("[3,7]", "10", "2", "3", "7"),
  folds: (
    (name: "Summe", functions: ("(:)": "(+)", "[]": "0")),
    (name: "Länge", functions: ("(:)": "const succ", "[]": "0")),
    (name: "Identität", functions: ("(:)": "(:)", "[]": "[]")),
    (name: "Erstes Element", functions: ("(:)": "const", "[]": "error \"empty list\"")),
  ),
)

Unter dem Baum steht dieselbe Rechnung als Ausdruck. Im ersten Schritt tauscht die Faltung jeden Konstruktor gegen den
Wert aus, den du für `fcons` und `fnil` eingesetzt hast. Gerechnet wird erst danach.

#remark[
  Das Bild zeigt, welches Ergebnis von welchem abhängt, darum läuft es von unten nach oben. Die Reihenfolge, in der
  Haskell rechnet, ist eine andere: Haskell beginnt außen und wertet nur aus, was gebraucht wird (Laziness, dazu später
  mehr). Darum stürzt die Faltung „Erstes Element“ nicht ab, obwohl der Wert für `fnil` ein `error` ist. Wo beide Wege
  ein Ergebnis liefern, ist es dasselbe.
]

= Warum die Identität herauskommt

Eine Faltung ersetzt Konstruktoren. Was passiert, wenn du jeden Konstruktor durch sich selbst ersetzt? Probiere es an
einem Wert aus.

#wide[
#tabs(
  label: "Datentyp",
  tab("[a]")[
    #fold-tree("data [a] = a : [a] | []", "[3, 7]", type: "[Int]", functions: ("(:)": "(:)", "[]": "[]"))
  ],
  tab("Tree a b")[
    #fold-tree(
      "data Tree a b = Empty | Leaf a | Node b [Tree a b]",
      "Node \"x\" [Leaf 3, Node \"y\" [Leaf 4, Empty], Leaf 5]",
      type: "Tree Int String",
      functions: (Empty: "Empty", Leaf: "Leaf", Node: "Node"),
    )
  ],
)
]

Der Baum bleibt unverändert. Darum sind `foldr (:) []` auf Listen und `foldTree Empty Leaf Node` auf Bäumen die
Identität. Für jeden Datentyp gilt: Die Faltung, die jeden Konstruktor durch sich selbst ersetzt, ist die Identität.
Das ist ein guter Test für jede Faltung, die du schreibst.

= Die Signatur von foldr

Die Signatur bekommen wir mit denselben Schritten wie bei `Maybe`. Neu ist nur, dass der Typ `[a]` auch in einem Feld
von `(:)` vorkommt. Auch dieses Vorkommen wird zum Ergebnistyp. Es steht für den schon gefalteten Rest der Liste.

#fold-signature("data [a] = a : [a] | []", fold: "foldr")

#remark[
  Die Deklaration von `[a]` ist nur zur Anschauung so geschrieben: Listen sind in Haskell eingebaut. Neben `foldr`
  gibt es für Listen auch `foldl`. Sie folgt nicht dem Verfahren und bekommt darum eine eigene Lektion.
]

= Wo ist die Rekursion geblieben?

Eine induktiv definierte Funktion hat oft eine Regel pro Konstruktor, und `foldr` hat eine Funktion pro Konstruktor.
Beide Definitionen unten berechnen die Länge. Wähle aus, was du vergleichen willst.

#compare(
  pairs: (nil: "Die leere Liste", cons: "Das Element", rec: "Der rekursive Aufruf"),
  notes: (
    nil: [Der Fall `[]` wird zu `fnil`. Die Regel bleibt gleich.],
    cons: [Der Fall `(:)` wird zu `fcons`. Das `1 +` bleibt, wo es war.],
    rec: [Links steht der Aufruf im Code. Rechts ist nur noch sein Ergebnis da: `y`. Die Rekursion steckt in `foldr`.],
  ),
  [```
    length :: [a] -> Int
    length []       = [[nil|0]]
    length (x : xs) = [[cons|1 +]] [[rec|length xs]]
    ```],
  [```
    length :: [a] -> Int
    length xs = foldr fcons fnil xs
      where
        fnil = [[nil|0]]
        fcons x y = [[cons|1 +]] [[rec|y]]
    ```],
)

Die Faltung versteckt den rekursiven Aufruf. In deiner Funktion taucht nur noch sein Ergebnis auf. Hier stehen `fnil`
und `fcons` nur, um den Zusammenhang zu zeigen. Im Alltag schreibst du beide direkt hinein:
`length = foldr (\_ y -> 1 + y) 0`.

= Derselbe Weg für Bäume

Der folgende Baum hat Blätter und beschriftete Knoten mit beliebig vielen Kindern. Darum steckt der Typ selbst in einer
Liste. Das ändert an den Schritten nichts: Auch dort wird `Tree a b` zum Ergebnistyp, und die Liste bleibt stehen.

#wide(fold-signature("data Tree a b = Empty | Leaf a | Node b [Tree a b]"))

= Woher kommt die Liste `[r]`?

Beim Gerüst passt alles wie gewohnt, bis auf eine Stelle. In der Zeile für `Node` haben wir die Teilbäume `ts`, aber
`fnode` will ihre schon gefalteten Ergebnisse.

Die Faltung selbst kann einen einzelnen Baum falten. Damit wir die drei Funktionen nicht jedes Mal mitschreiben müssen,
geben wir der teilweise angewendeten Faltung einen Namen: `foldTree'`. Jetzt lies die Typen und such das fehlende Stück.

```
foldTree fempty fleaf fnode value =
  case value of
    Empty     -> fempty
    Leaf x    -> fleaf x
    Node x ts -> fnode x (???)
  where
    foldTree' = foldTree fempty fleaf fnode
```

#quiz(
  [Was macht aus den Teilbäumen `ts :: [Tree a b]` die Liste `[r]`, die `fnode` erwartet?],
  choice[`foldTree' ts`][`foldTree' :: Tree a b -> r` faltet einen einzelnen Baum. `ts` ist aber eine Liste von
    Bäumen.],
  choice(correct: true)[`map foldTree' ts`][Genau. `map` schickt jeden Teilbaum einzeln durch `foldTree'`, und aus
    jedem wird ein `r`. Das ist der rekursive Aufruf. Dass wir `map` brauchen, sagen uns allein die Typen:
    `(a -> b) -> [a] -> [b]`.],
  choice[`map fnode ts`][`fnode :: b -> [r] -> r` braucht die schon gefalteten Ergebnisse, keinen Baum. So würde nichts
    gefaltet.],
  choice[`ts`][Das hat noch den Typ `[Tree a b]`. Die Teilbäume müssen erst gefaltet werden.],
)

Diese Überlegung ist der einzige neue Schritt: Wo ein Feld den Typ selbst enthält, musst du die Faltung anwenden, und
die Typen zeigen dir, wie. Bei `foldr` ist es nur der Aufruf auf dem Rest der Liste, beim Baum kommt `map` dazu.

#remark[
  `map` ist dabei ein Spezialfall. Allgemein hat `fmap :: (a -> b) -> f a -> f b` diesen Typ, und `f` ist hier der
  Listentyp. Die Hilfsfunktion `foldTree'` lohnt sich vor allem, wenn der Typ an mehreren Stellen rekursiv vorkommt:
  Dann müsstest du `foldTree fempty fleaf fnode` jedes Mal ausschreiben.
]

= Der Baum faltet sich zusammen

So läuft die fertige Faltung auf einem Baum ab. Auch hier wird jeder Konstruktor ersetzt: `Empty` durch `fempty`,
`Leaf` durch `fleaf`, `Node` durch `fnode`. Jeder Teilbaum wird zu einem Ergebnis, und `fnode` bekommt die Ergebnisse
seiner Kinder als Liste. Bevor ein Knoten angewendet wird, vereinfacht sich, was schon geht: `(\_ -> sum) "y"` ist
einfach `sum`. Wähle eine Faltung und spiele sie ab.

#fold-steps(
  "data Tree a b = Empty | Leaf a | Node b [Tree a b]",
  "Node \"x\" [Leaf 3, Node \"y\" [Leaf 4, Empty], Leaf 5]",
  type: "Tree Int String",
  folds: (
    (name: "Blätter zählen", functions: (Empty: "0", Leaf: "const 1", Node: "\\_ -> sum")),
    (name: "Blätter addieren", functions: (Empty: "0", Leaf: "id", Node: "\\_ -> sum")),
    (name: "Höhe", functions: (Empty: "0", Leaf: "const 1", Node: "\\_ rs -> 1 + maximum (0 : rs)")),
    (name: "Knotennamen", functions: (Empty: "[]", Leaf: "const []", Node: "\\x rs -> x : concat rs")),
  ),
)

Vergleiche die Faltungen miteinander: Der Baum und das Verfahren bleiben gleich, nur die drei Funktionen ändern sich.

= Verständnisfragen

#quiz(
  [Was ist `foldTree Empty Leaf Node`?],
  choice(correct: true)[Die Identität auf `Tree a b`][Genau, wie schon bei `foldMaybe Nothing Just`.],
  choice[Eine Funktion, die alle Blätter entfernt][Hier wird jeder Konstruktor durch sich selbst ersetzt. Was ändert
    sich dadurch?],
  choice[Ein Typfehler][Mit dem Ergebnistyp `Tree a b` passen alle drei Argumente.],
)

#quiz(
  [Welche Funktion, die du schon kennst, entspricht der natürlichen Faltung auf Listen?],
  choice(correct: true)[`foldr`][Genau: `foldr` hat eine Funktion pro Konstruktor von `[a]`.],
  choice[`foldl`][`foldl` tauscht keine Konstruktoren aus. Es läuft mit einem Akkumulator durch die Liste.],
  choice[`map`][`map` bekommt nur eine Funktion. Die natürliche Faltung braucht eine pro Konstruktor, also zwei.],
)

#quiz(
  [Wie bekommst du aus `foldr` die Identität auf Listen?],
  choice[`foldr (:) [0]`][Das hängt am Ende noch eine `0` an.],
  choice(correct: true)[`foldr (:) []`][Genau: Jeder Konstruktor wird durch sich selbst ersetzt.],
  choice[`foldr (flip (:)) []`][`flip (:)` hat den Typ `[a] -> a -> [a]`, `foldr` erwartet `a -> [a] -> [a]`. Das ist
    ein Typfehler.],
)

= Das Verfahren

Das ist jetzt das vollständige Verfahren. Es gilt für jeden algebraischen Datentyp: Ohne Rekursion entfällt Schritt 5,
alles andere bleibt gleich.

#recipe(
  step(label: "Konstruktortypen aufschreiben")[Jeder Konstruktor ist eine Funktion. Schreibe seinen Typ auf.],
  step(label: "Den Typ durch den Ergebnistyp ersetzen")[Ersetze jedes Vorkommen des Typs, den du faltest, durch den
    Ergebnistyp, hier `r`. So entsteht der Typ der Funktion für diesen Konstruktor.],
  step(label: "Signatur bauen")[Erst eine Funktion pro Konstruktor, dann der Wert, dann der Ergebnistyp.],
  step(label: "Gerüst schreiben")[Ein `case`-Ausdruck mit einer Zeile pro Konstruktor. Jede Zeile übergibt die Felder an
    ihre Funktion.],
  step(label: "Rekursive Felder falten")[Enthält ein Feld den Typ selbst, wird es zuerst gefaltet. Das füllt die Lücke
    aus Schritt 4. Die Typen sagen dir, wie. Eine Hilfsfunktion erspart das Wiederholen der Argumente.],
  example(
    "[a]",
    ```
    (:) :: a -> [a] -> [a]
    []  :: [a]
    ```,
    ```
    fcons :: a -> r -> r
    fnil  :: r
    ```,
    ```
    foldr :: (a -> r -> r) -> r -> [a] -> r
    ```,
    ```
    foldr fcons fnil value =
      case value of
        x : xs -> fcons x ?
        []     -> fnil
    ```,
    ```
        x : xs -> fcons x (foldr' xs)
      where
        foldr' = foldr fcons fnil
    ```,
  ),
  example(
    "Tree a b",
    ```
    Empty :: Tree a b
    Leaf  :: a -> Tree a b
    Node  :: b -> [Tree a b] -> Tree a b
    ```,
    ```
    fempty :: r
    fleaf  :: a -> r
    fnode  :: b -> [r] -> r
    ```,
    ```
    foldTree :: r -> (a -> r) -> (b -> [r] -> r)
             -> Tree a b -> r
    ```,
    ```
    foldTree fempty fleaf fnode value =
      case value of
        Empty     -> fempty
        Leaf x    -> fleaf x
        Node x ts -> fnode x ?
    ```,
    ```
        Node x ts -> fnode x (map foldTree' ts)
      where
        foldTree' = foldTree fempty fleaf fnode
    ```,
  ),
)

*Zur Kontrolle:* Auch hier muss die Identität herauskommen, wenn du die Konstruktoren selbst übergibst:
`foldTree Empty Leaf Node t == t`.

#practice("fold-labeled-tree")
