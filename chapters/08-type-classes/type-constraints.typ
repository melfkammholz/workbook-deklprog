Wie vergleichst du zwei Listen mit `==`? Elementweise, mit dem `==` der Elemente. Dafür muss das `==` der Elemente
existieren. Genau das drückt ein *Kontext* in einer Instanz aus.

= Instanzen für zusammengesetzte Typen

Die Klasse `Pretty` aus der letzten Lektion hat Instanzen für `Bool` und `Color`. Wir wollen jetzt auch Listen ausgeben,
und zwar aller Typen, die selbst `Pretty` sind. Ohne Kontext geht das nicht:

```haskell
instance Pretty [a] where
  pretty xs = ... map pretty xs ...   -- Fehler: für `a` gibt es kein `pretty`
```

Der Compiler kennt nichts über `a`. Mit einem Kontext sagen wir, was wir voraussetzen:

```haskell
instance Pretty a => Pretty [a] where
  pretty xs = "[" ++ intercalate ", " (map pretty xs) ++ "]"
```

Gelesen: „`[a]` ist `Pretty`, *wenn* `a` es ist.“ Das `pretty` auf der rechten Seite in `map pretty` ist das von `a`,
das `pretty` auf der linken Seite das von `[a]`. Es sind verschiedene Funktionen mit demselben Namen.

#quiz(
  [Gilt `pretty [Red, Blue]`?],
  choice(correct: true)[Ja][Genau. `Color` ist `Pretty`, also ist `[Color]` es auch.],
  choice[Nein, es fehlt eine Instanz für `[Color]`][Die Instanz `Pretty a => Pretty [a]` deckt jede Liste ab, deren
    Elementtyp `Pretty` ist.],
)

#quiz(
  [Gilt `pretty [not]`?],
  choice[Ja][Dafür müsste `Bool -> Bool` `Pretty` sein. Für Funktionstypen gibt es keine Instanz.],
  choice(correct: true)[Nein][Genau. Der Kontext `Pretty a` verlangt eine Instanz für den Elementtyp, und Funktionen
    haben keine.],
)

= Mehrere Voraussetzungen

Für Paare brauchen wir zwei Voraussetzungen, eine pro Komponente. Sie stehen in Klammern, durch Kommas getrennt:

```haskell
instance (Pretty a, Pretty b) => Pretty (a, b) where
  pretty (x, y) = "(" ++ pretty x ++ ", " ++ pretty y ++ ")"
```

So sieht es auch in der Standardbibliothek aus. Die Instanz für `Eq` ist im Kern:

```haskell
instance Eq a => Eq [a] where
  []     == []     = True
  (x:xs) == (y:ys) = x == y && xs == ys
  _      == _      = False

instance (Eq a, Eq b) => Eq (a, b) where
  (a, b) == (c, d) = a == c && b == d
```

#remark[
  Dasselbe steht in Signaturen. `elem :: Eq a => a -> [a] -> Bool` heißt: `elem` funktioniert für jeden Typ, der `Eq`
  hat. Der Teil vor `=>` ist auch dort der Kontext.
]

= Eigene polymorphe Typen

Besonders wichtig ist das bei eigenen Datentypen mit Typparameter:

```haskell
data Tree a = Empty | Node (Tree a) a (Tree a)

instance Pretty a => Pretty (Tree a) where
  pretty Empty        = "."
  pretty (Node l x r) = "(" ++ pretty l ++ " " ++ pretty x ++ " " ++ pretty r ++ ")"
```

Die Instanz ruft `pretty` auf drei Dingen auf: auf den beiden Teilbäumen und auf dem Wert `x :: a`. Die Teilbäume haben
den Typ `Tree a`, dafür ist die Instanz selbst zuständig (Rekursion). Für `x :: a` braucht sie `Pretty a`, und das steht
im Kontext.

#steps(
  step(label: "Aufruf")[
    ```haskell
    pretty (Node Empty True Empty)
    ```
    Der Typ ist `Tree Bool`, also gilt die Instanz für `Tree a` mit `a = Bool`.
  ],
  step(label: "Voraussetzung")[
    Der Kontext verlangt `Pretty Bool`. Die Instanz gibt es.
  ],
  step(label: "Ergebnis")[
    ```haskell
    "(" ++ pretty Empty ++ " " ++ pretty True ++ " " ++ pretty Empty ++ ")"
      == "(. ja .)"
    ```
  ],
)

#quiz(
  [Was passiert, wenn du in `instance Pretty a => Pretty (Tree a)` den Kontext weglässt?],
  choice[Nichts, der Compiler leitet ihn selbst her][Bei Instanzdeklarationen schreibst du den Kontext selbst. Der
    Compiler prüft ihn nur.],
  choice(correct: true)[Es gibt einen Fehler: für `pretty x` fehlt `Pretty a`][Genau. Der Compiler meldet, dass er
    keine Instanz für `Pretty a` findet.],
  choice[Die Instanz gilt dann für alle Bäume, auch für solche mit Funktionen][Im Gegenteil: ohne Kontext lässt sich
    `pretty x` nicht typisieren, die Instanz wird abgelehnt.],
)

#remark[
  In der Aufgabe zu `ToJSON` übst du genau das: Instanzen für `[a]`, `(a, b)` und `Tree a`, jeweils mit passendem Kontext.
]
