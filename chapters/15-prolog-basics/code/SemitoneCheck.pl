check("c geht zu cs",           holds(semitone(c, cs))).
check("b geht zurück zu c",     holds(semitone(b, c))).
check("c geht nicht zu d",      fails(semitone(c, d))).
check("jeder Ton hat genau einen Nachfolger", solutions(Y, semitone(c, Y), [cs])).
check("und genau einen Vorgänger", solutions(X, semitone(X, c), [b])).
check("die Akkorde funktionieren weiter", holds(chord(major(c, e, g)))).
