Gegeben sei folgendes Prolog-Programm.
```prolog
upTo(o, _, []).
upTo(s(N), A, [A|Xs]) :- upTo(N, A, Xs).
upTo(s(N), A, []).
```
Betrachte die Anfrage `?- upTo(s(s(o)), a, Xs), Xs = [X, Y].`.
Die erste Lösung ergibt sich aus der Komposition der folgenden Unifikatoren
und dessen anschließenden Einschränkung auf die freien Variablen der Anfrage.
Für die erste Lösung $sigma_1$ der obigen Anfrage lauten die Unifikatoren z.B.
- $phi_1 = {N_1 |-> s(o), A_1 |-> a, italic("Xs") |-> [a|italic("Xs")_1]}$,
- $phi_2 = {N_2 |-> o, A_2 |-> a, italic("Xs")_1 |-> [a|italic("Xs")_2]}$,
- $phi_3 = {italic("Xs")_2 |-> []}$ und
- $phi_4 = {X |-> a, Y |-> a, X_4 |-> [a, a]}$.
$phi_4 compose phi_3 compose phi_2 compose phi_1$ rigoros
auszurechnen, ist mühselig und zeitaufwendig. In diesem Test versuchen wir,
einen schnelleren Weg zur Berechnung einer Lösung zu ergründen, wenn wir
die Unifikatoren bereits haben.

- Sei $G = (V, E)$ ein gerichteter Graph mit
  $ V = union.big_(k=1)^4 D(phi_k) "und" E = {(V, W) | k in {1,...,4}, V |-> T in phi_k, W in "Vars"(T) }. $
  Stelle diesen Graph dar.
- Wieso ist $G$ azyklisch?
- Betrachte die Knoten $X$, $Y$ und $italic("Xs")$. Wie hängen ihre Nachfolger
  mit ihnen zusammen?
- Wie erhalten wir $italic("Xs") |-> [a, a]$ aus dem Teilgraphen von $G$, der
  $italic("Xs")$ enthält und alle von diesem Knoten aus erreichbaren Knoten?
- Wie ergibt sich aus der vorherigen Betrachtung ein schnelleres
  Berechnungsverfahren?
- Betrachte $G$ ohne die von $X$, $Y$ und $italic("Xs")$ und die von diesen
  erreichbaren Knoten. Welche Bedeutung haben diese bei der Berechnung der
  Lösung
  $sigma_1 = (phi_4 compose phi_3 compose phi_2 compose phi_1)|_{{X,Y,italic("Xs")}}$?
- Wieso funktioniert dieses Verfahren für Kompositionen, die sich nicht
  aus dem Unifikationsalgorithmus oder der SLD-Resolution ergeben, nicht?
  Betrachte ${"Y" -> "X"} compose {"X" -> "Z"}$.
