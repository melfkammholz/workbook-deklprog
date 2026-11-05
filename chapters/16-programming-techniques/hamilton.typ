#import "@preview/diagraph:0.3.6"

Oft eignet sich Prolog gut, um Algorithmen für Entscheidungsprobleme, die in
NP liegen, zu implementieren. Als Methode dafür hast du generate-and-test
kennengelernt -- wir generieren mögliche (also korrekte oder falsche)
Lösungen und entscheiden dann, ob sie korrekt sind.

Ein Hamiltonkreis ist ein Kreis in einem Graph, der jeden Knoten genau einmal
enthält. Wir wollen diese als Listen darstellen. Durch Rotation dieser Liste
erhalten wir äquivalente Hamiltonkreise. Diese wollen wir ignorieren und
wählen stattdessen einen kanonischen Repräsentanten, indem wir uns auf die
Liste beschränken, die mit dem kleinsten Knoten beginnt.

Im folgenden Graph gibt es zwei Hamiltonkreise.
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align(center + horizon)[
    #diagram(diagraph.raw-render(
      ```dot
      digraph {
        node[shape=circle];
        1 -> 2 -> 3 -> 5 -> 4 -> 1 [color=red];
        3 -> 4 -> 5;
        5 -> 1;
      }
      ```,
      engine: "circo"
    ))
  ],
  align(center + horizon)[
    #diagram(diagraph.raw-render(
      ```dot
      digraph {
        node[shape=circle];
        1 -> 2 [color=red];
        2 -> 3 [color=red];
        3 -> 5;
        5 -> 4;
        4 -> 1;
        3 -> 4 [color=red];
        4 -> 5 [color=red];
        5 -> 1 [color=red];
      }
      ```,
      engine: "circo"
    ))
  ],
  align(center + horizon, text(0.8em)[
    Hamiltonkreis 1: $(1, 2, 3, 5, 4)$
  ]),
  align(center + horizon, text(0.8em)[
    Hamiltonkreis 2: $(1, 2, 3, 4, 5)$
  ])
)

Um Hamiltonkreise zu bestimmen, arbeiten wir uns von einem naiven
Pfad-Generator zu einem, der versucht nach und nach den Suchraum durch
vorhandene Informationen zu verkleinern (auch pruning genannt). Danach
verifizieren wir, ob ein gegebener Pfad ein Hamiltonkreis ist. Graphen
kannst du z.B. als Liste von Kanten darstellen.
#align(center)[
  ```prolog
  graph([(1, 2), (2, 3), (3, 4), (3, 5), (4, 5), (4, 1), (5, 1), (5, 4)]).
  ```
]

Es lohnt sich, #xref("combinatorics") vor dieser Challenge gemacht zu haben, wenn du
mit den naiveren Pfad-Generatoren starten möchtest.

- Implementiere zuerst einen (polynomiellen) Verifizierer, also ein Prädikat `is_hamilton/2`, das für einen gegebenen Graphen und einen gegebenen Pfad bestimmt, ob der Pfad einem Hamiltonkreis entspricht. Denk auch an die Kante vom letzten zurück zum ersten Knoten.
- Implementiere ein Prädikat `path/2` und verbessere sukzessiv
  mit den folgenden Ideen:
  - Prüfe jede beliebige Knotenfolge bestehend aus $abs(V)$ Knoten. Das heißt,
    der Suchraum entspricht zu Beginn $V^abs(V)$ für einen Graphen $(V, E)$.
  - Jede zwei Knoten dieser Folge müssen paarweise unterschiedlich sein.
  - Jede zwei aufeinanderfolgenden Knoten entsprechen einer Kante in dem
    Eingabegraphen. Die Knotenfolge ist also ein Pfad.
- Implementiere zuletzt das Prädikat `hamilton/2`, das für einen gegebenen Graphen alle Hamiltonkreise berechnet.

Beobachte experimentell, wie sich die Laufzeit durch die einzelnen
Pruning-Schritte verändert.
