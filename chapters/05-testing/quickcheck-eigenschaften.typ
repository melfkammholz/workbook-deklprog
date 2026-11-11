Statt einzelene Eingaben für eine Funktion zu testen, beschreiben wir in 
QuickCheck, was für _alle_ Eingaben gelten soll. Dabei überlegen wir uns
Gesetze, die Funktionen erfüllen müssen, und formulieren sie mithilfe von
Funktionen.

= Eigenschaften sind Prädikate

Eine Eigenschaft ist eine Funktion, die für jede Eingabe `True` liefern soll. 
Zum Beispiel soll das zweimalige Umdrehen einer Liste die Liste nicht verändern.

```haskell
prop_reverseTwice :: [Int] -> Bool
prop_reverseTwice xs = reverse (reverse xs) == xs
```

Die Funktion `quickCheck` prüft Eigenschaften wie ```hs prop_reverseTwice```, 
indem sie viele zufällige Eingaben erzeugt und die Eigenschaft für jede dieser 
auswertet.

```haskell
ghci> import Test.QuickCheck
ghci> quickCheck prop_reverseTwice
+++ OK, passed 100 tests.
```

Das bedeutet: 100 zufällige Listen haben die Eigenschaft nicht verletzt. Es 
bedeutet nicht, dass sie für alle Listen gilt (siehe #xref("testen-warum"))!

= Gegenbeispiele und Shrinking

Gilt eine Eigenschaft nicht, findet QuickCheck unter Umständen ein 
Gegenbeispiel. Probieren wir eine falsche Behauptung:

```haskell
ghci> quickCheck (\xs -> reverse xs == (xs :: [Int]))
*** Failed! Falsified (after 5 tests and 4 shrinks):
[0,1]
```

Das erste gefundene Gegenbeispiel ist meist zufällig und groß. Darum versucht
QuickCheck danach, es zu _verkleinern_ (engl. _shrink_): Es probiert kürzere
Listen und Zahlen näher an `0` und behält eine Variante, die die Eigenschaft
immer noch verletzt. Das Ergebnis ist ein möglichst einfaches Gegenbeispiel. 

#quiz(
  [Warum meldet QuickCheck `[0,1]` und nicht `[0,0]` als Gegenbeispiel für `reverse xs == xs`?],
  choice(correct: true)[Weil `[0,0]` die Eigenschaft erfüllt][Genau: `reverse [0,0] == [0,0]`. Beim Verkleinern bleibt
    nur eine Variante, die die Eigenschaft weiterhin verletzt. `[0,1]` ist das kleinste Beispiel, das das tut.],
  choice[Weil QuickCheck zufällig auswählt][Die Eingaben sind zufällig, das Verkleinern aber nicht: Es behält nur
    Varianten, die die Eigenschaft weiterhin verletzen.],
  choice[Weil `0` und `1` die kleinsten Zahlen sind][Es liegt nicht an den Zahlen allein. Probiere `[0,0]` aus: Gilt
    die Eigenschaft dafür?],
)

= Eine Eigenschaft kann zu schwach sein

Eine Funktion zu testen, heißt auch, die richtigen Eigenschaften zu finden. 
Eine Wiederholung aus der Vorlesung: Was soll
`sort :: [Int] -> [Int]` erfüllen?

```haskell
prop_sortSorted :: [Int] -> Bool
prop_sortSorted xs = isSorted (sort xs)             -- das Ergebnis ist sortiert

prop_sortIdempotent :: [Int] -> Bool
prop_sortIdempotent xs = sort (sort xs) == sort xs  -- nochmal sortieren ändert nichts

prop_sortLength :: [Int] -> Bool
prop_sortLength xs = length (sort xs) == length xs  -- es geht nichts verloren
```

#quiz(
  [Welche falsche Implementierung besteht alle drei Eigenschaften?],
  choice[`sort = id`][Für `[2, 1]` ist das Ergebnis nicht sortiert, also verletzt es `prop_sortSorted`.],
  choice[`sort _ = []`][Die Länge ändert sich, das verletzt `prop_sortLength`.],
  choice(correct: true)[`sort xs = replicate (length xs) 0`][Genau: Das Ergebnis ist sortiert, nochmal sortieren ändert nichts, und die Länge stimmt. Es fehlt: Das Ergebnis muss eine Permutation der Eingabe sein.],
)

Wenn alle Eigenschaften bestehen, ist die Funktion nicht automatisch richtig.
Jede Eigenschaft schließt nur einen Teil der falschen Implementierungen aus.

= So arbeitet QuickCheck

Zusammengefasst läuft ein Aufruf von `quickCheck` so ab:

#figure(
  flow(
    flow-node("prop", "Eigenschaft", kind: "start"),
    flow-node("gen", "Zufällige Eingabe erzeugen", at: (0, 1)),
    flow-node("eval", "Eigenschaft auswerten", at: (0, 2)),
    flow-node("ok", "True?", at: (0, 3), kind: "decision"),
    flow-node("more", "Noch Tests übrig?", at: (1, 3), kind: "decision"),
    flow-node("pass", "100 Tests bestanden", note: "OK, aber kein Beweis", at: (1, 4), kind: "good"),
    flow-node("cex", "Gegenbeispiel gefunden", at: (0, 4)),
    flow-node("shr", "Ein kleineres schlägt noch fehl?", at: (0, 5), kind: "decision"),
    flow-node("fail", "Kleinstes Gegenbeispiel", at: (1, 5), kind: "bad"),
    flow-edge("prop", "gen"),
    flow-edge("gen", "eval"),
    flow-edge("eval", "ok"),
    flow-edge("ok", "more", label: "ja"),
    flow-edge("more", "gen", label: "ja"),
    flow-edge("more", "pass", label: "nein"),
    flow-edge("ok", "cex", label: "nein"),
    flow-edge("cex", "shr"),
    flow-edge("shr", "shr", label: "ja"),
    flow-edge("shr", "fail", label: "nein"),
  ),
  caption: [Eine Eigenschaft besteht nach 100 zufälligen Eingaben. Schlägt eine fehl, sucht QuickCheck ein kleineres Gegenbeispiel, das noch fehlschlägt.],
)

= Woher kommen Eigenschaften?

Oft sind es einfache Muster:

- *Gesetze von Operationen*: Assoziativität, Kommutativität, neutrale Elemente. Zum Beispiel
  `(xs ++ ys) ++ zs == xs ++ (ys ++ zs)`.
- *Zusammenhänge zwischen Funktionen*: `length (xs ++ ys) == length xs + length ys`.
- *Umkehrfunktionen*: Was `encode` tut, macht `decode` rückgängig.
- *Vergleich mit einer einfachen Referenz*: Eine schnelle, komplizierte Funktion soll dasselbe liefern wie eine
  langsame, offensichtlich richtige.
- *Eine Regel pro Konstruktor*: Bei einem Datentyp beschreibt jede Eigenschaft, was für einen Konstruktor
  herauskommen soll.
- *Die Gesetze eines abstrakten Datentyps* sind selbst Eigenschaften, die jede Implementierung erfüllen muss, siehe
  #xref("adt-law-properties").

#draft-note[Widget-Idee: die Muster als Karten, jeweils mit einem Beispiel, das man anklicken kann; später vielleicht ein „Welches Muster ist das?"-Quiz.]

#practice("gesetze-pruefen")
