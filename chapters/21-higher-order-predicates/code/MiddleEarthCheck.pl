check("insert: das Beispiel",         solutions(F, insert(smaller, merry, [pippin], F), [[merry, pippin], [pippin, merry]])).
check("insert in eine leere Liste",   solutions(F, insert(smaller, sam, [], F), [[sam]])).
check("insert mit einer anderen Ordnung", solutions(F, insert(@<, 2, [1, 3], F), [[1, 2, 3]])).
check("isort: beide Reihenfolgen",    solutions(F, isort(smaller, [sam, pippin, frodo, merry], F),
      [[frodo, merry, pippin, sam], [frodo, pippin, merry, sam]])).
check("isort mit einer anderen Ordnung", solutions(F, isort(@<, [3, 1, 2], F), [[1, 2, 3]])).
