Gegeben sei das folgende Prolog-Programm.
```prolog
p(a).
p(b).
q(b).
r(X) :- p(X), q(X).
```
Gib den SLD-Baum für die Anfrage `?- r(Y).` an. Schreibe an jede Kante die umbenannte
Klausel und den Unifikator. Welche Lösungen berechnet Prolog?

#sample[
  ```text
  ?- r(Y).
  |  r(X1) :- p(X1), q(X1).      {Y |-> X1}
  ?- p(X1), q(X1).
  |-- p(a).                      {X1 |-> a}
  |   ?- q(a).
  |   (keine Klausel passt, Fehlschlag)
  |-- p(b).                      {X1 |-> b}
      ?- q(b).
      |  q(b).                   {}
      ?- .
  ```
  Die einzige Lösung ist $sigma = {Y |-> b}$. Auf dem Weg dorthin gilt
  ${X_1 |-> b} compose {Y |-> X_1} = {X_1 |-> b, Y |-> b}$, eingeschränkt auf die
  Variablen der Anfrage bleibt ${Y |-> b}$.
]
