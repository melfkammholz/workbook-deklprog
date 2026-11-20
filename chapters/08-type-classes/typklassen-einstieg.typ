Bisher waren unsere polymorphen Funktionen *parametrisch*: `length :: [a] -> Int` macht für jedes `a` dasselbe. Manche
Funktionen sollen aber je nach Typ etwas anderes tun, etwa `==` oder `show`. Dafür gibt es Typklassen.

= Zwei Arten von Polymorphismus

#tabs(label: "Polymorphismus",
  tab("Parametrisch")[
    ```haskell
    length :: [a] -> Int
    swap   :: (a, b) -> (b, a)
    ```
    Eine Definition für alle Typen. Die Funktion kann nichts über `a` wissen und deshalb auch nichts mit den Werten
    anstellen, außer sie weiterzureichen.
  ],
  tab("Ad hoc (Typklassen)")[
    ```haskell
    (==)  :: Eq a   => a -> a -> Bool
    show  :: Show a => a -> String
    ```
    Eine Definition *pro Typ*: `show True` und `show [1, 2]` führen unterschiedlichen Code aus. Der Teil vor `=>` nennt
    die Voraussetzung an `a`.
  ],
)

= Die Rettung von `show`

Warum kann `show` nicht den Typ `a -> String` haben? Eine parametrische Funktion behandelt alle Typen gleich. Ein
`Bool` soll aber als `"True"` erscheinen und eine Liste in eckigen Klammern. Mit `Show a =>` sagt der Typ: „Für jeden
Typ, der eine `show`-Funktion hat.“ Welche, entscheidet der Compiler anhand des Typs.

#quiz(
  [Was bedeutet `Show a => a -> String`?],
  choice[`show` macht für alle Typen dasselbe][Das wäre parametrischer Polymorphismus, und der reicht für `show` nicht.],
  choice(correct: true)[`show` gibt es für jeden Typ `a`, der zur Klasse `Show` gehört, jeweils mit eigener Definition][Genau.
    Die Definition kommt aus der Instanz des Typs.],
  choice[`a` muss ein Zeichenkette sein][Die Klasse sagt nichts über die Gestalt von `a`, nur welche Funktionen es dafür gibt.],
)

= Klassen, die du kennst

#tabs(label: "Klasse",
  tab("Show")[
    Werte als Text ausgeben: `show :: Show a => a -> String`.
  ],
  tab("Eq")[
    Auf Gleichheit prüfen: `(==), (/=) :: Eq a => a -> a -> Bool`.
  ],
  tab("Ord")[
    Vergleichen und sortieren: `compare`, `(<)`, `max`, … Jeder `Ord`-Typ ist auch `Eq`.
  ],
  tab("Num")[
    Rechnen: `(+)`, `(*)`, `fromInteger`. Darum sind Literale wie `3` für `Int` und `Double` gleichermaßen möglich.
  ],
)

Typklassen *ermöglichen* damit Funktionen wie `sort :: Ord a => [a] -> [a]` oder `elem :: Eq a => a -> [a] -> Bool`: eine
Definition, die nur voraussetzt, dass es die nötigen Vergleiche gibt.

#open-question(
  [Welche Funktion von `Ord a => [a] -> [a]` würde mit `[a] -> [a]` nicht mehr funktionieren?],
  answer: [`sort`: ohne `Ord` kann sie zwei Elemente nicht vergleichen. Eine Funktion `[a] -> [a]` kann Elemente nur
    umordnen, ohne sie anzusehen, oder weglassen und vervielfachen.],
)

= Wie es weitergeht

Im nächsten Schritt schreibst du `class` und `instance` selbst.
