Entwickle einen Datentyp `Ratio`, um rationale Zahlen
$ p/q in QQ, quad p in ZZ, q in NN, p "und" q "teilerfremd" $
darzustellen. Implementiere die Operationen: Addition, Subtraktion,
Multiplikation, Division. Stelle dabei sicher, dass die interne Darstellung
immer normalisiert ist. Implementiere weiter eine Funktion, die die
rationale Zahl als reelle Zahl mit einer festen Anzahl von Nachkommastellen
darstellt.

Die Tests der Vorlage kennen deinen Datentypen nicht. Implementiere deshalb
- `ratio :: Integer -> Integer -> Ratio`, die aus Zähler und Nenner $q != 0$ eine normalisierte Zahl erzeugt,
- `numerator` und `denominator`, die Zähler und Nenner liefern,
- `add`, `sub`, `mul` und `divide` für die Operationen und
- `toDecimal :: Int -> Ratio -> String`, die die Zahl mit der gegebenen Anzahl $>= 1$ von Nachkommastellen darstellt. Weitere Stellen werden abgeschnitten, zum Beispiel ist `toDecimal 3 (ratio (-1) 3)` gleich `"-0.333"`.

Später kannst du auch hier die jeweiligen Typklassen verwenden, um die
arithmetischen Operationen zu überladen.
