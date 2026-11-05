#ifdef TEMPLATE semitone-append
semitone(c, cs). semitone(cs, d). semitone(d, ds). semitone(ds, e).
semitone(e, f). semitone(f, fs). semitone(fs, g). semitone(g, gs).
semitone(gs, a). semitone(a, as). semitone(as, b). semitone(b, c).
#else
semitone(X, Y) :-
  append(_, [X, Y|_], [c, cs, d, ds, e, f, fs, g, gs, a, as, b, c]).
#endif

minor_third(P1, Mi3) :-
  semitone(P1, Mi2), semitone(Mi2, Ma2), semitone(Ma2, Mi3).

major_third(P1, Ma3) :- minor_third(P1, Mi3), semitone(Mi3, Ma3).

chord(minor(P1, Mi3, P5)) :- minor_third(P1, Mi3), major_third(Mi3, P5).
chord(major(P1, Ma3, P5)) :- major_third(P1, Ma3), minor_third(Ma3, P5).

#ifdef TEMPLATE all-major
% Implement all_major/2 here.
#else
whole_tone(X, Z) :- semitone(X, Y), semitone(Y, Z).

major_scale(P0, [P0, P1, P2, P3, P4, P5, P6]) :-
  whole_tone(P0, P1), whole_tone(P1, P2), semitone(P2, P3),
  whole_tone(P3, P4), whole_tone(P4, P5), whole_tone(P5, P6).

all_major(R, Cs) :-
  major_scale(R, Scale),
  findall(
    major(P1, Ma3, P5),
    (member(P1, Scale), chord(major(P1, Ma3, P5)), member(Ma3, Scale), member(P5, Scale)),
    Cs
  ).
#endif
