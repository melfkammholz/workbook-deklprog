Ordne die Begriffe Atom, Fakt, Regel und Variable dem folgenden
Prolog-Programm zu.
```prolog
semitone(c, cs). semitone(cs, d). semitone(d, ds). semitone(ds, e).
semitone(e, f). semitone(f, fs). semitone(fs, g). semitone(g, gs).
semitone(gs, a). semitone(a, as). semitone(as, b). semitone(b, c).

minor_third(P1, Mi3) :-
  semitone(P1, Mi2), semitone(Mi2, Ma2), semitone(Ma2, Mi3).

major_third(P1, Ma3) :- minor_third(P1, Mi3), semitone(Mi3, Ma3).

chord(minor(P1, Mi3, P5)) :- minor_third(P1, Mi3), major_third(Mi3, P5).
chord(major(P1, Ma3, P5)) :- major_third(P1, Ma3), minor_third(Ma3, P5).
```
