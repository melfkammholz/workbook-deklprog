#import "@preview/diagraph:0.3.6"

Finde die allgemeinsten Unifikatoren für die folgenden Terme:
- $(X + 1) dot Y + Z$ und $((3 + Z) + 1) dot Z + 3$,
- $f(X, Y)$ und $f([Y|R], 1)$,
- $f([X|R], X, R)$ und $f([1, 2, 3], _, [Z|S])$, und
- #grid(
    columns: (1fr, auto, 1fr),
    align: center + horizon,
    [
      #diagram(diagraph.raw-render(
        ```dot
        digraph {
          ranksep=0.25;
          nodesep=0.15;
          node [shape=plaintext];
          edge [arrowsize=0.6];
          1 -> 2;
          1 -> 3;
          3 -> 4;
          3 -> 5;
          5 -> 6;
          5 -> 7;
        }
        ```,
        labels: (
          "1": `(:)`,
          "2": `Nothing`,
          "3": `(:)`,
          "4": `Nothing`,
          "5": `Just . (,)`,
          "6": `6`,
          "7": `7`,
        )
      ))
    ],
    [und],
    [
      #diagram(diagraph.raw-render(
        ```dot
        digraph {
          ranksep=0.25;
          nodesep=0.15;
          node [shape=plaintext];
          edge [arrowsize=0.6];
          1 -> 2;
          1 -> 3;
          3 -> 4;
          3 -> 5;
        }
        ```,
        labels: (
          "1": `(:)`,
          "2": $X$,
          "3": `(:)`,
          "4": `Nothing`,
          "5": $Y$
        )
      ))
    ]
  )
