#import "@preview/cetz:0.5.3"

Begleitend zum Modul _Berechnungen und Logik_ kannst du in diesem Abenteuer die
dort gelernten und neue Konzepte in Haskell programmieren. In den Tests und
Challenges wird auf alles Notwendige verwiesen oder erneut eingeführt, und es
ist zu den Ressourcen aus dem Modul verlinkt. Wir schauen uns das Wortproblem
für reguläre Ausdrücke und DEAs genauer an.

Dieses Abenteuer startet in #xref("regexp-type"). Nach der Brzozowski-Ableitung
implementieren wir die folgenden Konstruktionen.

#align(center, cetz.canvas({
  import cetz.draw: *

  // All four stops sit on one circle, in clockwise order. `gap` is how many
  // degrees the arcs stay away from a stop, so wider text gets a wider gap.
  let radius = 2.2
  let on-circle(angle, r: radius) = (r * calc.cos(angle * 1deg), r * calc.sin(angle * 1deg))
  let stops = (
    (angle: 90, gap: 34, label: [Reguläre Ausdrücke]),
    (angle: 0, gap: 14, label: [$epsilon$-NEA]),
    (angle: -90, gap: 14, label: [NEA]),
    (angle: -180, gap: 14, label: [DEA]),
  )
  let edges = (
    [Thompson-Konstruktion],
    [Elimination von $epsilon$-Transitionen],
    [Potenzmengenkonstruktion],
    [Zustandseliminierung],
  )

  for stop in stops {
    content(on-circle(stop.angle), stop.label)
  }

  for (i, label) in edges.enumerate() {
    let from = stops.at(i)
    let to = stops.at(calc.rem(i + 1, 4))
    // The last edge goes from -180 degrees on to -270, which is the top again.
    let to-angle = if i == 3 { to.angle - 360 } else { to.angle }
    let start = from.angle - from.gap
    let end = to-angle + to.gap
    let mid = (start + end) / 2

    arc-through(on-circle(start), on-circle(mid), on-circle(end), mark: (end: ">"))
    content(
      on-circle(mid, r: radius + 0.2),
      anchor: if calc.cos(mid * 1deg) > 0 { "mid-west" } else { "mid-east" },
      label,
    )
  }
}))
