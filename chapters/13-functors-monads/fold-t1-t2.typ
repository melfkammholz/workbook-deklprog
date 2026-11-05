Gegeben seien die Datentypen
```haskell
data T1 a = A | B [T1 a]
data T2 a = A | B (Maybe (T2 a))
```
Gib Faltungsfunktionen an, die bis auf Umbenennung der Funktionsbezeichner
und Datentypen in der Signatur identisch sind.

#remark[
  Könntest du sogar eine für den Typ `data TX f a = A | B (f (TX f a))`
  angeben?
]
