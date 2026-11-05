check("to_nat von o",                 equals(N, to_nat(o, N), 0)).
check("to_nat von s(s(s(o)))",        equals(N, to_nat(s(s(s(o))), N), 3)).
check("rückwärts: die erste Lösung",  equals(P, once(to_nat(P, 2)), s(s(o)))).
