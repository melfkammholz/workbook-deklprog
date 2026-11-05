p(0, o).
p(N, s(P)) :- N > 0, M is N - 1, p(M, P).

ps([], []).
ps([N|Ns], [P|Ps]) :- p(N, P), ps(Ns, Ps).

check("range: das Beispiel",          holds(range(s(o), s(s(s(o))), [s(o), s(s(o))]))).
check("range: leeres Intervall",      equals(L, range(s(o), s(o), L), [])).
check("filter_by_prime entfernt Vielfache",
      holds((ps([2, 3, 4, 5, 6], Xs), p(2, P), ps([3, 5], Ys), filter_by_prime(P, Xs, Ys)))).
check("filter_by_prime behält den Rest",
      holds((ps([5, 7], Xs), p(3, P), filter_by_prime(P, Xs, Xs)))).
check("primes bis 2",                 holds((p(2, N), ps([2], Ps), primes(N, Ps)))).
check("primes bis 10",                holds((p(10, N), ps([2, 3, 5, 7], Ps), primes(N, Ps)))).
check("primes bis 1 gibt es keine",   equals(Ps, primes(s(o), Ps), [])).
