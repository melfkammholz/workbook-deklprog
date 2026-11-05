Gegeben sei das Prädikat
```prolog
f(X, Y) :- Y is 2 * X + 1.
```
das die Funktion $f(x) = 2x + 1$ in Prolog modelliert.
- Welche Anfragen der Form `?- f(X, Y)`, wobei
  `X` und `Y` frei oder gebunden sein können,
  sind nicht beweisbar und warum?
- Verbessere `f/2` so, dass `f/2` als $f^(-1)$
  verwendet werden kann. Als Hilfsprädikate kannst du die Prädikate
  `var/1` und `nonvar/1` verwenden.
- Warum ist `?- f(X, Y)` mit freien Variablen
  `X` und `Y` weiterhin problematisch?
- Wie könnte das Prädikat
  ```prolog
  int(0).
  int(N) :- int(N, 1).
  int(N, N).
  int(N, M) :- N is -M.
  int(N, M) :- K is M + 1, int(N, K).
  ```
  das Problem der vorherigen Teilaufgabe lösen?
