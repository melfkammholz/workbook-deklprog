Das Erfüllbarkeitsproblem der Aussagenlogik fragt, ob es für eine gegebene
aussagenlogische Formel eine Belegung der Variablen mit wahr oder falsch
gibt, sodass die Formel insgesamt wahr ist.

Zur Erinnerung, die Syntax aussagenlogischer Formeln ist wie folgt
beschrieben:
- $top$ (true), $bot$ (false) und Variablen sind aussagenlogische Formeln.
- Seien $F, G$ aussagenlogische Formeln, dann sind
  - $not F$ (Negation),
  - $F and G$ (Konjunktion) und
  - $F or G$ (Disjunktion)
  aussagenlogische Formeln.
Die Semantik der atomaren Formeln und der Junktoren wird durch die
entsprechenden booleschen Funktionen und eine Belegung der Variablen
definiert.

- Implementiere zuerst `bool/1`, das den Wertebereich
  festlegen soll, und die booleschen Funktionen `and/3, or/3, neg/2`.
- Implementiere ein Prädikat `get_vars/2`, das alle
  Bezeichner von (freien) Variablen einer gegebenen Formel zurückgibt. Eine
  Variable soll in einer Formel als Term `var(X)`
  gekennzeichnet werden. `X` ist dann der Bezeichner der
  Variable. Stelle dabei sicher, dass die Liste der Bezeichner keine
  Duplikate enthält -- dafür kannst du z.B. `list_to_set/2`
  verwenden.
- Implementiere als Nächstes ein Prädikat `assignment/2`,
  das alle Belegungen generiert. Eine Zuweisung soll als Liste von Tupeln
  dargestellt werden (vgl. Beispielanfragen).
- Implementiere ein Prädikat `eval/3`, das beweisbar ist,
  wenn die gegebene Formel unter der gegebenen Belegung den gegebenen Wahrheitswert hat.
  Hier sind ein paar Beispielanfragen:
  ```prolog
  ?- eval(and(true, var(x)), [(x, true)], false).
  false.

  ?- eval(and(true, var(x)), [(x, B)], false).
  B = false.
  ```
- Implementiere ein Prädikat `sat/2`, das alle belegten
  Formeln berechnet. Hier sind ein paar weitere Beispielanfragen:
  ```prolog
  ?- sat(or(var(x), neg(var(x))), A).
  A = [(x, true)] ;
  A = [(x, false)] ;
  false.

  ?- sat(and(var(x), or(neg(var(y)), neg(var(z)))), A).
  A = [(x, true), (y, true), (z, false)] ;
  A = [(x, true), (y, false), (z, true)] ;
  A = [(x, true), (y, false), (z, false)] ;
  false.

  ?- sat(and(var(x), neg(var(x))), A).
  false.
  ```
