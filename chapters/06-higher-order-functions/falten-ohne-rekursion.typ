Viele Funktionen auf einem Datentyp sehen gleich aus: Sie unterscheiden die Konstruktoren und geben für jeden eine
Antwort. Eine Faltung macht aus diesem Muster eine einzige Funktion. Hier leiten wir Faltungen Schritt für Schritt aus
dem Datentyp her, zuerst für Typen ohne Rekursion.

= Eine Gleichung pro Konstruktor

Funktionen auf einem Datentyp definierst du oft mit einer Gleichung pro Konstruktor. Unten stehen drei Funktionen auf
`Maybe Int`. Gehe die Schritte durch und achte darauf, was sich ändert und was gleich bleibt.

#steps(
  step(label: "Drei Funktionen")[
    ```
    fromMaybe0 :: Maybe Int -> Int
    fromMaybe0 Nothing  = 0
    fromMaybe0 (Just x) = x

    isJust :: Maybe Int -> Bool
    isJust Nothing  = False
    isJust (Just x) = True

    describe :: Maybe Int -> String
    describe Nothing  = "none"
    describe (Just x) = "value " ++ show x
    ```
  ],
  step(label: "Gleich und verschieden")[
    Jede Funktion hat eine Gleichung pro Konstruktor von `Maybe`. Die Muster links sind bei allen gleich. Verschieden
    sind nur die rechten Seiten und der Ergebnistyp:

    #table(
      columns: 4,
      table.header([Funktion], [bei `Nothing`], [bei `Just x`], [Ergebnistyp]),
      [`fromMaybe0`], [`0`], [`x`], [`Int`],
      [`isJust`], [`False`], [`True`], [`Bool`],
      [`describe`], [`"none"`], [`"value " ++ show x`], [`String`],
    )
  ],
  step(label: "Parameter statt Antworten")[
    Ersetzen wir die verschiedenen Teile durch Parameter, sind alle drei Funktionen gleich. Die Antwort für `Nothing`
    heißt `fnothing`, die für `Just x` hängt von `x` ab und ist darum eine Funktion `fjust`. Der Ergebnistyp wird zur
    Typvariable `r`.

    ```
    f :: Maybe Int -> r
    f Nothing  = fnothing
    f (Just x) = fjust x
    ```
  ],
  step(label: "Die Faltung")[
    Das gemeinsame Gerüst ist die Faltung. Jede der drei Funktionen ist nur noch ein Aufruf mit anderen Parametern.

    ```
    foldMaybe :: r -> (a -> r) -> Maybe a -> r
    foldMaybe fnothing fjust value =
      case value of
        Nothing -> fnothing
        Just x  -> fjust x

    fromMaybe0 = foldMaybe 0 id
    isJust     = foldMaybe False (const True)
    describe   = foldMaybe "none" (\x -> "value " ++ show x)
    ```
  ],
)

Diese Idee steckt hinter jeder Faltung: Wir definieren Funktionen über die Konstruktoren eines Datentyps und ziehen
heraus, was allen Definitionen gemeinsam ist. Bei rekursiven Typen wie Listen kommt die Induktion dazu, das sehen wir
in der nächsten Lektion.

= Was eine Faltung tut

Ein `Maybe`-Wert ist entweder `Nothing` oder `Just x`. Eine Funktion auf `Maybe` muss also zwei Fragen beantworten: Was
kommt bei `Nothing` heraus, und was bei `Just x`? Die Faltung `foldMaybe` bekommt genau diese beiden Antworten als
Argumente: einen Wert für `Nothing` und eine Funktion für den Inhalt von `Just`. Wähle unten einen Ergebnistyp und
setze beide Argumente ein. Dann siehst du, welche Zeile für welchen Wert antwortet.

#fold-explorer(
  "data Maybe a = Nothing | Just a",
  type: "Maybe Int",
  values: ("Nothing", "Just 3", "Just 8"),
  results: (
    (type: "Int", Nothing: ("0", "100"), Just: ("x + 1", "x * 2")),
    (type: "String", Nothing: ("\"empty\"", "\"-\""), Just: ("show x", "show x ++ \"!\"")),
    (type: "Bool", Nothing: ("False", "True"), Just: ("x > 5", "even x")),
  ),
)

