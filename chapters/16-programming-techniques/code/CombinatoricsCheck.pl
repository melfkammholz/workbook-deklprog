check("das Beispiel",                holds(varia_rep([0, 1], 4, [1, 0, 0, 1]))).
check("falsche Länge",               fails(varia_rep([0, 1], 3, [1, 0, 0, 1]))).
check("falsches Element",            fails(varia_rep([0, 1], 2, [1, 2]))).
check("Länge 0",                     solutions(X, varia_rep([0, 1], 0, X), [[]])).
check("alle der Länge 2",            solutions(X, varia_rep([0, 1], 2, X), [[0, 0], [0, 1], [1, 0], [1, 1]])).
check("eine Permutation",            holds(perms([1, 2, 3], [3, 1, 2]))).
check("keine Permutation",           fails(perms([1, 2], [1, 3]))).
check("andere Häufigkeiten",         fails(perms([1, 1, 2], [1, 2, 2]))).
check("alle Permutationen",          solutions(X, perms([1, 2, 3], X),
      [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])).
