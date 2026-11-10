`quickCheck` ist eine sehr flexible Funktion in Hinsicht auf zulässige Eingaben,
konkreter Eigenschaften. In dieser Lektion schauen uns, wo potentiell Fallen
in der Anwendung der Funktion lauern.

#remark[
  An dieser Stelle könnte man sich fragen, welchen Typ ```hs quickCheck``` hat?
  Mit unserem bisherigen Kenntnisstand können wir diese Frage allerdings nicht
  konkret beantworten (siehe später #xref("quickcheck-simple")).
]

= Bool oder Property

Plump gesagt, `quickCheck` akzeptiert alles, was #emph[testbar] ist. Das ist die Typklasse `Testable`; Typklassen kommen später in der Vorlesung, darum 
behandeln wir sie hier als black box. Wichtig ist:

- Eine Funktion mit Ergebnistyp `Bool` ist testbar.
- Eine Funktion mit Ergebnistyp `Property` ist testbar.

Letztere Testbarkeitsbedingung wird dann wichtig, wenn eine Eigenschaft
bestimmte Vorbedingungen erfüllen soll. Diese könnten mithilfe des
```hs (==>)```-Kombinators spezifizieren.

```haskell
prop_divMod :: Int -> Int -> Property
prop_divMod a b = b /= 0 ==> (a `div` b) * b + a `mod` b == a
```

Eingaben, die die Vorbedingung nicht erfüllen, verwirft QuickCheck. Mehr dazu in #xref("quickcheck-preconditions") und #xref("quickcheck-implication").

#steps(
  step(label: "Frage")[
    Können wir eine alternative Definition von ```hs (==>) :: Bool -> Bool -> Bool``` angeben, sodass QuickCheck weiterhin
    feststellen kann, ob die Vorbedingung nicht erfüllt war? Wie lautet sie? Überlege kurz, bevor du weitergehst.
  ],
  step(label: "Antwort")[
    Nein. Ein `Bool` hat nur die Werte `True` und `False`. Ist die Vorbedingung falsch, darf der Test weder bestehen noch
    fehlschlagen, er muss _verworfen_ werden. Dafür bräuchten wir einen dritten Wert. Deshalb liefert `(==>)` einen
    `Property` und kein `Bool`. Mit `Maybe Bool` ginge es zum Beispiel: `Nothing` steht für "verworfen".
  ],
)

= Wenn die Typinferenz zum Verhängnis wird

Eine Eigenschaft wie `\xs -> reverse xs == xs` sagt nichts über den Typ der
Elemente von `xs`. QuickCheck muss allerdings wissen, um welchen Typ es sich 
handelt, um entsprechende Werte generieren zu können. Im Interpreter passiert 
hier etwas Gemeines.

```haskell
ghci> quickCheck (\xs -> reverse xs == xs)
+++ OK, passed 100 tests.
```

Diese Eigenschaft gilt nicht, aber der Test besteht! Der Interpreter wählt für
den unbestimmten Elementtyp stillschweigend `()`, den Typ mit nur einem Wert.
Dadurch wir jede Liste zu einem Palindrom. Eine genauere Aussage ist also eher,
die Eigenschaft gilt nicht für alle Typen. Deshalb geben wir immer einen
konkreten Typen an.

```haskell
ghci> quickCheck (\xs -> reverse xs == (xs :: [Int]))
*** Failed! Falsified (after 5 tests and 4 shrinks):
[0,1]
```

#quiz(
  [Welcher Aufruf prüft `reverse (xs ++ ys) == reverse ys ++ reverse xs` sinnvoll?],
  choice[`quickCheck (\xs ys -> reverse (xs ++ ys) == reverse ys ++ reverse xs)`][Der Elementtyp ist unbestimmt. Der
    Interpreter wählt `()`, und der Test sagt kaum etwas aus.],
  choice(correct: true)[`quickCheck (\xs ys -> reverse (xs ++ ys) == reverse ys ++ reverse (xs :: [Int]))`][Genau:
    Der Typ von `xs` ist bekannt, und der von `ys` folgt daraus.],
)


= Mehrere Eigenschaften gleichzeitig testen

Wenn viele Eigenschaften definiert werden, ist es äußerst müheselig jede dieser
zu testen, indem wir sie wie bisher in der GHCi REPL testen. Um mehrere 
Eigenschaften gleichzeitig zu testen, ist Meta-Programmierung notwendig.
Betrachte folgendes Programm.

```haskell
{-# LANGUAGE TemplateHaskell #-}
import Test.QuickCheck

prop_reverseTwice :: [Int] -> Bool
prop_reverseTwice xs = reverse (reverse xs) == xs

prop_lengthAppend :: [Int] -> [Int] -> Bool
prop_lengthAppend xs ys = length (xs ++ ys) == length xs + length ys

return []

runTests :: IO Bool
runTests = $quickCheckAll
```

`quickCheckAll` sucht alle Funktionen, deren Name mit `prop_` beginnt, und prüft jede. Das Ergebnis ist `True`, wenn alle
Eigenschaften bestehen. Den Rest brauchst du nur zu kopieren:

- `{-# LANGUAGE TemplateHaskell #-}` schaltet eine Spracherweiterung ein, die `$quickCheckAll` erlaubt (Code, der beim
  Übersetzen erzeugt wird).
- `return []` muss _nach_ allen Eigenschaften stehen, damit sie für `$quickCheckAll` sichtbar sind.
- Die Eigenschaften brauchen eine konkrete Typsignatur (siehe oben).

In den Aufgaben ist das Gerüst schon da. Du rufst im Interpreter `runTests` auf, nachdem du eine Eigenschaft ergänzt hast. Das wird im Folgenden nur im Rahmen
der Aufgaben eine Rolle spielen. Diese Sektion dient mehr als Antwort auf die
Frage: "Warum brauchen wir diese Zeilen?".
