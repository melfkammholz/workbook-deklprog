#import "@preview/diagraph:0.3.6"

Ein Graph sei dargestellt als eine Liste von Kanten. Die Kanten seien
wiederum als Tupel dargestellt.

Implementiere ein Prädikat `reachable/3`, das bestimmt,
ob ein Knoten von einem anderen Knoten aus erreichbar ist. Du benötigst
voraussichtlich ein weiteres vierstelliges Hilfsprädikat.

Dein Programm soll sich wie folgt verhalten:
```prolog
?- reachable(1, 3, [(1, 2), (2, 3), (3, 1)]).
true ;
false.

?- reachable(1, 3, [(1, 2), (3, 2)]).
false.
```

Hier sind die Eingabe-Graphen nochmal visualisiert.
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align(center + horizon)[
    #diagram(diagraph.raw-render(
      ```dot
      digraph {
        node[shape=circle];

        1 -> 2;
        2 -> 3;
        3 -> 1;
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

        1 -> 2;
        3 -> 2;
      }
      ```
    ))
  ],
  text(0.8em)[
    Eingabe-Graph der ersten Anfrage mit unendlich vielen gerichteten Pfaden
    von 1 bis 3
  ],
  text(0.8em)[
    Eingabe-Graph der zweiten Anfrage mit keinem gerichteten Pfad von 1
    nach 3
  ]
)
