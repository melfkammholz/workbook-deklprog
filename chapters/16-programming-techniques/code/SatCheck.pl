check("bool kennt zwei Werte",       solutions(B, bool(B), [true, false])).
check("and",                         equals(C, and(true, false, C), false)).
check("or",                          equals(C, or(false, true, C), true)).
check("neg",                         equals(C, neg(true, C), false)).
check("get_vars ohne Duplikate",     holds((get_vars(and(var(x), or(var(y), var(x))), Vs), msort(Vs, [x, y])))).
check("get_vars auch mit Konstanten", holds((get_vars(and(true, var(x)), Vs), Vs == [x]))).
check("assignment zählt alle Belegungen auf",
      solutions(A, assignment([x], A), [[(x, true)], [(x, false)]])).
check("eval mit fester Belegung",    fails(eval(and(true, var(x)), [(x, true)], false))).
check("eval findet die Belegung",    equals(B, eval(and(true, var(x)), [(x, B)], false), false)).
check("sat: Tautologie",             solutions(A, sat(or(var(x), neg(var(x))), A), [[(x, true)], [(x, false)]])).
check("sat: das Beispiel",           solutions(A, sat(and(var(x), or(neg(var(y)), neg(var(z)))), A),
      [[(x, true), (y, true), (z, false)], [(x, true), (y, false), (z, true)], [(x, true), (y, false), (z, false)]])).
check("sat: Widerspruch",            fails(sat(and(var(x), neg(var(x))), _))).
check("sat: mit einer Konstanten",   solutions(A, sat(and(true, var(x)), A), [[(x, true)]])).
