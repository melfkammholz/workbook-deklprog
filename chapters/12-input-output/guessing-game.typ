Implementiere folgendes Rate-Spiel als IO-Programm. Es soll eine Zahl erraten
werden.
- Du bekommst ein Orakel vom Typ `a -> Ordering`, das
  dir verrät, ob dein Rateversuch kleiner als, gleich oder größer als der Wert
  ist, den das Orakel festgelegt hat.
- In jeder Runde des Spiels ratest du eine Zahl.
- Wenn die Zahl kleiner als die unbekannte Zahl ist, dann soll der Hinweis
  "Die gesuchte Zahl ist größer." ausgegeben werden. Wenn die unbekannte Zahl kleiner ist, soll ebenso eine entsprechende Nachricht ausgegeben werden.
- Wenn die korrekte Zahl erraten wurde, bricht das Spiel ab.
Implementiere das Spiel als Funktion `game :: Read a => (a -> Ordering) -> IO ()`.

Du kannst das Spiel gerne ausschmücken und erweitern. Zum Beispiel kannst du
die Anzahl der Rateversuche begrenzen oder eine weitere Zahl festlegen, die
vorzeitig das Spiel beendet und das Orakel gewinnen lässt.
