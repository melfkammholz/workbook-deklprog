Eine Dur-Tonleiter hat folgendes Muster relativ zum vorherigen Ton in
Halbtonschritten:
#align(center)[+2, +2, +1, +2, +2, +2, +1]
Zum Beispiel erhalten wir mit dem Grundton C, so die C-Dur Tonleiter
#align(center)[C - D - E - F - G - A - B - C.]
D ist zwei Halbtöne von C entfernt, E ist zwei Halbtöne von D entfernt,
F ist einen Halbton von E entfernt und so weiter.

Schreibe ein Prädikat `all_major/2`, das alle diatonischen Dur-Akkorde (wie in #xref("chord-terms") definiert) einer Dur-Tonleiter mit gegebenem Grundton berechnet. Diatonisch bedeutet, dass der Akkord nur aus Tönen der
gegebenen Tonleiter bestehen darf. Für die C-Dur Tonleiter sind die gesuchten
Akkorde C-Dur, F-Dur und G-Dur.
