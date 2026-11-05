#ifdef TEMPLATE sat-solver
% Implement bool/1, and/3, or/3, neg/2, get_vars/2, assignment/2, eval/3 and sat/2 here.
#else
bool(true).
bool(false).

and(true, true, true).
and(true, false, false).
and(false, true, false).
and(false, false, false).

or(true, true, true).
or(true, false, true).
or(false, true, true).
or(false, false, false).

neg(true, false).
neg(false, true).

eval(B, _, B) :- bool(B).
eval(var(X), A, B) :- member((X, B), A).
eval(neg(X), A, B) :- eval(X, A, B1), neg(B1, B).
eval(and(X, Y), A, B) :- eval(X, A, B1), eval(Y, A, B2), and(B1, B2, B).
eval(or(X, Y), A, B) :- eval(X, A, B1), eval(Y, A, B2), or(B1, B2, B).

get_vars_dups(B, []) :- bool(B).
get_vars_dups(var(X), [X]).
get_vars_dups(neg(X), Vs) :- get_vars_dups(X, Vs).
get_vars_dups(and(X, Y), Vs) :- get_vars_dups(X, Vs1), get_vars_dups(Y, Vs2), append(Vs1, Vs2, Vs).
get_vars_dups(or(X, Y), Vs) :- get_vars_dups(X, Vs1), get_vars_dups(Y, Vs2), append(Vs1, Vs2, Vs).

get_vars(F, Vs) :- get_vars_dups(F, Ws), list_to_set(Ws, Vs).

assignment([], []).
assignment([V|Vs], [(V, B)|VBs]) :- bool(B), assignment(Vs, VBs).

sat(F, A) :- get_vars(F, Vs), assignment(Vs, A), eval(F, A, true).
#endif

#ifdef TEMPLATE desugar
% Implement desugar/2 here.
#else
desugar(B, B) :- bool(B).
desugar(var(X), var(X)).
desugar(neg(A), neg(B)) :- desugar(A, B).
desugar(and(A, B), and(B1, B2)) :- desugar(A, B1), desugar(B, B2).
desugar(or(A, B), or(B1, B2)) :- desugar(A, B1), desugar(B, B2).
desugar(impl(A, B), or(neg(C1), C2)) :- desugar(A, C1), desugar(B, C2).
desugar(iff(A, B), C) :- desugar(and(impl(A, B), impl(B, A)), C).
#endif
