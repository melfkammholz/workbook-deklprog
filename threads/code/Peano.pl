#ifdef TEMPLATE peano
% Implement peano/1, add/3, lt/2 and eq/2 here.
#else
peano(o).
peano(s(X)) :- peano(X).

add(o, Y, Y).
add(s(X), Y, s(Z)) :- add(X, Y, Z).

lt(o, s(_)).
lt(s(X), s(Y)) :- lt(X, Y).

eq(o, o).
eq(s(X), s(Y)) :- eq(X, Y).
#endif

#ifdef TEMPLATE to-nat
% Implement to_nat/2 here.
#else
to_nat(o, 0).
to_nat(s(P), N) :- to_nat(P, M), N is M + 1.
#endif

#ifdef TEMPLATE sieve
% Implement range/3, filter_by_prime/3 and primes/2 here.
#else
range(L, U, []) :- \+ lt(L, U).
range(L, U, [L|R]) :- lt(L, U), range(s(L), U, R).

divides(_, o).
divides(P, X) :- add(P, R, X), divides(P, R).

filter_by_prime(_, [], []).
filter_by_prime(P, [X|Xs], Ys) :- divides(P, X), !, filter_by_prime(P, Xs, Ys).
filter_by_prime(P, [X|Xs], [X|Ys]) :- filter_by_prime(P, Xs, Ys).

primes(N, Ps) :- range(s(s(o)), s(N), Xs), sieve(Xs, Ps).

sieve([], []).
sieve([P|Xs], [P|Ps]) :- filter_by_prime(P, Xs, Ys), sieve(Ys, Ps).
#endif
