Ein nicht-deterministischer Parser ist eine Funktion, die eine Folge von
Tokens nimmt und versucht aus dieser Folge, einen Wert abzuleiten. Für uns
soll die Folge von Tokens ein `String` sein und das "versucht" modellieren wir als `[(a, String)]`. Letztere Wahl ermöglicht es uns,
keinen Wert, einen Wert oder sogar mehrere Werte als Ergebnisse zuzulassen.
Wir betrachten also den folgenden Typ
#align(center)[`type Parser a = String -> [(a, String)]`.]
Das Parsen gilt als erfolgreich, wenn ein Wert mit einem leeren
`String` zurückgegeben wird.

Zum Beispiel könnte ein Parser `number :: Parser Int` folgendes
Ergebnis liefern, wenn man ihn wie folgt anwendet.
```haskell
> number "19851026backintime"
[(19851026, "backintime")]
```

- Implementiere eine Funktion
  `parse :: Parser a -> String -> Maybe a`, die einen Parser nimmt
  und ihn auf einen gegebenen String anwendet. Falls ein Wert geparst werden
  konnte, soll der erste solche zurückgegeben werden. Im anderen Fall soll
  `Nothing` zurückgegeben werden. Beachte, dass der erste Wert nicht
  an der ersten Stelle des Ausgabeliste eines Parsers stehen muss.
- Implementiere eine Funktion `succeed :: a -> Parser a`, die einen Parser
  zurückgibt, der einen gegeben Wert zurückgibt und die Eingabe für den
  Parser unangerührt zurückgibt. Implementiere weiter einen Parser `failure :: Parser a`, der kein Ergebnis liefert.
- Implementiere eine Funktion
  `satisfy :: (Char -> Bool) -> Parser Char`, die einen Parser liefert,
  der einen Buchstaben nur dann parst, wenn das gegebene Prädikat erfüllt ist,
  und diesen Buchstaben zusammen mit dem Reststring zurückgibt. Falls der
  String leer ist oder das Prädikat verletzt ist, soll kein Ergebnis
  zurückgegeben werden.
- Basierend auf `satisfy`, implementiere die Parser
  - `anyChar :: Parser Char`, der einen beliebigen Buchstaben parst,
  - `char :: Char -> Parser Char`, der einen festgelegten Buchstaben parst, und
  - `digit :: Parser Int`, der eine Ziffer parst.
  Zum Umwandeln der geparsten Ziffer kannst du `read :: String -> Int`
  verwenden.
- Normalerweise möchte man Parser miteinander kombinieren, um mehr als einen
  Buchstaben der Eingabe zu parsen.
  - Implementiere einen Parserkombinator
    `andThen :: Parser a -> (a -> Parser b) -> Parser b`, die einen
    Parser und eine Funktion nimmt, die das Ergebnis des vorherigen Parsers
    nimmt und basierend darauf einen neuen Parser konstruiert. Für die
    Implementierung dieses Kombinators kann die Funktion
    `concatMap :: (a -> [b]) -> [a] -> [b]` hilfreich sein.
  - Implementiere einen Parserkombinator
    `many :: Parser a -> Parser [a]`, der einen Parser beliebig häufig
    anwendet, bis er fehlschlägt. Zum Beispiel soll das Ergebnis von
    `many digit "20151021"` dann `[([2, 0, 1, 5, 1, 0, 2, 1], "")]`
    sein.
  - Implementiere einen Parserkombinator
    `(<*) :: Parser a -> Parser b -> Parser a`, der zwei Parser
    hintereinander anwendet und die Ergebnisse des ersten Parser behält,
    während die Ergebnisse des zweiten Parser verworfen werden.
- Implementiere einen Parser `number :: Parser Int`, der eine
  nicht-negative Zahl parst.
