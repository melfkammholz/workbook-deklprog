same_set(As, Bs) :- msort(As, S), msort(Bs, S).

check("C-Dur hat C, F und G", holds((all_major(c, Cs), same_set(Cs, [major(c, e, g), major(f, a, c), major(g, b, d)])))).
check("G-Dur hat G, C und D", holds((all_major(g, Cs), same_set(Cs, [major(g, b, d), major(c, e, g), major(d, fs, a)])))).
check("Fis-Dur beginnt mit fs", holds((all_major(fs, Cs), member(major(fs, as, cs), Cs)))).
