Die Signatur eines ADTs sagt, welche Funktionen es gibt und welche Typen sie
haben. Was sie bedeuten, sagt sie nicht: Ein `insert`, das sein Element
ignoriert, hätte denselben Typ wie das richtige. Die Bedeutung, die
_Semantik_, legen wir mit Gesetzen fest.

= Semantik durch Gesetze

Ein Gesetz ist eine Gleichung zwischen zwei Ausdrücken, die nur Funktionen des
ADTs und Variablen enthalten. Für Mengen zum Beispiel:

```haskell
isEmpty empty        == True
isEmpty (insert x s) == False
```

Gesetze beschreiben, wie die Funktionen zusammenspielen. Sie sagen nichts
darüber, _wie_ eine Funktion ihr Ergebnis berechnet. Insbesondere definieren
wir die Semantik nicht durch eine Implementierung: Eine Implementierung ist
nur eine von vielen, die die Gesetze erfüllen können, und sie legt
Einzelheiten fest, die für den ADT keine Rolle spielen sollen.

= Variablen sind allquantifiziert

Jede Variable in einem Gesetz steht für _alle_ Werte ihres Typs. Das Gesetz
```hs isEmpty (insert x s) == False``` heißt also: Für alle Elemente `x` und
alle Mengen `s` gilt ...

Ein Gesetz muss deshalb für jede typkorrekte Wahl der Variablen gelten. Und
umgekehrt soll es auch für alle diese Werte etwas aussagen: Gesetze sollen
allgemein sein.

```haskell
size (insert 3 empty) == 1   -- ein Testfall, kein Gesetz
```

Diese Gleichung stimmt, aber sie spricht über eine einzige Menge. Was für
`insert 4 empty` gilt oder für Mengen mit mehr Elementen, erfahren wir nicht.
Gesetze mit Variablen beschreiben dagegen das Verhalten für alle Werte auf
einmal.

#quiz(
  [Welches Gesetz sagt am meisten über `member` aus?],
  choice[`member 1 (insert 1 empty) == True`][Das stimmt, gilt aber nur für
    eine Zahl und eine Menge. Über `member 2 (insert 2 s)` sagt es nichts.],
  choice(correct: true)[`member x (insert x s) == True`][Genau: Es gilt für
    alle `x` und alle `s`, also auch für alle Mengen, die schon Elemente
    enthalten.],
  choice[`member x (insert x empty) == True`][Das ist schon allgemeiner, spricht
    aber nur über die leere Menge. `s` statt `empty` deckt alle Mengen ab.],
)

= Ein Gesetz für jeden Konstruktor

Jede Menge lässt sich mit `empty` und `insert` bauen. Wenn wir also wissen, was
ein Selektor für `empty` und für `insert x s` liefert, wissen wir es für jede
Menge. Daraus ergibt sich ein Rezept: Für jeden Selektor und jede Operation
schreiben wir ein Gesetz pro Konstruktor.

```haskell
member x empty        == False
member x (insert y s) == (x == y || member x s)

                      size empty        == 0
member xs s       ==> size (insert x s) == size s
not (member xs s) ==> size (insert x s) == size s + 1
```

Für Operationen geht es genauso:

```haskell
union empty t        == t
union (insert x s) t == insert x (union s t)

                delete x empty        == empty
x == y       => delete x (insert y s) == delete x s 
not (x == y) => delete x (insert y s) == insert y (delete x s)
```

Auf der rechten Seite darf ein Gesetz andere Funktionen des ADTs verwenden,
wie `member` im Gesetz für `size`, und dieselbe Funktion für einen kleineren
Wert, wie `size s`.

#remark[
  Warum nicht einfach ```hs delete x (insert x s) == s```? Weil `s` das
  Element `x` schon enthalten kann: Für `s = insert 1 empty` wäre
  ```hs delete 1 (insert 1 s)``` dann `s`, also eine Menge, die `1` noch
  enthält. Deshalb entfernt das Gesetz `x` auch aus `s`. Dass ein Ausdruck
  dasselbe Element mehrfach einfügen kann, sehen wir uns gleich an.
]

= Gesetze zwischen Konstruktoren

