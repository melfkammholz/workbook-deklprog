#import "@preview/diagraph:0.3.6"

// Die Aufgabe erweitert den Prolog-Interpreter aus dem Projekt, also Haskell.
#set raw(lang: "haskell")

Psst! Ja, du! Möchtest du ein Werkzeug zum Generieren von SLD-Bäumen?

Für diese Challenge brauchst du den Code des Prolog-Interpreters aus dem Projekt des Moduls.

Erweitere den Prolog-Interpreter um eine Funktion
`graphviz :: SLDTree -> String`, die einen SLD-Baum nimmt und ihn z.B.
mithilfe von #link("https://graphviz.org/")[Graphviz] visualisiert.

Das Erzeugen des folgenden DOT-Codes ist vergleichsweise unkompliziert aus
dem Projekt-Code heraus möglich. Wenn du dir mehr anzeigen lassen möchtest,
musst du ein paar Stellen anpassen. Der `SLDTree` speichert nicht,
welche Regel verwendet wurde, bzw. die umbenannte Regel, die für die
Unifikation verwendet wurde. Dafür müsste der Typ entsprechend angepasst
werden. Je mehr du dir anzeigen lassen möchtest, desto zeitaufwendiger oder
schwieriger wird diese Challenge. Eine prototypische Implementierung, die das
untere Beispiel umsetzt, ist zügig möglich.

Folgender DOT-Code erzeugt den folgenden SLD-Baum. Graphviz unterstützt von
Haus aus nicht das Setzen von mathematischen Formeln. Entweder du verzichtest
darauf oder du schaust dir z.B. #link("https://dot2tex.readthedocs.io/en/latest/")[dot2tex]
oder #link("https://github.com/Robotechnic/diagraph")[diagraph] an, je nach
dem ob du #link("https://www.latex-project.org/")[LaTeX] oder
#link("https://typst.app/")[Typst] nutzt bzw. nutzen möchtest. Wenn du keinen
DOT-Compiler hast, kannst du zum Debuggen deines generierten DOT-Codes
#link("https://dreampuf.github.io/GraphvizOnline/")[diese Seite] nutzen.

#grid(
  columns: (1fr, 1fr),
  [
    #linebreak()
    ```dot
    digraph {
      node [shape=none];
      1 [label="?- =(X, 1)."];
      2 [label="?- ."];

      1 -> 2 [label="{X1 |-> 1, X |-> 1}"];
    }
    ```
  ],
  [
    #align(center)[
      #diagram(diagraph.raw-render(
        ```dot
          digraph {
            node [shape=none];
            1 -> 2 [label="{X_1 |-> 1, X |-> 1}"]
          }
        ```,
        labels: (
          "1": [$op("?-") =(X, 1).$],
          "2": [$op("?-") .$]
        )
      ))
    ]
  ],
)
