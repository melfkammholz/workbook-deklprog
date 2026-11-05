check("o ist eine Peano-Zahl",        holds(peano(o))).
check("s(s(o)) ist eine Peano-Zahl",  holds(peano(s(s(o))))).
check("a ist keine",                  fails(peano(a))).
check("s(a) ist keine",               fails(peano(s(a)))).
check("add: 1 + 2 = 3",               equals(Z, add(s(o), s(s(o)), Z), s(s(s(o))))).
check("add: 0 + 0 = 0",               equals(Z, add(o, o, Z), o)).
check("add rückwärts: alle Zerlegungen von 1",
      solutions(X-Y, add(X, Y, s(o)), [o-s(o), s(o)-o])).
check("lt: 0 < 1",                    holds(lt(o, s(o)))).
check("lt: 1 < 1 gilt nicht",         fails(lt(s(o), s(o)))).
check("lt: 2 < 1 gilt nicht",         fails(lt(s(s(o)), s(o)))).
check("eq: gleiche Zahlen",           holds(eq(s(o), s(o)))).
check("eq: verschiedene Zahlen",      fails(eq(s(o), o))).
