#ifdef TEMPLATE
% Implement all_btrees/2 here.
#else
all_btrees(0, [empty]).
all_btrees(N, Ts) :-
  N > 0,
  M is N - 1,
  findall(
    branch(L, R),
    (
      between(0, M, I), J is M - I,
      all_btrees(I, Ls), member(L, Ls),
      all_btrees(J, Rs), member(R, Rs)
    ),
    Ts
  ).
#endif
