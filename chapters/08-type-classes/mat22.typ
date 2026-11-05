Überlade die Operationen `(+), (-), (*), abs, signum, fromInteger`
für den Datentypen `data Mat22 a = Mat22 a a a a`, der
$(2 times 2)$-Matrizen repräsentieren soll -- `abs` und `signum` kannst du z.B. komponentenweise implementieren. `fromInteger n` soll die Diagonalmatrix mit `n` auf der Diagonale sein, damit `fromInteger 1` die Einheitsmatrix ist.

#remark[
  Oft sind an Funktionen von Typklassen Bedingungen bzw. Gesetze, die erfüllt
  werden sollen, gekoppelt. Diese werden durch den Implementierungsvorschlag von `abs` und `signum` nicht erfüllt. Für `fromInteger` sind sie hier wichtig: `(^)` berechnet $x^0$ als `fromInteger 1`.
]
