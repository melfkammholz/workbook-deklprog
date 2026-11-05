- Implementiere die #link("https://eduresources.informatik.uni-kiel.de/ag-wilke/bul/content/1-berechnungen/b7-nichtdeterministische-endliche-automaten.html#sec-potenzmengenkonstruktion")[Potenzmengenkonstruktion]. Dafür bietet es sich an, den NEA
  mit einer Tiefensuche zu durchlaufen, anstatt tabellarisch jede Teilmenge
  der Zustandsmenge entsprechend zu verbinden. So werden dann nur Zustände
  durchlaufen, die für den DEA wichtig sind.
  Hier ist eine wesentliche Schwierigkeit, die neuen Zustände zu benennen.
  Es bietet sich an, ein Wörterbuch der Form `[([Int], Int)]` zu
  verwalten, in dem die neuen Bezeichner nachgeschaut werden können.
- Zuletzt, um zu überprüfen, ob der DEA die korrekte Sprache erkennt,
  implementiere eine Funktion `member :: String -> DFA -> Bool`, die
  überprüft, ob ein Wort vom übergebenen Automaten erkannt wird.

#remark[
  Die Idee von `bfsM` aus #xref("search") könnte hier hilfreich sein.
]
