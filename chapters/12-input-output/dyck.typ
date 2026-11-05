Wir betrachten die Dyck-Sprache, die durch die folgende kontextfreie Grammatik
erzeugt wird:
$ S -> S S, quad S -> (S), quad S -> epsilon $
Implementiere eine Funktion `dyck :: IO ()`, die die Standardeingabe
liest und jedes Mal, wenn der aktuell gelesene Präfix der Standardeingabe ein
Dyck-Wort ist, den String `"DYCK!"` ausgibt (auf der Standardausgabe).
Du kannst davon ausgehen, dass die Eingabe immer ein Dyck-Wort ist.

Folgende Funktion testet, ob ein String ein Dyck-Wort der obigen Dyck-Sprache
ist.
```haskell
isDyck :: String -> Bool
isDyck = go 0
  where
    go k ""        = k == 0
    go k ('(' : s) = go (k + 1) s
    go 0 (')' : _) = False
    go k (')' : s) = go (k - 1) s
```
Eine Abwandlung dieser Funktion kannst du für deine Implementierung von
`dyck` verwenden.
