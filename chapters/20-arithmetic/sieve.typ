Das Sieb des Eratosthenes ist ein Algorithmus zur Bestimmung von Primzahlen.
Dieses wollen wir nun in Prolog implementieren -- mit Peano-Zahlen natürlich.
- Implementiere zuerst ein Prädikat `range/3`, das eine Liste
  berechnet, die alle Ganzzahlen in einem vorgegebenen Intervall enthält.
  Die obere Grenze gehört nicht dazu. Zum Beispiel soll `?- range(s(o), s(s(s(o))), [s(o), s(s(o))]).`
  beweisbar sein.
- Als Nächstes implementiere ein Prädikat `filter_by_prime/3`, das alle Elemente einer Liste entfernt, die durch eine gegebene Primzahl teilbar sind. Die Primzahl ist das erste Argument.
- Zuletzt benötigen wir noch `primes/2`, das alle Primzahlen bis zu einer angegebenen Zahl berechnen soll. Implementiere dieses mithilfe
  der bereits vorbereiteten Prädikate.
- Mit #xref("to-nat") und einem weiteren Prädikat `map_to_nat/2` kannst
  du die Liste der Primzahlen in eine lesbare Form bringen -- du kannst auch
  ein allgemeines `map/3` mithilfe des Prädikats höherer
  Ordnung `call` implementieren.
