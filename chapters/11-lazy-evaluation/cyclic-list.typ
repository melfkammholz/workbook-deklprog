Eine zyklische einfach-verkettete Liste können wir in Python z.B. so
definieren.
```py
class Node:
  def __init__(self, value):
    self.value = value
    self.next = None

one, two = Node(1), Node(2)
one.next, two.next = two, one
```
Wenn wir mit `one` starten, dann korrespondiert diese verkettete Liste
mit der unendlichen Liste `[1, 2, 1, 2, ...]`.

Die Mutierbarkeit des `next`-Zeigers macht das Verlinken der Knoten in
Python möglich. Wie können wir in Haskell, trotz der Abwesenheit von
Mutierbarkeit, zyklische Datenstrukturen umsetzen? Versuche, dein Programm
ähnlich zum Python-Programm aussehen zu lassen. Verwende dafür auch den
(polymorphen) Datentyp `Node`.

#remark[
  Die Technik ist als
  #link("https://wiki.haskell.org/index.php?title=Tying_the_Knot")[Tying the Knot]
  bekannt.
]
