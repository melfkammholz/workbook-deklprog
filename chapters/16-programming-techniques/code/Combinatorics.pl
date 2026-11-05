#ifdef TEMPLATE
% Implement varia_rep/3 and perms/2 here.
#else
varia_rep(_, 0, []).
varia_rep(Xs, K, [Y|Ys]) :- K > 0, member(Y, Xs), L is K - 1, varia_rep(Xs, L, Ys).

perms([], []).
perms(Xs, [Y|Ys]) :- select(Y, Xs, Zs), perms(Zs, Ys).
#endif
