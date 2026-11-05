Gegeben sei der Typ
#align(center)[`data Tree a b c = Empty | Leaf a | Node (Tree a b c) Int c (Tree a b c)`.]
Implementiere eine `Ord`-Instanz für diesen Typen. Die Ordnung soll
sich so verhalten wie die, die wir durch das Ableiten bekommen würden.
Bevor du die Instanz implementierst, überlege dir:
- Spielt die Reihenfolge, in der wir die Datenkonstruktoren definieren, eine Rolle für die Ordnung? Wenn ja, wie?
- Wie viele Regeln brauchst du mindestens, um `compare` zu definieren?
  Wie auch bei der Typklasse `Eq` können wir eine Regel definieren,
  die alle Fälle abdeckt, in denen wir `GT` erhalten, wenn wir uns
  nur die Datenkonstruktoren anschauen. Welches Schema müssen wir für die
  anderen Regeln verwenden, damit das funktioniert?
- Benötigst du für die Implementierung Typeinschränkungen? Wenn ja, für welche
  Typen?
- An welchen Stellen wirst du `compare` rekursiv anwenden?
- Die Datenkonstruktoren sind auf den rechten Seiten der Regeln nicht relevant.
  Auf welchen Typen kannst du die Ordnung für z.B. `Node`
  zurückführen, bzw. wenn du dir die rechte Seite der Regel für `Node`
  anschaust, welche Typen fallen dir ein, für die diese rechte Seite auch
  eine Ordnung definieren würde?

Implementiere die Ordnung auch erneut mit `(<=)`.
