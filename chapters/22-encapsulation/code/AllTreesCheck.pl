leaves(leaf(X), [X]).
leaves(branch(L, R), Xs) :- leaves(L, A), leaves(R, B), append(A, B, Xs).

check("eine leere Liste",        equals(T, all_trees([], T), [])).
check("ein Blatt",               equals(T, all_trees([1], T), [leaf(1)])).
check("das Beispiel",            holds((all_trees([1, 2, 3], Ts), msort(Ts, S),
      msort([branch(leaf(1), branch(leaf(2), leaf(3))), branch(branch(leaf(1), leaf(2)), leaf(3))], S)))).
check("die Anzahl für 5 Blätter", holds((all_trees([1, 2, 3, 4, 5], Ts), length(Ts, 14)))).
check("die Blätter lesen die Eingabe", holds((all_trees([1, 2, 3, 4], Ts), forall(member(T, Ts), leaves(T, [1, 2, 3, 4]))))).
