#ifdef TEMPLATE
% Implement zebra/2 here.
#else
right_of(R, L, Hs) :- append(_, [L, R|_], Hs).

next_to(A, B, Hs) :- right_of(A, B, Hs) ; right_of(B, A, Hs).

% h(Nationality, Colour, Pet, Drink, Cigarettes)
zebra(Water, Zebra) :-
  length(Hs, 5),
  member(h(englaender, rot, _, _, _), Hs),
  member(h(spanier, _, hund, _, _), Hs),
  member(h(_, gruen, _, kaffee, _), Hs),
  member(h(ukrainer, _, _, tee, _), Hs),
  right_of(h(_, gruen, _, _, _), h(_, weiss, _, _, _), Hs),
  member(h(_, _, schnecken, _, oldgold), Hs),
  member(h(_, gelb, _, _, kools), Hs),
  Hs = [_, _, h(_, _, _, milch, _), _, _],
  Hs = [h(norweger, _, _, _, _)|_],
  next_to(h(_, _, _, _, chesterfield), h(_, _, fuchs, _, _), Hs),
  next_to(h(_, _, _, _, kools), h(_, _, pferd, _, _), Hs),
  member(h(_, _, _, orangensaft, luckystrike), Hs),
  member(h(japaner, _, _, _, parliaments), Hs),
  next_to(h(norweger, _, _, _, _), h(_, blau, _, _, _), Hs),
  member(h(Water, _, _, wasser, _), Hs),
  member(h(Zebra, _, zebra, _, _), Hs).
#endif