Der Wert entscheidet, welcher Fall antwortet. Du entscheidest, was jeder Fall antwortet. Das Ergebnis kann jeden Typ haben, darum nennen wir den Ergebnistyp
einfach `r`.

#quiz(
  [Welchen Ergebnistyp hat `foldMaybe "-" show (Just 3)`?],
  choice[`Int`][`3` ist der Inhalt, also `a = Int`. Das Ergebnis ist das, was `show` und `"-"` liefern.],
  choice(correct: true)[`String`][Genau. Beide Antworten sind Strings, also ist der Ergebnistyp `String`.],
  choice[`Maybe String`][Die Faltung packt aus. Es kommt kein `Maybe` mehr heraus.],
)

= Die Signatur steckt im Datentyp

Den Typ von `foldMaybe` müssen wir uns nicht ausdenken. Wir lesen ihn am Datentyp ab, und das geht bei jedem Datentyp
gleich, in drei Schritten:

+ *Konstruktortypen aufschreiben.* Ein Konstruktor ist eine Funktion, die einen Wert des Datentyps baut. Seine Felder
  sind die Argumente, der Datentyp ist das Ergebnis.
+ *Den Typ durch den Ergebnistyp ersetzen.* Die Faltung soll keinen `Maybe`-Wert bauen, sondern ein Ergebnis von
  beliebigem Typ, hier `r`. Darum ersetzen wir jedes Vorkommen von `Maybe a` durch den Ergebnistyp. Was dann dasteht, ist der Typ der Funktion, die den Konstruktor ersetzt.
+ *Signatur bauen.* Erst eine Funktion pro Konstruktor, dann der Wert, den wir falten, dann der Ergebnistyp.

Bei `Maybe` stehen die Konstruktortypen aus Schritt 1 schon da. Jeder Konstruktor hat eine Farbe, von der Deklaration
bis in die Signatur.

#fold-signature("data Maybe a = Nothing | Just a", given: true)

#remark[
  Die Typen aus Schritt 1 stehen in der GADT-Schreibweise direkt am Konstruktor. Für das Verfahren brauchst du sie
  nicht, sie macht die Signaturen aber sichtbar.

  ```
  data Maybe a where
    Nothing :: Maybe a
    Just    :: a -> Maybe a
  ```
]

= Der Code folgt den Typen

Das Gerüst ist immer gleich: ein `case`-Ausdruck mit einer Zeile pro Konstruktor. Die Felder eines Konstruktors werden
an seine Funktion übergeben. Die Parameter benennen wir nach dem Konstruktor, also `f` plus Konstruktorname.

```
foldMaybe :: r -> (a -> r) -> Maybe a -> r
foldMaybe fnothing fjust value =
  case value of
    Nothing -> fnothing
    Just x  -> ???
```

#quiz(
  [Was kommt in die Lücke?],
  choice(correct: true)[`fjust x`][Genau. Das Ergebnis muss den Ergebnistyp haben, und nur die übergebenen Funktionen
    können so einen Wert erzeugen. Darum führen die Typen dich fast von selbst zum Code.],
  choice[`x`][`x` hat den Typ `a`. Das Ergebnis muss aber den Ergebnistyp `r` haben.],
  choice[`fjust`][`fjust` hat den Typ `a -> r`. Es fehlt noch sein Argument.],
  choice[`Just (fjust x)`][Das hätte den Typ `Maybe r`. Die Faltung soll aber ein Ergebnis vom Typ `r` liefern.],
)

= Selbst anwenden: Either

Bei `Either` gehen wir genauso vor, diesmal von Anfang an selbst: Setze die Konstruktortypen zusammen, ersetze den
Datentyp durch den Ergebnistyp und baue die Signatur von `foldEither` aus den Teilen.

#fold-signature("data Either a b = Left a | Right b")

Beide Faltungen gibt es schon im Prelude: `foldEither` heißt dort `either` und `foldMaybe` heißt `maybe`.

= Sanity Check: die Identität

Übergibst du als Funktionen die Konstruktoren selbst, muss die Faltung den Wert unverändert lassen. Das ist ein
einfacher Test für jede Faltung, die du schreibst.

