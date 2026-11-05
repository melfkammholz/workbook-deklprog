Zu den am häufigsten gemachten Fehlern beim Angeben eines SLD-Baums gehört die
fehlerhafte Anwendung des Unifikationsalgorithmus. Beim intuitiven Anwenden des
Algorithmus suchen wir oftmals nur die Stellen in den Ausgangstermen, an denen
Variablen auf Terme stoßen, und vergessen, zuvor freie durch bereits gebundene
Variablen zu ersetzen. Als Unifikator für z.B. `f(1, Y)` und `f(X, [X|R])` wird oft
$ sigma = { X |-> 1, Y |-> [X|R] } $
angegeben. Das ist falsch, da
$ sigma(f(1, Y)) = f(1, [X|R]) != f(1, [1|R]) = sigma(f(X, [X|R])). $
Auf der linken Seite könnten wir den Unifikator zwar erneut anwenden, um den
korrekten Term zu erhalten, damit halten wir uns allerdings nicht an die Definition
der Unifizierbarkeit.

Wenn wir den Unifikationsalgorithmus auf die beiden Terme Schritt für Schritt mit
Zwischenergebnissen anwenden, sehen wir in der ersten Iteration, dass der Teilterm
$[X|R]$ nicht mehr in $sigma_1(t_2) = f(1,[1|R])$ vorkommt.
#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    [$k$], [$sigma_k$], [$sigma_k (t_1)$], [$sigma_k (t_2)$], [$"ds"(sigma_k (t_1), sigma_k (t_2))$],
    [$0$], [$emptyset$], [$f(1,Y)$], [$f(X, [X|R])$], [${X,1}$],
    [$1$], [${X |-> 1}$], [$f(1,Y)$], [$f(1, [1|R])$], [${Y,[1|R]}$],
    [$2$], [${X |-> 1, Y |-> [1|R]}$], [$f(1,[1|R])$], [$f(1, [1|R])$], [$emptyset$],
  )
]
Der obige Fehler kommt zustande, da wir beim Berechnen der zweiten
Unstimmigkeitsmenge noch die Ausgangsterme $t_1$ und $t_2$ anstatt der neuen Terme
$sigma_1 (t_1)$ und $sigma_1 (t_2)$ nutzen, in denen $X$ dann substituiert ist.

Wie können wir daran denken? Wenn eine Variable $X$ in der $k$-ten Iteration gebunden
wird, dann kann $X$ weder in $sigma_k (t_1)$ noch in $sigma_k (t_2)$ vorkommen. Für
dieses Beispiel bedeutet das: Wenn wir kurz davor sind, $Y |-> [X|R]$ hinzuschreiben,
sollten wir uns vergewissern, ob bereits gebundene Variablen auf der rechten Seite
vorkommen (hier $X$) und entsprechend ersetzen (hier mit $1$). In einem anderen Fall
können wir Variablen haben, die bereits an Terme gebunden sind, aber noch freie
Vorkommen von Variablen haben -- betrachte z.B. $f(X, 1)$ und $f([Y|R], Y)$ mit
${Y |-> 1} compose {X |-> [Y|R]}$. Hier müssen wir andersherum schauen, ob die neue
Belegung alte Belegungen verändert. Das geht aus der linken Menge der Definition der
Komposition hervor.
$
phi compose psi
  = {v |-> phi(t) | v |-> t in psi, phi(t) != v}
  union {v |-> t | v |-> t in phi, v in.not D(psi) }.
$

Ein Unifikator $sigma$, den der Unifikationsalgorithmus berechnet, erfüllt die
Eigenschaft
$ forall v |-> t in sigma : "Vars"(t) inter D(sigma) = emptyset $
oder alternativ $sigma compose sigma = sigma$. Es dürfen also auf den rechten Seiten
keine Variablen vorkommen, die durch den Unifikator selbst gebunden werden. Solange
diese Eigenschaft nicht erfüllt ist, müssen wir solche Vorkommen durch die Belegungen
ersetzen. In #xref("find-mgus") findest du Beispiele zum Üben.

Hier sind andere Fehler, die seltener geschehen, über die man sich trotzdem Gedanken
machen kann.
- Basierend auf dem obigen Beispiel wird als Zwischenschritt manchmal
  $ { Y |-> [X|R], X |-> 1 } = { Y |-> [1|R], X |-> 1 } $
  aufgeschrieben. Das ist falsch, denn hier besteht keine Gleichheit. Die linke
  Substitution bildet $Y$ auf $[X|R]$ ab, während die rechte $Y$ auf $[1|R]$ abbildet.
  Die Terme $[X|R]$ und $[1|R]$ sind nicht gleich -- selbst wenn in den beiden
  Substitutionen $X$ auf $1$ abgebildet wird.
- In den Unifikatoren müssen alle Belegungen stehen, die benötigt werden, um die linke
  Seite einer Regel mit dem derzeitig selektierten Literal zu unifizieren. Das ist
  unabhängig davon, ob diese Belegungen am Ende zur Berechnung einer Lösung benötigt
  werden. Es geht um die korrekte Anwendung eines Algorithmus und nicht darum, dass du
  logisch schließen kannst, dass manche Belegungen irrelevant sind.

// TODO aus dem alten Dokument:
// Der Fall "${Z |-> Y} compose {Y |-> X} = {Z |-> Y, Y |-> X}$" kann im
// Unifikationsalgorithmus nicht eintreten. Praktisch ergibt sich daraus: Wenn zwei
// Terme unifizierbar sind, dann können wir eine Substitution gemäß des Algorithmus
// auf den Ausgangstermen definieren, und die Komposition mit sich selbst bis zu einem
// Fixpunkt berechnen.
