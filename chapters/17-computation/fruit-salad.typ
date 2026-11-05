Gegeben sei das Prolog-Programm.
```prolog
fruit(apple).
fruit(banana).
fruit(cranberry).

salad(F1, F2, F3) :- fruit(F1), fruit(F2), fruit(F3).
```
Was sind die ersten vier Lösungen, die Prolog berechnet? Warum verändern sich
die Belegungen für `F2` und `F3` zuerst?
