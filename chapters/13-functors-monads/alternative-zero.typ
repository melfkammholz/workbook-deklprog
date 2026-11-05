In #xref("guard-monadzero") haben wir eine Typkonstruktorklasse definiert, die es uns
erlaubt hat, einen Fehlschlag bzw. die Abwesenheit eines Ergebnisses
auszudrücken. Diese können wir auch eine Abstraktionsebene früher einführen.
Definiere eine weitere Typkonstruktorklasse `AlternativeZero` auf
Ebene der applikativen Funktoren mit einer Funktion `empty :: f a`.

Folgende Ausdrücke sollen die gegebenen Werte haben:
- `guard (y /= 0) *> pure y = pure y` für `y /= 0` und
- `guard (y /= 0) *> pure y = empty` für `y == 0`.

`(*>) :: Applicative f => f a -> f b -> f b` ist ein Kombinator, der
sich wie `(>>)` für applikative Funktoren verhält.
