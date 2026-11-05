Implementiere ein Prädikat `count_nodes/2`, das die Anzahl
von internen Knoten in einem Binärbaum zählt. Hier ist eine Beispielanwendung
des Prädikats.
```prolog
?- count_nodes(branch(empty, branch(empty, empty)), N).
N = 2.
```
Warum ist die Anfrage `?- count_nodes(T, 2).` problematisch? Wie
kannst du `count_nodes` anpassen, sodass das erwartete Ergebnis
herauskommt?
