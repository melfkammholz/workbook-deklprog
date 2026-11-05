Implementiere ein Prädikat `all_trees/2`, das jeden möglichen
blattbeschrifteten Binärbaum erzeugt, deren Blätter von links nach rechts die
Eingabeliste lesen.
```prolog
?- all_trees([1, 2, 3], Ts).
Ts = [
  branch(leaf(1), branch(leaf(2), leaf(3))),
  branch(branch(leaf(1), leaf(2)), leaf(3))
].
```
- Implementiere zuerst eine Variante, in der du auf keine besonderen
  Hilfsprädikate zurückgreifst.
- Gegeben sei folgende fehlerhafte Implementierung des Prädikats.
  ```prolog
  all_trees([], []).
  all_trees([X], [leaf(X)]) :- !.
  all_trees(Xs, Ts) :-
    member(branch(Lt, Rt), Ts),
    append([L|Ls], [R|Rs], Xs),
    all_trees([L|Ls], Lts),
    member(Lt, Lts),
    all_trees([R|Rs], Rts),
    member(Rt, Rts).
  ```
  Auf dem ersten Blick scheint eine elegante Idee hinter dieser Definition zu
  stecken. Wieso funktioniert diese Idee allerdings nicht?
- Korrigiere die fehlerhafte Definition unter Verwendung von
  `findall/3` und erhalte dabei grundsätzliche Idee.
- Staune darüber, wie vergleichsweise müheselig das Implementieren der ersten
  Variante ohne Hilfsprädikate war, und sei dankbar für
  `findall/3`.
