Warum ergibt es Sinn, beim Prolog-Programmieren in Relationen statt
Funktionen zu denken? Betrachte z.B. das Prädikat `append/3`
gemeinsam mit den Anfragen
- `?- append(Xs, Ys, [1, 2, 3]).`,
- `?- append(Xs, [2, 3], Zs).`,
- `?- append([1], [2, 3], Zs).`,
- `?- append([1, 2], Xs, Zs).` und
- `?- append([1, 2], Ys, [1, 2, 3]).`.
Beschreibe, was jede dieser Anfragen berechnet. Welche der Anfragen entspricht
der Anwendung von `append/3` als Funktion, so wie wir es bzgl.
der Benennung des Prädikats erwarten würden?
