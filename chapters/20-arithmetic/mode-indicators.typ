Du hast Prolog lieben gelernt und liest die Dokumentation von SWI-Prolog
gerne vor dem Schlafen gehen. Du entdeckst sonderliche Sonderzeichen vor den
Variablen eines Prädikats und fragst dich, wofür diese stehen. Das sind
sogenannte #link("https://www.swi-prolog.org/pldoc/man?section=argmode")[argument mode indicators]
und deuten an, wie Informationen durch ein Prädikat fließen.

Was bedeuten die Indikatoren des `is/2`-Prädikats (siehe
#link("https://www.swi-prolog.org/pldoc/man?predicate=is/2")[`is/2`-Dokumentation])?

#remark[
  Uns ist bisher kein nicht vollständig instanziierter Ausdruck eingefallen,
  den wir unter der Verwendung von ausschließlich vorlesungsbekannten
  Prädikaten konstruieren können. Um dennoch ein Beispiel gesehen zu haben,
  warum `Expr` mit `+` annotiert ist und nicht mit
  `++`, betrachte folgendes Programm:
  ```prolog
  :- arithmetic_function(mult/2).
  mult(0, _, 0) :- !.
  mult(_, 0, 0) :- !.
  mult(X, Y, Z) :- Z is X * Y.

  ?- X is mult(0, Y).
  X = 0.
  ```
  Die rechte Seite muss so also nur hinreichend instanziiert sein, damit
  `is/2` beweisbar ist.
]
