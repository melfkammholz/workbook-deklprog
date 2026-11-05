int(0).
int(N) :- int(N, 1).
int(N, N).
int(N, M) :- N is -M.
int(N, M) :- K is M + 1, int(N, K).

#ifdef TEMPLATE
f(X, Y) :- Y is 2 * X + 1.
#else
f(X, Y) :- nonvar(X), !, Y is 2 * X + 1.
f(X, Y) :- nonvar(Y), !, (Y - 1) mod 2 =:= 0, X is (Y - 1) // 2.
f(X, Y) :- int(X), Y is 2 * X + 1.
#endif
