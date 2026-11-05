Diese Seite geht über die Vorlesung hinaus und ist für dich, falls dich das Thema besonders interessiert. Sie gehört zu #xref("tropical").

Wie auch bei anderen Typklassen muss eine `Num`-Instanz Gesetze erfüllen. Zu
diesen gehört unter anderem, dass `fromInteger 0` das neutrale Element bzgl. der
Addition und `fromInteger 1` das neutrale Element bzgl. der Multiplikation sein
soll. Das steht im Konflikt damit, dass wir auch die Werte
`Tropical (Number 0)` und `Tropical (Number 1)` mithilfe dieser Funktion erzeugen
möchten. Wenn wir die Gesetze erfüllen wollen, dann müssen wir
`fromInteger 0 = Tropical Inf` und `fromInteger 1 = Tropical (Number 0)` setzen.
Insbesondere in der Absicht, vordefinierte Funktionen wie `sum`, `product` oder
`(^)` zu verwenden, stellt das über die Aufgabe hinweg ein Problem dar.

Ein "saubereres" Vorgehen könnte es z.B. sein, Halbringe mithilfe von gesonderten
Typklassen zu definieren, welche die neutralen Elemente expliziter machen und die
zwei Verwendungszwecke von `fromInteger` trennen. Siehe z.B.
#link("https://hackage.haskell.org/package/semirings/docs/Data-Semiring.html")[Data.Semiring],
um zu sehen, wie die Typklasse implementiert werden könnte.
