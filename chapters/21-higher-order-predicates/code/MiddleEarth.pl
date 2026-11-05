before(X, Y, Xs) :- append(_, [X|R], Xs), append(_, [Y|_], R).

smaller(X, Y) :- before(X, Y, [frodo, merry, pippin, sam]).
smaller(pippin, merry).

#ifdef TEMPLATE
% Implement insert/4 and isort/3 here.
#else
insert(_, X, [], [X]).
insert(Lt, X, [Y|Ys], [X, Y|Ys]) :- call(Lt, X, Y).
insert(Lt, X, [Y|Ys], [Y|Zs]) :- call(Lt, Y, X), insert(Lt, X, Ys, Zs).

isort(Lt, Xs, Ys) :- isort(Lt, Xs, [], Ys).

isort(_, [], Ys, Ys).
isort(Lt, [X|Xs], Ys, Zs) :- insert(Lt, X, Ys, Us), isort(Lt, Xs, Us, Zs).
#endif
