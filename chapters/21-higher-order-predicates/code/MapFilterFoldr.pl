#ifdef TEMPLATE
% Implement map/3, filter/3, foldr/4 and all/2 here.
#else
map(_, [], []).
map(F, [X|Xs], [Y|Ys]) :- call(F, X, Y), map(F, Xs, Ys).

filter(_, [], []).
filter(P, [X|Xs], [X|Ys]) :- call(P, X), !, filter(P, Xs, Ys).
filter(P, [_|Xs], Ys) :- filter(P, Xs, Ys).

foldr(_, E, [], E).
foldr(F, E, [X|Xs], R) :- foldr(F, E, Xs, S), call(F, X, S, R).

all(_, []).
all(P, [X|Xs]) :- call(P, X), all(P, Xs).
#endif
