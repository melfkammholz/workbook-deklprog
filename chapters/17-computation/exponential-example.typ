Gib ein Beispiel für eine Eingabe an, für das der Unifikationsalgorithmus
exponentielle Laufzeit bzgl. der Größe der Eingabeterme hat.

Die Größe eines Terms $abs(dot)$ können wir z.B. wie folgt berechnen:
- $abs(X) = 1$, falls $X$ Variable ist,
- $abs(a) = 1$, falls $a$ Konstante ist und
- $abs(f(t_1, ..., t_n)) = 1 + sum_(i=1)^n abs(t_i)$ für Terme
  $t_1, ..., t_n$ und $n$-stelligen Funktor $f$.
