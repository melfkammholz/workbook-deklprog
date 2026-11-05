Für die nächste Ausgabe des Mittelerde-Kuriers benötigst du noch ein
Titelbild für den Artikel "Die Gefährten ziehen zum Schicksalsberg". Dafür
möchtest du die Gefährten der Größe nach aufstellen. Merry und Pippin sind
sich nicht einig darüber, wer der größere der beiden ist. Du entscheidest
dich, beide Varianten zu fotografieren.

Die Größen-Relation ist mithilfe des folgenden Prädikats festgehalten.
```prolog
before(X, Y, Xs) :- append(_, [X|R], Xs), append(_, [Y|_], R).

smaller(X, Y) :- before(X, Y, [frodo, merry, pippin, sam]).
smaller(pippin, merry).
```

- Implementiere ein Prädikat `insert/4`, das ein Element bzgl.
  einer Ordnung in eine gegebene Liste einfügt.
  ```prolog
  ?- insert(smaller, merry, [pippin], Fs).
  Fs = [merry, pippin] ;
  Fs = [pippin, merry].
  ```
  Falls dir Prädikate höherer Ordnung Schwierigkeiten bereiten, kannst du auch
  zuerst versuchen, eine Implementierung mit einer festen $<$-Relation
  angeben.
- Implementiere mithilfe des `insert`-Prädikats Sortieren durch
  Einfügen. Das Prädikat sollte dann beide Sortierungen ausgeben.
  ```prolog
  ?- isort(smaller, [sam, pippin, frodo, merry], Fs).
  Fs = [frodo, merry, pippin, sam] ;
  Fs = [frodo, pippin, merry, sam].
  ```