Die beiden Ausdrücke ```hs insert 1 (insert 2 empty)``` und
```hs insert 2 (insert 1 empty)``` sehen verschieden aus, beschreiben aber
dieselbe Menge {1, 2}. Auch ```hs insert 1 (insert 1 empty)``` ist dieselbe
Menge wie ```hs insert 1 empty```. Für Mengen gelten deshalb Gesetze, die nur
Konstruktoren enthalten:

```haskell
insert x (insert x s) == insert x s                 -- Duplikate zählen nicht
insert x (insert y s) == insert y (insert x s)      -- die Reihenfolge zählt nicht
```

Bei Listen gibt es solche Gesetze nicht: `[1, 2]` und `[2, 1]` sind
verschiedene Listen. Bei Mengen dagegen können verschiedene Ausdrücke denselben
Wert bezeichnen. Das hat Folgen dafür, was `==` bedeutet, siehe unten.

= Vollständig und widerspruchsfrei

Die Gesetze eines ADTs sollen das Verhalten _vollständig_ festlegen: Für jeden
Selektor und jede Operation ist klar, was sie für jeden Wert liefert, es sei
denn, wir lassen einen Fall bewusst offen (dazu gleich mehr). Das Rezept „ein
Gesetz pro Konstruktor" hilft dabei, keinen Fall zu vergessen.

Außerdem müssen sie _widerspruchsfrei_ sein: Es darf nicht möglich sein, mit
den Gesetzen für denselben Ausdruck zwei verschiedene Ergebnisse herzuleiten.
Mit den Gesetzen zwischen Konstruktoren passiert das schnell. Nimm an, wir
hätten das Gesetz für `size` einfacher geschrieben:

```haskell
size (insert x s) == size s + 1    -- zu einfach
```

#steps(
  step(label: "Der Ausdruck")[
    ```haskell
    size (insert 1 (insert 1 empty))
    ```
  ],
  step(label: "Weg 1: Zweimal das neue Gesetz")[
    ```haskell
    size (insert 1 (insert 1 empty))
    == size (insert 1 empty) + 1
    == (size empty + 1) + 1
    == 2
    ```
  ],
  step(label: "Weg 2: Erst Duplikate entfernen")[
    ```haskell
    size (insert 1 (insert 1 empty))
    == size (insert 1 empty)       -- insert x (insert x s) == insert x s
    == size empty + 1
    == 1
    ```
  ],
  step(label: "Widerspruch")[
    Derselbe Ausdruck hätte die Werte `2` und `1`. Die Gesetze widersprechen
    sich, und keine Implementierung kann sie alle erfüllen. Das Gesetz mit
    `if member x s ...` von oben vermeidet das.
  ],
)

= Was heißt `==` in einem Gesetz?

In Gesetzen wie ```hs union empty t == t``` vergleichen wir zwei Mengen. Was
heißt es, dass zwei Mengen gleich sind? Wir wissen ja nichts über ihre
Darstellung.

Es liegt nahe, `==` einfach als Vergleich der Darstellungen zu lesen. Nimm eine
Implementierung, die eine Menge als Liste speichert, bei der `insert` vorne
anhängt, und die `==` von Listen übernimmt (etwa mit `deriving Eq`). Dann gilt:

```haskell
insert 1 (insert 2 empty)   -- intern [1, 2]
insert 2 (insert 1 empty)   -- intern [2, 1]
```

`[1, 2] == [2, 1]` ist `False`, also wäre das Gesetz
```hs insert x (insert y s) == insert y (insert x s)``` verletzt, obwohl die
Implementierung als Menge völlig in Ordnung ist. Der Vergleich der
Darstellungen fragt nach etwas, das der ADT gar nicht festlegt.

Stattdessen verstehen wir `==` auf Werten eines ADTs _beobachtbar_: Zwei Werte
sind gleich, wenn kein Selektor sie unterscheiden kann. Für Mengen heißt das:
`s == t` genau dann, wenn ```hs member x s == member x t``` für alle `x` gilt.
Ob eine Implementierung die Werte intern gleich darstellt, spielt keine Rolle.

*Wichtig ist, wenn wir eine Gleichheit verwenden wollen, dann müssen wir wie
eben gesehen spezifizieren.*.

