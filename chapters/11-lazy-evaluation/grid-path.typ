#import "@preview/cetz:0.5.3"

Bevor du dich dieser Challenge stellst, bietet es sich an, sich #xref("edit-distance") anzunehmen, da in dieser der technische Teil der Lösungsidee vorgestellt
wird.

Gegeben sei ein Gitter $G in ZZ^(m times n)$. Ein Pfad durch das Gitter
startet oben links und endet unten rechts. In jedem Schritt kannst du von
einer Zelle in die rechts- oder darunteranschließende Zelle gehen. Die
Pfadsumme ist die Summe aller Zellenwerte, durch die der Pfad führt.

Hier ist ein Beispiel für ein solches Gitter. Der Pfad der minimalen Pfadsumme
ist durch die Pfeile angedeutet. Für dieses Beispiel ist die minimale Pfadsumme
$6$.
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    grid((0, 0), (4, 3))

    let g = (
      ( 1, 2, 3, 4),
      (-8, 4, 6, 1),
      ( 5, 2, 3, 4),
    )

    for i in range(g.len()) {
      for j in range(g.at(i).len()) {
        content(
          (j, i),
          (j + 1, i + 1),
          box(
            width: 100%,
            height: 100%,
            align(center + horizon, str(g.at(g.len() - i - 1).at(j)))
          )
        )
      }
    }

    set-style(mark: (end: ")>"))
    rect((0.35, 1.8), (0.65, 2.2), fill: white, stroke: none)
    line((0.5, 2.2), (0.5, 1.8))

    rect((0.8, 1.65), (1.2, 1.35), fill: white, stroke: none)
    line((0.8, 1.5), (1.2, 1.5))

    rect((1.35, 0.8), (1.65, 1.2), fill: white, stroke: none)
    line((1.5, 1.2), (1.5, 0.8))

    rect((1.8, 0.65), (2.2, 0.35), fill: white, stroke: none)
    line((1.8, 0.5), (2.2, 0.5))

    rect((2.8, 0.65), (3.2, 0.35), fill: white, stroke: none)
    line((2.8, 0.5), (3.2, 0.5))
  })
]

Implementiere eine Funktion `pathsum :: (Num a, Ord a) => [[a]] -> a`,
die die minimale Pfadsumme berechnet.

#hint[
  Die Rekursionsvorschrift ist gegeben durch
  $
  "pathsum"(i, j) = cases(
    G_(0,0) & quad "falls" (i, j) = (0, 0)\,,
    G_(i,0) + "pathsum"(i-1,0) & quad "falls" j = 0\,,
    G_(0,j) + "pathsum"(0,j-1) & quad "falls" i = 0\,,
    G_(i,j) + min("pathsum"(i-1,j), "pathsum"(i,j-1)) & quad "sonst"
  )
  $
  für $i in {0, ..., m - 1}, j in {0, ..., n - 1}$. Die minimale Pfadsumme
  ist dann $"pathsum"(m - 1, n - 1)$.
]
