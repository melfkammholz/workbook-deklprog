Nutze $forall x : p <=> not (exists x : not p)$, um ein Prädikat
`forall/2` zu definieren.

Mithilfe dieses Prädikates soll es möglich sein, folgende Anfrage auszudrücken.
```prolog
?- forall(member(X, [1, 2, 3]), X > 0).
```
Die Anfrage bedeutet, für alle $x in {1, 2, 3}$ gilt $x > 0$.

Wie können wir mit `forall` die Definition von
`not_member` aus #xref("not-member-bug") reparieren?
