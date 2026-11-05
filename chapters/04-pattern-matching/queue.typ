In Haskell sind Listen als einfach-verkettete Listen implementiert. Das macht
sie ungeeignet für Operationen, die wahlfreien Zugriff in konstanter Laufzeit
benötigen. Darüber hinaus sind Listen auch nicht mutierbar. Das führt dazu,
dass Operationen, die eine Liste verändern, häufig lineare Laufzeit in der
Länge der Liste haben -- mit Ausnahme der `(:)`-Operation.

Ziel dieser Challenge ist es, eine Datenstruktur zu entwickeln, die eine
(amortisiert) konstante `append`-Operation hat. Diese ist bekannt als
`Queue`. Sie soll durch `data Queue a = Q [a] [a]` dargestellt
werden. Die Idee ist es, eine (linke) Liste vorzuhalten, die eine
(amortisiert) konstante `dequeue`-Operationen erlaubt, und eine andere
(rechte), die eine konstante `enqueue`-Operationen erlaubt. Das heißt,
fast alle dieser Operationen benötigen konstante Laufzeit und konstant wenige
können lineare Laufzeit haben.

Implementiere die Funktionen
- `empty :: Queue a`, die eine leere Queue erzeugt,
- `front :: Queue a -> a`, die das erste Element in einer queue
  zurückgibt,
- `isEmpty :: Queue a -> Bool`, die bestimmt, ob eine queue leer ist,
- `enqueue :: a -> Queue a -> Queue a`, die ein Element an das Ende
  einer queue anhängt,
- `dequeue :: Queue a -> Queue a`, die das erste Element in einer
  queue entfernt.

Die Implementierung soll dabei folgende Invariante erfüllen: Eine queue ist
genau dann leer, wenn die `dequeue`-Liste leer ist. Diese Invariante
kannst du z.B. mit einer Hilfsfunktion erzwingen -- oder du passt bei der
Implementierung deiner Funktionen auf. Falls es dir für den Anfang einfacher
fällt, ignoriere die Invariante erstmal.

#remark[
  Die Laufzeiten lassen sich noch verbessern. Falls dich das interessiert:
  #xref("queue-guarantees").
]

#hint[
  Ohne die Invariante sieht eine leere queue nach $n$ `enqueue`-Operationen wie folgt aus
  #align(center)[
    `Q [] [xn, ..., x1]`.
  ]
  Wenn als Nächstes `dequeue`-Operationen naiv ausgeführt werden,
  müssten wir die `enqueue`-Liste jedes Mal vollständig durchlaufen.
  Wenn wir die `dequeue`-Liste entsprechend verändern, können wir
  mindestens die nächsten $n$ `dequeue`-Operationen effizient
  durchführen.
]
