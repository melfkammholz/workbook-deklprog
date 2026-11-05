check("map",                          equals(L, map(succ, [1, 2], L), [2, 3])).
check("map auf der leeren Liste",     equals(L, map(succ, [], L), [])).
check("filter",                       equals(L, filter(integer, [1, a, 2, b], L), [1, 2])).
check("filter auf der leeren Liste",  equals(L, filter(integer, [], L), [])).
check("foldr summiert",               equals(R, foldr(plus, 0, [1, 2, 3], R), 6)).
check("foldr klammert rechts",        equals(R, foldr(atom_concat, '', [a, b, c], R), abc)).
check("all: alle erfüllen es",        holds(all(integer, [1, 2]))).
check("all: eines nicht",             fails(all(integer, [1, a]))).
check("all auf der leeren Liste",     holds(all(integer, []))).
