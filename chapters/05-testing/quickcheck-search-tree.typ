Formuliere QuickCheck-Eigenschaften, die die Funktionen
- `isElem :: Int -> SearchTree Int -> Bool`,
- `toList :: SearchTree Int -> [Int]`,
- `insert :: Int -> SearchTree Int -> SearchTree Int` und
- `delete :: Int -> SearchTree Int -> SearchTree Int`
erfüllen sollen. `isElem` überprüft, ob eine Ganzzahl in einem gegebenen Suchbaum enthalten ist. `toList` konvertiert einen Suchbaum in eine
Liste. `insert` fügt eine Ganzzahl in einen Suchbaum ein.
`delete` löscht eine Ganzzahl aus einem Suchbaum.

Wie kannst du die Suchbaum-Eigenschaft spezifizieren? Zum Spezifizieren der
Eigenschaften benötigst du möglicherweise weitere Funktionen.
