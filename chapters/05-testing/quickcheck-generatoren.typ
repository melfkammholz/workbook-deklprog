Woher kommen die Eingaben, die QuickCheck ausprobiert? Das ist die Leitfrage
dieser Lektion. Wie genau Testdaten automatisch generiert werden, werden wir
später in der Vorlesung kennenlernen. Hier betrachten wir die Ideen dahinter
erstmal oberflächlich.

= Zufall als Baustein

QuickCheck erzeugt Werte mithilfe Pseudozufallszahlengenerator, einem Programm, das aus einem Startwert eine Folge Zahlen erzeugt, die zufällig aussehen. Komplexere Werte baut es aus einfachen zusammen:

- Eine `Int`-Zahl ist eine Zufallszahl. Ihr Betrag wächst mit einem 
  QuickCheck-Parameter _Größe_, der sukzessiv nach erfolgreichen Testergebnissen
  erhöht wird -- die ersten Tests sind klein, spätere größer.
- Eine Liste hat eine zufällige Länge und dazu Elemente, die ihrerseits zufällig
  erzeugt werden.
- Ein Paar sind zwei zufällige Werte.

Was erzeugt werden kann, legt eine Typklasse `Arbitrary` fest. Ein Wert
`arbitrary` vom Typ `Gen a` beschreibt, wie man ein zufälliges `a` erzeugt. Für
die Standardtypen gibt es sie schon. Für eigene Datentypen schreibst du eine
Typklasseninstanz.

= Ein Generator für Bäume

Betrachten wir als Beispiel eine `Arbitrary`-Instanz für einen 
blattbeschrifteten Binärbaum.

```haskell
data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> arbitrary <*> arbitrary
                    ]
```

Mit gleicher Wahrscheinlichkeit wird entweder ein Blatt mit einem zufälligen Wert oder ein Knoten aus zwei zufälligen Teilbäumen gewählt.

Im Interpreter kannst du dir Beispiele ausgeben lassen.

```haskell
ghci> sample (arbitrary :: Gen (Tree Int))
```

#quiz(
  [Der Generator ruft sich für die Teilbäume selbst wieder auf. Mit welcher Wahrscheinlichkeit ist der erzeugte Baum nur
    ein einzelnes Blatt?],
  choice(correct: true)[Mit Wahrscheinlichkeit $1\/2$][Genau: Die Hälfte der Zeit wählt `oneof` sofort den Fall `Leaf`.],
  choice[Fast nie][Das erste Element von `oneof` hat dasselbe Gewicht wie das zweite.],
  choice[Nie, denn Bäume sind rekursiv][Der Fall `Leaf` ist die Abbruchbedingung und wird in der Hälfte der Fälle gewählt.],
)

= Endliche Terme

Beim Definieren rekursiver Generatoren müssen wir aufpassen, dass sie nicht
endlos weiterbauen --- sofern wir nicht explizit unendliche Datenstrukuren
betrachten. Betrachte einen offenen Teilbaum: Mit Wahrscheinlichkeit $1\/2$ wird
er ein Blatt (0 neue offene Teilbäume), mit $1\/2$ ein Knoten (2 neue). Im
Mittel erzeugt jeder offene Teilbaum also $1\/2 dot 0 + 1\/2 dot 2 = 1$ neuen.
Das ist genau die Grenze: Der Baum endet mit Wahrscheinlichkeit 1, aber seine
erwartete Größe ist unendlich. Die meisten Bäume sind winzig, einige gewaltig.

Für dich heißt das:
- Hin und wieder dauert ein Test länger oder braucht viel Speicher. Das liegt am Generator, nicht an deiner Funktion.
  Brich ab und starte neu.
- Gegenbeispiele können sehr groß sein, denn diese Instanz definiert auch kein Shrinking: QuickCheck weiß nicht, wie man
  einen Baum verkleinert. Läuft ein Test mit einem unlesbaren Gegenbeispiel, starte ihn neu und nimm ein kleineres.

#quiz(
  [Wie ließe sich der Generator verbessern?],
  choice[Das Gewicht für `Leaf` auf $1\/10$ senken][Dann würden die Bäume im Mittel noch größer. Wir brauchen eine
    Größenbeschränkung.],
  choice(correct: true)[Dem Generator eine Größe mitgeben und die Teilbäume mit kleinerer Größe erzeugen][Genau, so
    bricht jede Zweigtiefe irgendwann ab. QuickCheck bietet dafür `sized`.],
  choice[`oneof` durch eine Schleife ersetzen][Haskell hat keine Schleifen, und das Problem liegt am rekursiven Aufbau.],
)

Eine Möglichkeit, das Problem zu beheben, ist:

```haskell
instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = sized gen
    where
      gen 0 = Leaf <$> arbitrary
      gen n = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> gen (n `div` 2) <*> gen (n `div` 2)
                    ]
```

Die Größe halbiert sich bei jedem Schritt nach unten, bei 0 gibt es nur Blätter. 
Beachte allerdings, dass diese Instanz keine entarteten Binärbäume generiert.

#remark[
  Die QuickCheck-Veröffentlichung: Koen Claessen und John Hughes, _QuickCheck: a lightweight tool for random testing of
  Haskell programs_ (ICFP 2000), #link("https://dl.acm.org/doi/10.1145/351240.351266")[dl.acm.org]. Die Dokumentation
  steht in
  #link("https://hackage-content.haskell.org/package/QuickCheck/docs/Test-QuickCheck.html")[Test.QuickCheck].
]

#practice("sumtree-eigenschaften", "mirrortree-eigenschaften", "tolist-eigenschaften", "build-balanciert")
