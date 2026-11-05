Gegeben sei das Prolog-Programm:
```prolog
nth(0, [X|_], X).
nth(N, [_|Xs], X) :- N > 0, M is N - 1, nth(M, Xs, X).
```

Wir beginnen, eine Lösung zu berechnen, wie Prolog sie berechnen würde, für die Anfrage `?- nth(1, [3, 1, 4, 1], X).`.
```prolog
  ?- nth(1, [3, 1, 4, 1], X).
|- (2. Regel)
?- 1 > 0, M is 1 - 1, nth(M, [1, 4, 1], X).
|- (2. Regel)
?- 1 > 0, M is 1 - 1, M > 0, M is M - 1, nth(M, [4, 1], X).
|-
...
```
Was ist hier schief gelaufen?
