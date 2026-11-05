#import "@preview/diagraph:0.3.6"

Das #link("https://de.wikipedia.org/wiki/F%C3%A4rbung_(Graphentheorie)")[Graphfärbungsproblem]
fragt nach einer Färbung von Knoten, sodass benachbarte Knoten unterschiedlich
gefärbt sind, unter der Verwendung von so wenig Farben wie möglich.

Aufbauend auf #xref("search") wollen wir `dfsM` verwenden, um eine solche
Färbung für einen Graphen zu finden. ```text Search.hs``` ist dieselbe Datei wie dort, deine Suche steht dir also zur Verfügung. Implementiere eine Funktion
`minColor :: [[Int]] -> [Int]`, die eine Färbung eines Graphen
mit so wenig Farben wie möglich bestimmt.

Hier ist ein Beispiel für einen Graphen mit einer 3-Färbung. Aufgrund der
Dreiecke kann dieser keine 2-Färbung haben.
#align(center)[
  #diagram(diagraph.raw-render(
    ```dot
    graph {
      node[shape=circle];

      0 [color="#648fff"];
      1 [color="#dc267f"];
      2 [color="#648fff"];
      3 [color="#ffdc00"];
      4 [color="#ffdc00"];
      5 [color="#648fff"];

      0 -- 1;
      0 -- 3;
      1 -- 2;
      1 -- 3;
      1 -- 4;
      2 -- 4;
      3 -- 5;
      4 -- 5;
    }
    ```,
    engine: "neato"
  ))
]
