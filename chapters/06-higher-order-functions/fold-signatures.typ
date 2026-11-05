Gegeben sind folgende Datentypen
- `data Tree a = Empty | Leaf a | Branch (Tree a) (Tree a)`,
- `data Rose a = Node a [Rose a]`.
Welche Typen haben die jeweiligen Datenkonstruktoren und wie führen wir diese
in die Signatur der jeweiligen Faltungsfunktion über?
Wo benötigen wir rekursive Aufrufe der jeweiligen Faltungsfunktionen?
