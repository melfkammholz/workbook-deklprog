Wir machen uns auf in die Kombinatorik und wollen ein paar nützliche Prädikate definieren, die uns helfen, Suchräume zu durchlaufen.
- Implementiere ein Prädikat `varia_rep/3`, das genau dann
  beweisbar ist, wenn eine übergebene Liste eine Variation einer anderen
  ist und aus $k$ Elementen besteht -- es soll z.B.
  `?- varia_rep([0, 1], 4, [1, 0, 0, 1]).` beweisbar sein.
- Implementiere ein Prädikat `perms/2`, das genau dann
  beweisbar ist, wenn zwei übergebene Listen Permutationen voneinander sind.
