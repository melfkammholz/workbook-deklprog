Gegeben sei folgendes Prolog-Programm.
```prolog
append([],    L, L     ).
append([E|R], L, [E|RL]) :- append(R, L, RL).
```
Es wird die Anfrage `?- append(X, Y, [1, 2]).` gestellt. Beim
Anwenden der zweiten Regel wurde die Substitution
$ sigma_1 = { X |-> [E_1|R_1], Y |-> L_1, E_1 |-> 1, R L_1 |-> [2] } $
berechnet. Ist diese Substitution ein Unifikator für
`append(X, Y, [1, 2])` und
`append([E1|R1], L1, [E1|RL1])`, der aus dem
Unifikationsalgorithmus entstanden ist?
