#import "@preview/finite:0.5.0"

Wir können endliche Automaten als unendliche Bäume darstellen.
Betrachte z.B. einen endlichen Automaten für die reguläre Sprache $mono(a)^* mono(b)^*$.
#align(center)[
  #diagram(finite.automaton(
    (
      q0: (q0: "a", q1: "b"),
      q1: (q1: "b", q2: "a"),
      q2: (q2: "a, b")
    ),
    initial: "q0",
    final: ("q0", "q1"),
    style: (
      state: (initial: (label: none)),
      q0: (label: $q_0$),
      q1: (label: $q_1$),
      q2: (label: $q_2$)
    ),
  ))
]
Diesen können wir als unendlichen Baum wie folgt darstellen.
#align(center)[
  #diagram(finite.automaton(
    (
      q0: (q1: "a", q2: "b"),

      q1: (q3: "a", q4: "b"),
      q2: (q5: "a", q6: "b"),

      q3: (q7: "a", q8: "b"),
      q4: (q9: "a", q10: "b"),
      q5: (q11: "a", q12: "b"),
      q6: (q13: "a", q14: "b"),

      q7: (),
      q8: (),
      q9: (),
      q10: (),
      q11: (),
      q12: (),
      q13: (),
      q14: ()
    ),
    initial: "q0",
    final: ("q0", "q1", "q2", "q3", "q4", "q6"),
    layout: finite.layout.custom.with(
      positions: (
        q0: (5.5, 6),

        q1: (2.5, 4),
        q2: (8.5, 4),

        q3: (1, 2),
        q4: (4, 2),
        q5: (7, 2),
        q6: (10, 2),

        q7: (0, 0),
        q8: (2, 0),
        q9: (3, 0),
        q10: (5, 0),
        q11: (6, 0),
        q12: (8, 0),
        q13: (9, 0),
        q14: (11, 0),
      )
    ),
    style: (
      transition: (
        curve: 0,
        angle: 0deg
      ),
      state: (
        initial: (label: none),
      ),

      q0: (label: $q_0$),
      q1: (label: $q_0$),
      q2: (label: $q_1$),
      q3: (label: $q_0$),
      q4: (label: $q_1$),
      q5: (label: $q_2$),
      q6: (label: $q_1$),

      q7: (label: none, stroke: none, fill: none),
      q8: (label: none, stroke: none, fill: none),
      q9: (label: none, stroke: none, fill: none),
      q10: (label: none, stroke: none, fill: none),
      q11: (label: none, stroke: none, fill: none),
      q12: (label: none, stroke: none, fill: none),
      q13: (label: none, stroke: none, fill: none),
      q14: (label: none, stroke: none, fill: none),

      q3-q7: (stroke: (dash: "dashed")),
      q3-q8: (stroke: (dash: "dashed")),
      q4-q9: (stroke: (dash: "dashed")),
      q4-q10: (stroke: (dash: "dashed")),
      q5-q11: (stroke: (dash: "dashed")),
      q5-q12: (stroke: (dash: "dashed")),
      q6-q13: (stroke: (dash: "dashed")),
      q6-q14: (stroke: (dash: "dashed"))
    )
  ))
]
- Konstruiere diesen Baum als `asbs :: State Char` mithilfe des Typs
  #align(center)[`data State a = State Bool [(a, State a)]`.] Der
  Boolean gibt an, ob der Zustand akzeptierend ist, und
  `[(a, State a)]` gibt die ausgehenden Transitionen an.
- Implementiere eine Funktion `accept :: Eq a => [a] -> State a -> Bool`,
  die bestimmt, ob eine Eingabe akzeptiert wird.
- Implementiere eine Funktion `language :: State a -> [[a]]`, die die
  akzeptierte Sprache des Automaten zurückgibt. (Du kannst davon ausgehen,
  dass die Sprache nicht leer ist -- wenn du das Entscheidungsproblem trotzdem
  lösen möchtest, halten wir dich nicht auf.)
- Warum funktioniert die folgende Implementierung der Funktion
  `language` nicht?
  ```haskell
  language :: State a -> [[a]]
  language (State False ts) = [c:ws | (c, q) <- ts, ws <- language q]
  language (State True  ts) = [] : [c:ws | (c, q) <- ts, ws <- language q]
  ```
