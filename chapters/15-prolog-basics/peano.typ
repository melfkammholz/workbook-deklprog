In diesem Selbsttest wollen wir die Peano-Arithmetik wiederholen.
Implementiere folgende Prädikate:
- `peano/1` soll beweisbar sein, wenn der übergebene Term
  eine Peano-Zahl ist, also z.B. die Form `o, s(o), s(s(o)), ...`
  hat.
- `add/3` soll die Addition auf Peano-Zahlen implementieren.
- Die Multiplikation kann wie folgt definiert werden:
  ```prolog
  mult(o, _, o).
  mult(s(X), Y, Z) :- add(U, Y, Z), mult(X, Y, U).
  ```
  Eine alternative Implementierung könnte so aussehen:
  ```prolog
  mult(o, _, o).
  mult(s(X), Y, Z) :- mult(X, Y, U), add(U, Y, Z).
  ```
  Welche der beiden Implementierungen ist besser? Betrachte während deiner Überlegungen auch die Anfragen `?- mult(s(s(o)), Y, s(s(s(s(o))))).` und `?- mult(X, s(s(o)), s(s(s(s(o))))).` -- also sinngemäß die Anfragen $2 dot y = 4$ und $x dot 2 = 4$. Lass dir dabei alle Lösungen ausgeben.
- Implementiere weiter die Prädikate `lt/2, eq/2` für
  Peano-Zahlen, also die $<$-Relation und Gleichheit auf Peano-Zahlen.