#tabs(
  label: "Datentyp",
  tab("Maybe a")[
    #fold-tree("data Maybe a = Nothing | Just a", "Just 3", type: "Maybe Int", functions: (Nothing: "Nothing", Just: "Just"))
  ],
  tab("Either a b")[
    #fold-tree(
      "data Either a b = Left a | Right b",
      "Left 3",
      type: "Either Int String",
      fold: "foldEither",
      functions: (Left: "Left", Right: "Right"),
    )
  ],
)

Jeder Konstruktor bleibt, wo er ist. Darum ist `foldMaybe Nothing Just` die Identität auf `Maybe a`.

= Verständnisfragen

#quiz(
  [Was ergibt `foldMaybe 0 (+ 1) (Just 41)`?],
  choice[`0`][`0` ist die Antwort für `Nothing`. Hier liegt aber ein `Just` vor.],
  choice[`41`][Die Funktion `(+ 1)` wird noch auf den Inhalt angewendet.],
  choice(correct: true)[`42`][Genau: Der Inhalt `41` geht an `(+ 1)`.],
  choice[`Just 42`][Das Ergebnis hat den Ergebnistyp, hier also eine Zahl ohne `Just`.],
)

#quiz(
  [Was ergibt `foldEither length negate (Left "abc")`?],
  choice(correct: true)[`3`][Genau: `Left` antwortet mit `length`.],
  choice[`-3`][`negate` ist die Antwort für `Right`.],
  choice[`"abc"`][Der Inhalt wird noch an `length` übergeben.],
)

#quiz(
  [Was ist `foldMaybe Nothing Just`?],
  choice(correct: true)[Die Identität auf `Maybe a`][Genau. Ersetzt du jeden Konstruktor durch sich selbst, kommt der
    Wert unverändert heraus.],
  choice[Eine Funktion, die immer `Nothing` liefert][Probiere es mit `Just 3` aus: Welche Zeile im `case` greift?],
  choice[Ein Typfehler][Mit `r = Maybe a` passen alle Typen.],
)

= Das Verfahren

Für jeden Typ ohne Rekursion reichen diese vier Schritte. Wähle ein Beispiel, um sie nachzuvollziehen.

#recipe(
  step(label: "Konstruktortypen aufschreiben")[Jeder Konstruktor ist eine Funktion. Schreibe seinen Typ auf.],
  step(label: "Den Typ durch den Ergebnistyp ersetzen")[Ersetze jedes Vorkommen des Typs, den du faltest, durch den
    Ergebnistyp, hier `r`. So entsteht der
    Typ der Funktion für diesen Konstruktor.],
  step(label: "Signatur bauen")[Erst eine Funktion pro Konstruktor, dann der Wert, dann der Ergebnistyp.],
  step(label: "Gerüst schreiben")[Ein `case`-Ausdruck mit einer Zeile pro Konstruktor. Jede Zeile übergibt die Felder an
    ihre Funktion.],
  example(
    "Maybe a",
    ```
    Nothing :: Maybe a
    Just    :: a -> Maybe a
    ```,
    ```
    fnothing :: r
    fjust    :: a -> r
    ```,
    ```
    foldMaybe :: r -> (a -> r) -> Maybe a -> r
    ```,
    ```
    foldMaybe fnothing fjust value =
      case value of
        Nothing -> fnothing
        Just x  -> fjust x
    ```,
  ),
  example(
    "Either a b",
    ```
    Left  :: a -> Either a b
    Right :: b -> Either a b
    ```,
    ```
    fleft  :: a -> r
    fright :: b -> r
    ```,
    ```
    foldEither :: (a -> r) -> (b -> r) -> Either a b -> r
    ```,
    ```
    foldEither fleft fright value =
      case value of
        Left x  -> fleft x
        Right y -> fright y
    ```,
  ),
)

*Zur Kontrolle:* Übergibst du die Konstruktoren selbst, muss die Identität herauskommen, also
`foldMaybe Nothing Just x == x`. Bei rekursiven Typen kommt ein Schritt dazu, darum geht es in der nächsten Lektion.

#practice("fold-maybe-either")
