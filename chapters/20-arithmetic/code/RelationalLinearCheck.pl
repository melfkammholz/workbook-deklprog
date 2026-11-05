check("vorwärts",                     equals(Y, f(1, Y), 3)).
check("ein Paar prüfen",              holds(f(1, 3))).
check("ein falsches Paar",            fails(f(1, 4))).
check("rückwärts",                    equals(X, f(X, 3), 1)).
check("rückwärts ins Negative",       equals(X, f(X, -1), -1)).
check("rückwärts ohne ganze Lösung",  fails(f(_, 4))).
check("beide frei: die ersten Lösungen",
      holds((findall(X-Y, limit(3, f(X, Y)), L), L == [0-1, 1-3, -1 - -1]))).
