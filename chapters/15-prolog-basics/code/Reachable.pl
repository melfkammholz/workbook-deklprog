reachable(X, Y, G) :- reachable(X, Y, G, []).

#ifdef TEMPLATE
% Implement reachable/4 here.
#else
not_member(_, []).
not_member(X, [Y|Xs]) :- X \= Y, not_member(X, Xs).

reachable(X, X, _, _).
reachable(X, Y, G, V) :-
  not_member(X, V),
  member((X, Z), G),
  reachable(Z, Y, G, [X|V]).
#endif
