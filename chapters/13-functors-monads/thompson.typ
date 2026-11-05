In #xref("regexp-type") und #xref("brzozowski") haben wir reguläre Ausdrücke als algebraische Datentypen in Haskell dargestellt und ein erstes Verfahren kennengelernt, wie das
Wortproblem entschieden werden kann. In dieser Challenge möchten wir die
#link("https://eduresources.informatik.uni-kiel.de/ag-wilke/bul/content/1-berechnungen/b8-regulaere-ausdruecke.html#die-thompson-konstruktion")[Thompson-Konstruktion]
implementieren.

Implementiere eine Funktion `thompson :: RegExp -> EpsNFA`. Die
wesentliche Schwierigkeit in der Implementierung dieses Verfahrens liegt in
der Erzeugung von neuen Zuständen, also solche deren Bezeichner noch nicht
verwendet wurde. Die Ideen aus #xref("todo-list") können hier hilfreich sein.

In der Vorlage zu dieser Challenge ist ein Typ für die endlichen Automaten neben anderen Hilfsfunktionen vorbereitet. Dieses Abenteuer arbeitet ab hier in derselben Datei ```text FA.hs``` weiter. Ebenso ist Code vorbereitet, der
dir helfen kann, die Zustände zu nummerieren.

#remark[
  Die Dokumentation von `Map` findest du
  #link("https://hackage-content.haskell.org/package/containers-0.8/docs/Data-Map-Lazy.html")[hier].
]
