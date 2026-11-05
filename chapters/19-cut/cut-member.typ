Gegeben sei folgendes Prolog-Programm.
```prolog
member(X, [X|_]).
member(X, [_|R]) :- member(X, R).

member_cut(X, [X|_]) :- !.
member_cut(X, [_|R]) :- member_cut(X, R).
```
Wie verändert der Cut-Operator das Verhalten in `member_cut/2`
von `member/2`?
