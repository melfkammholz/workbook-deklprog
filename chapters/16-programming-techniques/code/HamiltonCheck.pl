g([(1, 2), (2, 3), (3, 4), (3, 5), (4, 5), (4, 1), (5, 1), (5, 4)]).

check("is_hamilton: ein Kreis",      holds((g(G), is_hamilton(G, [1, 2, 3, 4, 5])))).
check("is_hamilton: der andere Kreis", holds((g(G), is_hamilton(G, [1, 2, 3, 5, 4])))).
check("is_hamilton: keine Kante",    fails((g(G), is_hamilton(G, [1, 3, 2, 4, 5])))).
check("is_hamilton: ein Knoten fehlt", fails((g(G), is_hamilton(G, [1, 2, 3, 4])))).
check("is_hamilton: die Kante zurück fehlt", fails(is_hamilton([(1, 2), (2, 3)], [1, 2, 3]))).
check("hamilton: das Beispiel",      solutions(P, (g(G), hamilton(G, P)), [[1, 2, 3, 4, 5], [1, 2, 3, 5, 4]])).
check("hamilton: ein Pfad ist kein Kreis", fails(hamilton([(1, 2), (2, 3)], _))).
check("hamilton: ein Dreieck",       solutions(P, hamilton([(1, 2), (2, 3), (3, 1)], P), [[1, 2, 3]])).
