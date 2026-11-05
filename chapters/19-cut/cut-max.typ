Wie können wir mithilfe des Cut-Operators im folgenden Prädikat Berechnungen
sparen?
```prolog
max(X, Y, X) :- X >= Y.
max(X, Y, Y) :- X < Y.
```
