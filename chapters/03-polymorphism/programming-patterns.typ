Da viele von euch Neulinge sind, wenn es um das Programmieren in Haskell geht,
brauchen wir eine neue Sammlung von Phrasen, die wir nutzen können, um
natürlich-sprachliche Anweisungen in Haskell zu formulieren. Finde
"Programmierschablonen" für folgende Anweisungen:
- "für jedes Element einer Liste, tue..."
- "solange ein Wert etwas erfüllt, tue..."
- "für jedes Element einer Liste, das eine Bedingung erfüllt, tue..."
- "überprüfe, ob ein Element existiert, das..."
- "überprüfe für alle Elemente, ob..."
- "betrachte alle Kombinationen zweier Listen, für jede Kombination tue..."
Versuche so viele wie möglich zu finden, die verschiedene Konzepte des
Moduls aufgreifen.

Als Beispiel für die erste Anweisung, können wir z.B. eine induktiv definierte
Funktion implementieren, die vom Muster her so aussehen könnte
```haskell
f []     = e           -- Wenn wir keine Elemente mehr betrachten können,
                       -- dann e
f (x:xs) = g x (f xs)  -- tue g in Abhängigkeit von x und (f xs)
                       -- f xs betrachtet die Elemente, die wir noch nicht
                       -- verarbeitet haben
```
`e` und `g` sind hier Platzhalter für die Dinge, die wir tun
wollen.
