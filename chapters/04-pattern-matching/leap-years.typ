Im gregorianischen Kalender ist ein Jahr ein Schaltjahr, wenn es durch 4
teilbar ist. Ausgenommen sind Jahre, die durch 100 teilbar sind, es sei denn,
sie sind auch durch 400 teilbar. 2024 und 2000 sind also Schaltjahre, 2023 und
1900 nicht.

Im Editor steht eine Funktion `isLeap`, die genau diese Regel umsetzen soll.
Sie sieht richtig aus, ist es aber nicht.

+ Finde ein Jahr, für das `isLeap` das falsche Ergebnis liefert. Probiere es
  im Interpreter aus, bevor du die Tests startest.
+ Erkläre, warum `isLeap` für dieses Jahr falsch ist.
+ Korrigiere `isLeap`, indem du nur die Reihenfolge der Guards änderst.

#hint[
  Für welche Jahre kommt der zweite Guard überhaupt zum Zug?
]
#hint[
  Probiere ein Jahr, das durch 100 teilbar ist, aber nicht durch 400.
]

#remark[
  Ohne Guards lässt sich die Regel auch als eine Formel schreiben:
  ```haskell
  isLeap year = (year `mod` 4 == 0 && year `mod` 100 /= 0) || year `mod` 400 == 0
  ```
  Welche Variante liest sich für dich besser?
]

#sample[
  `isLeap 1900` ergibt `True`, richtig wäre `False`. Jedes Jahr, das durch 100
  oder 400 teilbar ist, ist auch durch 4 teilbar. Deshalb trifft für solche
  Jahre immer schon der erste Guard zu, und die beiden folgenden werden nie
  erreicht. Die Guards müssen vom speziellsten zum allgemeinsten Fall
  geordnet sein: erst 400, dann 100, dann 4.
]
