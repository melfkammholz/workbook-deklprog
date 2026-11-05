Gegeben sei der Typ
#align(center)[`data Tree a b c = Empty | Leaf a | Node (Tree a b c) Int c (Tree a b c)`.]
Implementiere eine `Eq`-Instanz für diesen Typen. Die Gleichheit soll
sich so verhalten wie die, die wir durch das Ableiten bekommen würden.
Bevor du die Instanz implementierst, überlege dir:
- Wie viele Regeln brauchst du mindestens, um `(==)` zu definieren?
- Benötigst du für die Implementierung Typeinschränkungen? Wenn ja, für welche
  Typen?
- An welchen Stellen wirst du `(==)` rekursiv anwenden?
- Die Datenkonstruktoren sind auf den rechten Seiten der Regeln nicht relevant.
  Auf welchen Typen kannst du die Gleichheit für z.B. `Node`
  zurückführen, bzw. wenn du dir die rechte Seite der Regel für `Node`
  anschaust, welche Typen fallen dir ein, für die diese rechte Seite auch
  eine Gleichheit definieren würde?
