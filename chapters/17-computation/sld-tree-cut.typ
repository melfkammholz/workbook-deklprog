Gegeben sei das folgende Prolog-Programm.
```prolog
q(1).
q(2).
r(2).
p(X) :- q(X), !, r(X).
p(3).
```
Gib den SLD-Baum für die Anfrage `?- p(Y).` an und markiere, welche Teile durch den Cut
abgeschnitten werden. Welche Lösungen berechnet Prolog? Wie verändert sich das Ergebnis,
wenn wir den Cut entfernen?

#sample[
  ```text
  ?- p(Y).
  |-- p(X1) :- q(X1), !, r(X1).    {Y |-> X1}
  |   ?- q(X1), !, r(X1).
  |   |-- q(1).                    {X1 |-> 1}
  |   |   ?- !, r(1).
  |   |   |  (Cut)
  |   |   ?- r(1).
  |   |   (keine Klausel passt, Fehlschlag)
  |   |-- q(2).                    abgeschnitten
  |-- p(3).                        abgeschnitten
  ```
  Prolog berechnet keine Lösung, die Antwort ist `false`. Ohne den Cut gibt es die
  Lösungen ${Y |-> 2}$ und ${Y |-> 3}$.
]
