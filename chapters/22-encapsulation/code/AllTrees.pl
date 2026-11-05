#ifdef TEMPLATE
% Implement all_trees/2 here.
#else
all_trees([], []).
all_trees([X], [leaf(X)]) :- !.
all_trees(Xs, Ts) :-
  findall(
    branch(Lt, Rt),
    (
      append([L|Ls], [R|Rs], Xs),
      all_trees([L|Ls], Lts), member(Lt, Lts),
      all_trees([R|Rs], Rts), member(Rt, Rts)
    ),
    Ts
  ).
#endif
