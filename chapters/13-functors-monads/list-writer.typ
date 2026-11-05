Das Pendant zur `Reader`-Monade aus #xref("reader") ist die
`Writer`-Monade. Eine Spezialisierung der Monade soll hier die
`ListWriter`-Monade sein. Diese Monade kann genutzt werden, um
Zwischenergebnisse oder Logging-Informationen einer Berechnung zu speichern.
#align(center)[
  ```haskell
  newtype ListWriter w a = ListWriter { runListWriter :: (a, [w]) }
  ```
]
Implementiere diese Monade. Mache dir insbesondere Gedanken darüber, wie du
Berechnungen dieses Typs sequenzierst und wie du die Zwischenergebnisse
von zwei Berechnungen kombinierst.

#hint[
  Die Implementierung dieser Monade ist sehr ähnlich zu der Implementierung
  der `Reader`-Monade, wie sie in #xref("reader") angegeben ist.
]
