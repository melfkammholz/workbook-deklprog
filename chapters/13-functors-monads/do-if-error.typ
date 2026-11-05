Gegeben sei folgendes fehlerhafte Haskell-Programm.
```haskell
main :: IO ()
main = do
  q <- read <$> getLine
  if q == 0
    then main
    else
      p <- read <$> getLine
      print (p `div` q)
```
Warum ist das Programm fehlerhaft? Um den Fehler zu identifizieren, klammere
alle validen Haskell-Teilausdrücke. (Du kannst davon ausgehen, dass alle
Eingaben valide sind und deshalb keine weitere Fehlerbehandlung der Eingaben
stattfinden muss.)
