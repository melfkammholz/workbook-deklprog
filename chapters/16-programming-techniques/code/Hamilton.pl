graph([(1, 2), (2, 3), (3, 4), (3, 5), (4, 5), (4, 1), (5, 1), (5, 4)]).

#ifdef TEMPLATE
% Implement is_hamilton/2, path/2 and hamilton/2 here.
#else
edge(V, W, G) :- member((V, W), G).

nodes(G, Vs) :- setof(X, A^B^(edge(A, B, G), (X = A ; X = B)), Vs).

path(G, P) :-
  nodes(G, Vs), min_list(Vs, V), length(Vs, N),
  path_from(G, V, N, [V], P).

path_from(_, _, 1, A, P) :- reverse(A, P).
path_from(G, V, N, A, P) :-
  N > 1,
  edge(V, W, G),
  \+ member(W, A),
  M is N - 1,
  path_from(G, W, M, [W|A], P).

is_hamilton(G, P) :-
  P = [First|_],
  last(P, Last),
  edge(Last, First, G),
  forall(append(_, [V, W|_], P), edge(V, W, G)),
  nodes(G, Vs), length(P, N), length(Vs, N), sort(P, Vs).

hamilton(G, P) :- path(G, P), is_hamilton(G, P).
#endif
