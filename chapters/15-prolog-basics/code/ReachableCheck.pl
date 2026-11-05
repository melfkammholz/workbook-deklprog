check("das Beispiel mit Kreis",        holds(reachable(1, 3, [(1, 2), (2, 3), (3, 1)]))).
check("das Beispiel ohne Pfad",        fails(reachable(1, 3, [(1, 2), (3, 2)]))).
check("ein Knoten erreicht sich selbst", holds(reachable(1, 1, []))).
check("nicht gegen die Kante",         fails(reachable(2, 1, [(1, 2)]))).
check("hält auf einem Kreis an",       fails(reachable(1, 9, [(1, 2), (2, 1)]))).
check("findet hinter einem Kreis",     holds(reachable(1, 4, [(1, 2), (2, 1), (2, 3), (3, 4)]))).
