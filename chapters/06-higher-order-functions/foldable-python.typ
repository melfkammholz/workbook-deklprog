Gegeben sei folgendes Python-Programm.
```py
from dataclasses import dataclass
from typing import Generic, TypeVar


class Foldable():
  def foldr(self, f):
    pass

  def sum(self):
    return self.foldr(lambda x: lambda ys: x + ys)(0)

  def toList(self):
    return self.foldr(lambda x: lambda ys: [x] + ys)([])

  def __len__(self):
    return self.foldr(lambda _: lambda s: 1 + s)(0)

  def __contains__(self, y):
    return self.foldr(lambda x: lambda z: z or x == y)(False)

  # ...


T = TypeVar('T')

class Tree(Generic[T], Foldable):
  def foldr(self, f):
    def foldr_with_f(e):
      match self:
        case Empty():
          return e
        case Node(l, x, r):
          y = f(x)(r.foldr(f)(e))
          z = l.foldr(f)(y)
          return z
    return foldr_with_f

@dataclass
class Empty(Tree[T]):
  pass

@dataclass
class Node(Tree[T]):
  left: Tree[T]
  value: T
  right: Tree[T]


tree = Node(Empty(), 3, Node(Node(Empty(), 7, Empty()), 4, Empty()))
print(tree.sum())  # 14
print(tree.toList())  # [3, 7, 4]
print(len(tree))  # 3
print(3 in tree, 9 in tree)  # True False
```
In diesem Programm werden viele Konzepte verwendet, die du im Haskell-Kontext
kennengelernt hast -- aber wahrscheinlich bisher nicht in Python gesehen hast.
In diesem Test geht es darum, diese Konzepte im Python-Programm zu
identifizieren.

Wo findest du
- Funktionen höherer Ordnung,
- pattern matching,
- algebraische Datentypen (Typkonstruktoren, Datenkonstruktoren),
- parametrischen Polymorphismus,
- ad-hoc Polymorphismus (Typklassen bzw. Überladung) und
- lokale Definitionen?

#remark[
  Typannotationen in Python sind nicht sonderlich elegant. Deshalb sind
  nur die angegeben, um den parametrischen Polymorphismus zu identifizieren
  und data classes anständig zu nutzen.

  Data classes und match statements brauchst du dir jenseits dieses Tests
  nicht anschauen (wenn es dich nicht weiter interessiert). Es soll in dem
  Test nur darum gehen, die Haskell-Konzepte zu erkennen. 
]

#remark[
  Auch in Java haben diese Konzepte über die letzten Jahre einen Platz gefunden. Falls
  dich das interessiert, findest du das Programm auf Java übertragen in #xref("foldable-java").
]
