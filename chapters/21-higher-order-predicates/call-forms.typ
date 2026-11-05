Welche der folgenden Anfragen berechnen das gleiche Ergebnis, falls sie
valide sind?
- `?- append([1, 2], X, [1, 2, 3]).`
- `?- call(call(call(append, [1, 2]), X), [1, 2, 3]).`
- `?- append([1, 2])(X, [1, 2, 3]).`
- `?- call(append([1, 2], X), [1, 2, 3]).`
- `?- call(call(append([1, 2]), X), [1, 2, 3]).`
- `?- call(append, [1, 2], X, [1, 2, 3]).`
