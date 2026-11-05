Als motivierendes Beispiel für Monaden hast du die Auswertung eines
arithmetischen Ausdrucks, gegeben als Termstruktur, kennengelernt. Dort haben
wir die `Maybe`-Monade verwendet, um fehlschlagende Berechnung
aufzufangen. Der Typ für die arithmetischen Ausdrücke ist gegeben durch:
```haskell
data Exp a = Num a
           | Exp a :+: Exp a
           | Exp a :-: Exp a
           | Exp a :*: Exp a
           | Exp a :/: Exp a
```
- Implementiere `eval :: Exp Int -> Maybe Int` mit dem
  `Maybe`-Applicative. Warum ist die Division, ohne eine weitere
  Hilfsfunktion nicht möglich? Was müsste diese Hilfsfunktion tun, damit die
  Regel für die Division funktioniert?
- Implementiere `eval :: Exp Int -> Maybe Int` mit der
  `Maybe`-Monade. Benötigst du hier die Hilfsfunktion aus der
  vorherigen Teilaufgabe? Warum ja oder nein?
- Wie kannst du mit #xref("guard-monadzero") `eval` zu einer Funktion
  `eval :: MonadZero m => Exp Int -> m Int`
  verallgemeinern?
- `MonadZero` erlaubt es uns, einen Fehlschlag allgemein auszudrücken.
  Allerdings können wir anhand des Fehlschlags alleine nicht feststellen,
  warum es zum Fehlschlag kam. Verallgemeinere die Typkonstruktorklasse
  `MonadZero` zu einer Typkonstruktorklasse `MonadFail`,
  die es erlaubt, eine Beschreibung des Fehlschlags anzugeben. Sie soll dafür
  eine Funktion `fail :: String -> m a` definieren. Verallgemeinere
  `eval` erneut mit der neuen Typkonstruktorklasse. Gib zusätzlich
  eine Instanz für den Typ `Either String` an -- alternativ,
  implementiere eine `Functor`-, `Applicative`-, `Monad`-
  und `MonadFail`-Instanz für den Typen
  `data Result a = Failure String | Success a`.

#remark[
  Der applikative Funktor wird durch die Verwendung von Hilfsfunktion nicht
  ausdrucksstärker! Das, was der applikative Funktor nicht leisten kann, wird
  in die Hilfsfunktion ausgelagert. Teile der Hilfsfunktion werden durch die
  Monade übernommen.
]
