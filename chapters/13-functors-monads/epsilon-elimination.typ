- Implementiere eine Funktion `epsilonClosure :: EpsNFA -> Int -> Set Int`, die die $epsilon$-Hülle eines Zustands berechnet.
- Implementiere eine Funktion `epsilonElim :: EpsNFA -> NFA`, die
  alle $epsilon$-Transitionen des übergebenen nichtdeterministischen endlichen
  Automaten entfernt. Hier brauchst du dir keine Gedanken über neue Bezeichner
  für Zustände machen, da du die Zustände des alten Automaten wiederverwenden
  kannst.

#remark[
  - #link("https://eduresources.informatik.uni-kiel.de/ag-wilke/bul/content/1-berechnungen/b7-nichtdeterministische-endliche-automaten.html#def-b6-epsilon-huelle")[$epsilon$-Hülle -- Berechnungen und Logik]
  - #link("https://eduresources.informatik.uni-kiel.de/ag-wilke/bul/content/1-berechnungen/b7-nichtdeterministische-endliche-automaten.html#eliminierung-von-varepsilon-transitionen")[Eliminierung von $epsilon$-Transitionen -- Berechnungen und Logik]
  - Die Idee von `bfsM` aus #xref("search") könnte hier hilfreich sein.
]
