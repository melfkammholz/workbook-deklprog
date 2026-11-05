Was sind die Ausgaben der jeweiligen Prolog-Programme, wenn für die Anfrage `?- a(1).` alle Lösungen angefordert werden?
#grid(
  columns: (1fr, 1fr),
  [
    Programm 1:
    ```prolog
    a(1) :- writeln(a).
    a(2) :- writeln(b).
    a(1) :- writeln(c), !.
    a(1) :- writeln(d).
    a(2) :- writeln(e).
    ```
  ],
  [
    Programm 2:
    ```prolog
    a(1) :- writeln(a).
    a(1) :- false, !, writeln(b).
    a(2) :- writeln(c).
    a(1) :- !, writeln(d).
    a(1) :- writeln(e), !.
    a(1) :- writeln(f).
    a(2) :- writeln(g).
    ```
  ]
)
