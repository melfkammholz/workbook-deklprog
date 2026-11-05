#import "@preview/cetz:0.5.3"

Im Folgenden modellieren wir einen Graph als Paar $(V, E)$ mit
einer Knoten- und Kantenbewertung $w_v : V -> A$ und $w_e : E -> B$,
und $E subset.eq V times V$.

Gegeben sei der Datentyp
#align(center)[`data Graph a b = Graph [(Int, a)] [(Int, b, Int)]`.]
Hier entspricht der erste Parameter des Datenkonstruktors $w_v$ und der
zweite $w_e$.

- Implementiere eine Funktion `succs :: Int -> Graph a b -> [Int]`,
  die zu einem gegebenen Knoten die direkten Nachfolger berechnet.
- Implementiere eine Funktion
  `reachable :: Int -> Int -> Graph a b -> Bool`, die entscheidet, ob
  zwischen zwei Knoten ein gerichteter Pfad existiert. Starte zuerst mit
  einfachen Graphen und betrachte immer komplexer werdende Graphen. Wie musst
  du (oder kannst du) deine Implementierung anpassen?
  - Nimm zuerst an, dass ein gegebener Graph immer ein Baum ist. Wenn also
    ein Pfad existiert, dann ist er eindeutig.
  - Nimm jetzt an, dass ein gegebener Graph immer azyklisch ist. Das heißt,
    falls ein Pfad existiert, muss dieser nicht mehr eindeutig sein.
    Nutze deine Erkenntnisse aus #xref("sequence-state"), um eine Liste aller
    besuchten Knoten zu verwalten.
  - Was musst du in deiner Implementierung anpassen, wenn der gegebene Graph
    auch zyklisch sein kann?
- Je nachdem wie du `reachable` implementiert hast, könnte es den Anschein erwecken, dass deine Lösung alle Knoten besucht. Wieso ist das
  nicht unbedingt der Fall? Wieso passiert das nur, wenn wir uns die Liste
  aller besuchten Knoten anschauen?
  Welche Beobachtungen machst du, wenn du `reachable 0 k (yGraph k)`
  berechnest?
  ```haskell
  yGraph :: Int -> Graph () ()
  yGraph k = Graph [(v, ()) | v <- [0..2 * k]]
                   (let left = [(v, (), v + 1) | v <- [1..k - 1]]
                        right = [(v, (), v + 1) | v <- [k + 1..2 * k - 1]]
                     in (0, (), 1) : (0, (), k + 1) : (left ++ right))
  ```
  Hier ist der Graph visualisiert.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      circle((0, 0), radius: 0.6, name: "v0")
      content((0, 0), [$v_0$])

      circle((2, 1), radius: 0.6, name: "v1")
      content((2, 1), [$v_1$])

      set-style(mark: (end: ")>"))
      line("v0", "v1")

      circle((4, 1), radius: 0.6, name: "v2")
      content((4, 1), [$v_2$])

      line("v1", "v2")

      circle((6, 1), radius: 0.6, stroke: none, name: "vh1")

      set-style(mark: (end: none))
      line("v2", "vh1")

      line((5.8, 1), (6.2, 1), stroke: (dash: "dotted"))

      circle((8, 1), radius: 0.6, name: "vk-1")
      content((8, 1), [$v_(k-1)$])

      set-style(mark: (end: ")>"))
      line("vh1", "vk-1")

      circle((10, 1), radius: 0.6, name: "vk")
      content((10, 1), [$v_k$])

      line("vk-1", "vk")

      circle((2, -1), radius: 0.6, name: "vk+1")
      content((2, -1), [$v_(k+1)$])

      line("v0", "vk+1")

      circle((4, -1), radius: 0.6, name: "vk+2")
      content((4, -1), [$v_(k+2)$])

      line("vk+1", "vk+2")

      circle((6, -1), radius: 0.6, stroke: none, name: "vh2")

      set-style(mark: (end: none))
      line("vk+2", "vh2")

      line((5.8, -1), (6.2, -1), stroke: (dash: "dotted"))

      circle((8, -1), radius: 0.6, name: "v2k-1")
      content((8, -1), [$v_(2k-1)$])

      set-style(mark: (end: ")>"))
      line("vh2", "v2k-1")

      circle((10, -1), radius: 0.6, name: "v2k")
      content((10, -1), [$v_(2k)$])

      line("v2k-1", "v2k")
    })
  ]

#remark[
  Falls du es nicht geschafft hast, in #xref("sequence-state") `sequence`
  zu implementieren, kannst du diese Implementierung verwenden.

  ```haskell
  sequence :: [s -> (a, s)] -> s -> ([a], s)
  sequence []     s = ([], s)
  sequence (f:fs) s = let (y, s')   = f s
                          (ys, s'') = sequence fs s'
                       in (y:ys, s'')
  ```
]
