nodes(empty, 0).
nodes(branch(L, R), N) :- nodes(L, A), nodes(R, B), N is A + B + 1.

check("kein Knoten",              equals(T, all_btrees(0, T), [empty])).
check("ein Knoten",               equals(T, all_btrees(1, T), [branch(empty, empty)])).
check("zwei Knoten",              holds((all_btrees(2, Ts), msort(Ts, S), msort([branch(empty, branch(empty, empty)), branch(branch(empty, empty), empty)], S)))).
check("die Anzahl für 4 Knoten",  holds((all_btrees(4, Ts), length(Ts, 14)))).
check("alle haben die richtige Größe", holds((all_btrees(3, Ts), forall(member(T, Ts), nodes(T, 3))))).