#quiz(
  [Eine Implementierung speichert Mengen als Listen ohne Duplikate, aber
  unsortiert. Zwei Mengen vergleicht sie mit `==` auf Listen. Was passiert?],
  choice[Alles in Ordnung, weil keine Duplikate vorkommen][Die Duplikate sind
    nicht das Problem, die Reihenfolge ist es: `[1, 2]` und `[2, 1]` sind
    verschiedene Listen, aber dieselbe Menge.],
  choice(correct: true)[Das Gesetz für die Reihenfolge scheint verletzt][Genau:
    `insert 1 (insert 2 empty)` und `insert 2 (insert 1 empty)` sind intern
    verschiedene Listen. Beobachtbar sind sie gleich, nur der Vergleich der
    Darstellungen unterscheidet sie.],
  choice[`member` liefert falsche Ergebnisse][`member` arbeitet richtig. Falsch
    ist nur der Vergleich, der mehr unterscheidet als der ADT.],
)

#remark[
  Vorsicht bei Selektoren, die mehr verraten als nötig. Hätte unser ADT eine
  Funktion `toList :: Set a -> [a]` ohne Gesetz über die Reihenfolge, könnte
  `toList` zwei gleiche Mengen unterscheiden, und zwei Implementierungen
  könnten verschiedene Listen liefern. Ein solcher Selektor braucht ein Gesetz,
  das die Reihenfolge festlegt (etwa: sortiert), oder er gehört nicht in den
  ADT.
]

= Wenn eine Funktion nicht immer ein Ergebnis hat

Manche Funktionen sind nicht für alle Werte sinnvoll. Nehmen wir für Mengen
mit vergleichbaren Elementen eine Operation hinzu, die das kleinste Element
liefert. Für die leere Menge gibt es keins. Es gibt drei übliche Wege, damit
umzugehen.

#tabs(
  label: "Umgang",
  tab("Vorbedingung")[
    ```haskell
    findMin :: Set a -> a

    findMin (insert x empty) == x
    not (isEmpty s) ==> findMin (insert x s) == min x (findMin s)
    ```
    Das Gesetz gilt nur für Werte, die die Bedingung links von `==>`
    erfüllen. Für alle anderen sagt es nichts.
  ],
  tab("Maybe")[
    ```haskell
    findMin :: Set a -> Maybe a

    findMin empty == Nothing
    findMin (insert x s) == case findMin s of
                              Nothing -> Just x
                              Just y  -> Just (min x y)
    ```
    Die Funktion ist für alle Mengen definiert, der Fehlerfall steckt im Typ.
    Wer `findMin` benutzt, muss ihn behandeln.
  ],
  tab("Bewusst offen")[
    ```haskell
    findMin :: Set a -> a

    findMin (insert x empty) == x
    not (isEmpty s) ==> findMin (insert x s) == min x (findMin s)
    -- kein Gesetz für findMin empty
    ```
    Über ```hs findMin empty``` sagt kein Gesetz etwas. Eine Implementierung
    darf dann tun, was sie will: einen Fehler melden, `0` liefern oder nicht
    terminieren. Wer `findMin empty` aufruft, kann sich auf nichts verlassen.
  ],
)

Die Vorbedingung und das bewusste Offenlassen gehen Hand in Hand: Weil das
zweite Gesetz nur für nichtleere `s` gilt und es kein Gesetz für
`findMin empty` gibt, ist der Fall der leeren Menge offen. Wichtig ist, dass
du dich entscheidest und es aufschreibst. Ein Gesetz ohne Vorbedingung, das
für die leere Menge nicht gelten kann, ist ein Fehler.

= Gesetze testen

Weil Gesetze Gleichungen mit allquantifizierten Variablen sind, kannst du sie
fast wörtlich als QuickCheck-Eigenschaften für eine Implementierung aufschreiben
(siehe #xref("quickcheck-eigenschaften")). So prüfst du, ob eine Implementierung
den ADT erfüllt. Er beschreibt, was gelten soll, und ist kein Testprogramm.

#practice(
  "adt-semantics",
  "adt-equality",
  "adt-law-values",
  "adt-law-properties",
  "adt-preconditions",
  "set-size-law",
)
