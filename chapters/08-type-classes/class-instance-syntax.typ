Typklassen kennst du schon von `Show`, `Eq` und `Ord`. Hier schreibst du eine eigene: erst die Syntax von `class` und
`instance`, dann Standardmethoden.

= Eine Klasse deklarieren

Eine Klasse legt fest, welche Funktionen ein Typ anbieten muss, damit er dazugehört. Wir wollen Werte als Text
ausgeben, aber so, wie wir es wollen und nicht wie `show`.

```haskell
class Pretty a where
  pretty :: a -> String
```

Gelesen: „Ein Typ `a` ist `Pretty`, wenn es eine Funktion `pretty :: a -> String` für ihn gibt.“ Die Klasse enthält
nur die *Signatur*. Was `pretty` tut, steht erst in den Instanzen.

= Instanzen schreiben

Eine Instanz sagt, wie ein bestimmter Typ die Methoden umsetzt.

```haskell
data Color = Red | Green | Blue

instance Pretty Bool where
  pretty True  = "ja"
  pretty False = "nein"

instance Pretty Color where
  pretty Red   = "rot"
  pretty Green = "grün"
  pretty Blue  = "blau"
```

Jetzt ist `pretty` überladen: `pretty True` ergibt `"ja"` und `pretty Blue` ergibt `"blau"`. Welche Definition gilt,
entscheidet der Typ des Arguments. Für einen Typ ohne Instanz, etwa `pretty 'x'`, meldet der Compiler einen Fehler.

#quiz(
  [Was steht hinter `where` in einer `class`-Deklaration?],
  choice[Die Definitionen, die für alle Typen gelten][Die stehen in den Instanzen, und dort für jeden Typ eigene.],
  choice(correct: true)[Die Signaturen der Methoden][Genau. Die Klasse sagt nur, welche Funktionen mit welchem Typ es geben muss.],
  choice[Die Liste der Typen, die zur Klasse gehören][Die Typen kommen durch ihre `instance`-Deklarationen dazu, nicht durch die Klasse.],
)

= Standardmethoden

Eine Klasse darf zu einer Methode eine Definition mitbringen. Instanzen können sie überschreiben, müssen es aber nicht.

```haskell
import Data.List (intercalate)

class Pretty a where
  pretty     :: a -> String
  prettyList :: [a] -> String
  prettyList xs = "[" ++ intercalate ", " (map pretty xs) ++ "]"
```

`prettyList` ist über `pretty` definiert und funktioniert deshalb für jede Instanz sofort:

```haskell
prettyList [Red, Blue]   -- "[rot, blau]"
```

Eine Instanz kann sie überschreiben, wenn es für den Typ etwas Besseres gibt:

```haskell
instance Pretty Bool where
  pretty True  = "ja"
  pretty False = "nein"
  prettyList bs = show (length (filter id bs)) ++ " mal ja"
```

Wichtig ist, was eine Instanz mindestens definieren muss. Das sind die Methoden ohne Standarddefinition. Bei `Eq` gibt
es zwei Methoden, `(==)` und `(/=)`, die jeweils mit der anderen definiert sind. Du schreibst eine davon, die andere
kommt gratis. Wenn du beide weglässt, würden sie sich gegenseitig aufrufen und nie enden. Darum nennt die Dokumentation
einer Klasse die „minimale vollständige Definition“ (`MINIMAL`).

#quiz(
  [In `Pretty` hat `prettyList` eine Standarddefinition, `pretty` nicht. Was muss `instance Pretty Color` mindestens
  enthalten?],
  choice(correct: true)[Nur `pretty`][Genau. `prettyList` kommt aus dem Standard und ruft dein `pretty` auf.],
  choice[Nur `prettyList`][Der Standard von `prettyList` braucht `pretty`. Ohne `pretty` gibt es nichts, was er aufrufen
    könnte.],
  choice[Beide Methoden][Das ist erlaubt, aber nicht nötig. Der Standard genügt.],
)

= Zusammengefasst

#steps(
  step(label: "Klasse")[
    ```haskell
    class Pretty a where
      pretty :: a -> String
    ```
    Signaturen, optional mit Standarddefinitionen.
  ],
  step(label: "Instanz")[
    ```haskell
    instance Pretty Color where
      pretty Red = "rot"
      ...
    ```
    Für einen Typ die Methoden definieren, die der Standard nicht abdeckt.
  ],
  step(label: "Benutzung")[
    ```haskell
    pretty Blue   -- "blau"
    ```
    Der Typ des Arguments wählt die Instanz aus.
  ],
)

Bisher hatten alle Instanzen einfache Typen wie `Bool` oder `Color`. Was passiert bei `Tree a` oder `[a]`? Das klärt
die nächste Lektion.
