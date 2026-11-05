Gegeben sei das folgende Prolog-Programm.
```prolog
app([],    L, L).
app([E|R], L, [E|RL]) :- app(R, L, RL).
```
Gib den SLD-Baum für die Anfrage `?- app(X, Y, [1]).` an. Benenne die Variablen der
Klauseln in jedem Schritt um. Welche Lösungen berechnet Prolog, und an welcher Stelle
schlägt eine Unifikation fehl?

#sample[
  ```text
  ?- app(X, Y, [1]).
  |-- app([], L1, L1).                     {X |-> [], Y |-> [1], L1 |-> [1]}
  |   ?- .
  |-- app([E1|R1], L1, [E1|RL1]) :- ...    {X |-> [1|R1], Y |-> L1, E1 |-> 1, RL1 |-> []}
      ?- app(R1, L1, []).
      |-- app([], L2, L2).                 {R1 |-> [], L1 |-> [], L2 |-> []}
      |   ?- .
      |-- app([E2|R2], L2, [E2|RL2]) :- ...
          (Fehlschlag: [] und [E2|RL2] sind nicht unifizierbar)
  ```
  Die Lösungen sind $sigma_1 = {X |-> [], Y |-> [1]}$ und
  $sigma_2 = {X |-> [1], Y |-> []}$. Für $sigma_2$ ergibt sich aus der Komposition, dass
  $X |-> [1|R_1]$ mit $R_1 |-> []$ zu $X |-> [1]$ wird.
]
