Das Prädikat `sublist/2` soll genau dann erfüllbar sein, wenn
eine gegebene Liste in einer anderen gegebenen Liste enthalten ist. Eine
mögliche Implementierung sieht wie folgt aus:
```prolog
is_prefix([], _).
is_prefix([X|Xs], [X|Ys]) :- is_prefix(Xs, Ys).

sublist(Xs, Ys) :- is_prefix(Xs, Ys).
sublist(Xs, [_|Ys]) :- sublist(Xs, Ys).
```
Was sind die Ergebnisse der Anfrage `?- sublist(Xs, [1, 2]).`?
