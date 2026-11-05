#import "@preview/cetz:0.5.3"

In diesem Test wollen wir einen beliebigen Wert zu einem Baum entfalten.
Implementiere eine Funktion `unfoldTree :: (b -> Maybe (b, a, b)) -> b -> Tree a`,
die eine Funktion nimmt, die einen Wert vom Typ `b` nimmt und in eine
Knotenbeschriftung und zwei weitere Werte vom Typ `b` aufspaltet, oder
das Entfalten stoppt, indem ein `Nothing` zurückgegeben wird. Bäume
sind durch den Datentyp `data Tree a = Empty | Node (Tree a) a (Tree a)`
definiert.

Nutze die definierte Funktion, um einen Binärbaum zu erzeugen, welche die
Zerlegungen eines diskreten Intervalls darstellen soll. Entnehme die Art der
Zerlegung dem Diagramm.
#align(center, cetz.canvas({
  import cetz.draw: *
  content((0, 1.5), $[l, r)$, name: "a")
  content((-2.2, 0), $[l, floor((l+r)/2))$, name: "b")
  content((2.2, 0), $[floor((l+r)/2), r)$, name: "c")
  line((-0.3, 1.2), (-1.9, 0.35), mark: (end: ">"))
  line((0.3, 1.2), (1.9, 0.35), mark: (end: ">"))
}))

Implementiere dies als Funktion `intervals :: Int -> Int -> Tree (Int, Int)`, sodass
`intervals l r` den Baum zum Intervall $[l, r)$ liefert. Die Beschriftung eines
Knotens ist das Paar `(l, r)`. Ein leeres Intervall ergibt `Empty`, und ein
Intervall mit genau einem Element wird nicht weiter zerlegt, ist also ein Knoten
mit zwei leeren Kindern.
