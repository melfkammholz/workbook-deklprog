check("Implikation wird übersetzt",  equals(F, desugar(impl(var(a), var(b)), F), or(neg(var(a)), var(b)))).
check("Variablen bleiben",           equals(F, desugar(var(a), F), var(a))).
check("Konstanten bleiben",          equals(F, desugar(true, F), true)).
check("auch unter Junktoren",        equals(F, desugar(neg(impl(var(a), false)), F), neg(or(neg(var(a)), false)))).
check("Äquivalenz: gleiche Werte erfüllen",
      holds((desugar(iff(var(a), var(b)), F), sat(F, A), msort(A, [(a, true), (b, true)])))).
check("Äquivalenz: ungleiche Werte nicht",
      fails((desugar(iff(var(a), var(b)), F), sat(F, A), msort(A, [(a, false), (b, true)])))).
