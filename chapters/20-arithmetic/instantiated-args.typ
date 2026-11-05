Das Prädikat `is/2` muss in seinem zweiten Argument hinreichend
instanziiert sein, damit wir es auswerten können. Als Faustregel kann man sich
merken, dass Prädikate, die arithmetische Ausdrücke oder aussagenlogische
Formeln auswerten hinreichend instanziierte Argumente benötigen. Welche
Prädikate gibt es, neben `is/2`, die solche Argumente
benötigen? Warum führt die Anfrage `?- 42 >= X, 42 =< X.` zu einem Fehler, obwohl $X = 42$ eine Lösung wäre?

#remark[
  Ein Teil der hier angesprochenen Probleme werden durch die
  Constraint-Programmierung gelöst, die wir nicht behandelt haben.
]
