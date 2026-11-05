In Einführung in die Algorithmik hast du den Floyd-Warshall Algorithmus
kennengelernt, um die Distanzen der kürzesten Wege zwischen allen Knoten in
einem kanten-gewichteten Digraph zu berechnen. Hier ist der Algorithmus erneut
in Python.
```py
def floyd_warshall(W):
  n = len(W)
  for v in range(n):
    for u in range(n):
      for w in range(n):
        W[u][w] = min(W[u][w], W[u][v] + W[v][w])
```
Wenn wir nun einmal kräftig auf diesen Algorithmus schielen, sieht dieser
Algorithmus stark nach einer Matrix-Multiplikation aus, wobei die Addition
die Rolle der Multiplikation und das Minimum die Rolle der Addition einnimmt
-- auch wenn wir mehrere Matrix-Multiplikationen benötigen werden.
Tatsächlich steckt dahinter der sogenannte tropische Halbring
$(RR union {oo}, min, +)$. Da es nichts besseres gibt, als algebraische
Strukturen in Haskell zu implementieren, wollen wir uns dieses Vergnügen
natürlich nicht nehmen lassen.

- Erweitere zuerst einen beliebigen Typen (der eine `Num`-Instanz hat) um $oo$. Definiere dafür einen Typen `WithInf a` mit
  entsprechenden Konstruktoren. Implementiere ebenso `Show`-,
  `Eq`-, `Ord`- und `Num`-Instanzen für diesen Typen.
  Zur Orientierung, wie die Arithmetik mit $oo$ umgesetzt werden kann, kannst
  du #link("https://de.wikipedia.org/wiki/Erweiterte_reelle_Zahlen")[Erweiterte reelle Zahlen]
  konsultieren. Du kannst jede undefinierte Operation auf `undefined`
  setzen.
- Als Nächstes wollen wir $min$ und $+$ als `(+)` und `(*)`
  umsetzen. Dafür verwenden wir einen Hilfstypen, der uns erlaubt, eine
  entsprechende `Num`-Instanz anzugeben.
  ```haskell
  newtype Tropical a = Tropical { getTropical :: WithInf a }
    deriving (Eq, Ord)

  instance Show a => Show (Tropical a) where
    show (Tropical x) = show x
  ```
  Implementiere dann für `Tropical` eine `Num`-Instanz. Welche Typeinschränkungen benötigen wir für `a` in `Tropical a`?
- Implementiere eine `Num`-Instanz für den Typen
  `newtype Mat a = Mat [[a]]`, ohne `(!!)` zu nutzen. Für die
  Multiplikation bietet sich unter Umständen `transpose` aus
  `Data.List` an -- oder du implementierst die Funktion selbst.
  `signum`, `abs` und `fromInteger` kannst du auf
  `undefined` setzen.
- In den vorherigen zwei Teilaufgaben sind die Definitionen für
  `fromInteger` nicht unmittelbar korrekt definierbar.
  - Welche Ergebnisse sollten `sum []` und `product []` haben
    und welche Rolle spielen `fromInteger 0` und `fromInteger 1`
    dabei? Wieso stellt das für uns kein Problem dar, wenn wir die
    Skalarprodukte der Zeilen und Spalten der (nicht-leeren) Matrizen im Zuge
    der Matrix-Multiplikation berechnen?
  - Jenseits des Problems, dass wir die Dimensionen einer Matrix nicht kennen,
    um `fromInteger` für Matrizen zielführend nutzen zu können, wie
    würde sich dieses auf $W^0$ auswirken?
- Nun haben wir alle Zutaten, um einen alternativen kürzeste Wege
  Algorithmus zu implementieren. Sei $W = (w_(i j)) in (RR union {oo})^(n times n)$
  dafür eine Matrix, die alle Kantengewichte für einen Digraph
  $G = (V, E)$ mit $V = {1, ..., n}$ enthält. $W$ erfüllt hier $(u, v) in E <=> w_(u v) < oo$ für $u != v$, und $w_(u u) = 0$ für alle $u$.

  Wenn wir nun z.B. $W^k$ im Sinne des tropischen Halbrings berechnen, dann
  besteht diese Matrix aus den Distanzen der kürzesten Wege, die aus maximal $k$ Kanten bestehen -- das kann man sich an einem kleinen Beispiel klarmachen.
  Berechnen wir also $W^n$ erhalten wir die Distanzmatrix für $G$.
  Implementiere eine Funktion
  `shortestPaths :: (Num a, Ord a) => Mat (WithInf a) -> Mat (WithInf a)`,
  die die Distanzmatrix berechnet.

#remark[
  Diese Aufgabe verallgemeinert #xref("binary-exponentiation"), #xref("mat22") und #xref("log-fib") bzgl. der
  Arithmetik mit Matrizen.

  Während der Name des vorgestellten Halbrings bereits äußerst belustigend ist,
  möchte der Autor dieser Aufgabe an dieser Stelle zusätzlich anmerken, dass
  es auch den arktischen Halbring $(RR union {-oo}, max, +)$ gibt, und große
  Anerkennung an den- oder diejenige aussprechen, der oder die diesen Halbring
  benannt hat.

  Diese Aufgabe nimmt es mit den Gesetzen der `Num`-Typklasse nicht ganz genau. Was
  das Problem ist und wie es sauberer ginge, steht in #xref("tropical-num-laws").
]
