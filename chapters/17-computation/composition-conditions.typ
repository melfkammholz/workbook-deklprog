Die Komposition von Substitutionen ist definiert durch
$
phi compose psi
  = {v |-> phi(t) | v |-> t in psi, phi(t) != v}
  union {v |-> t | v |-> t in phi, v in.not D(psi) }.
$
Wieso spielen $phi(t) != v$ und $v in.not D(psi)$ keine Rolle, wenn wir den
Unifikationsalgorithmus akribisch anwenden? Wieso spielt es aber eine Rolle,
wenn wir z.B. ${Y |-> X} compose {X |-> Y}$ oder ${X |-> y} compose {X |-> x}$
betrachten?
