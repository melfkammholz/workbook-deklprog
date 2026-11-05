Wenn wir Haskell um die Möglichkeit erweitern könnten, mehrere Regeln
auszuprobieren und mehrere Lösungen zu kombinieren, hätten wir trotz der
Abwesenheit logischer Variablen bereits viele Möglichkeiten der Modellierung,
wie wir sie in Prolog haben. Es stellt sich heraus, dass die Listenmonade
den Nichtdeterminismus schon sehr gut abbilden kann, und erlaubt damit einen
weiteren abstrakten Blick auf die Listenmonade - anstatt z.B. der Blick der
imperativen Programmierung als Verschachtelung von Schleifen.

Als kleines Beispiel betrachten wir einen fairen Münzenwurf. Wir kodieren
die Ereignisse binär, wobei 0 für Kopf und 1 für Zahl stehen soll. Weiter ist
auch ein Beispiel angegeben für zwei unabhängige Münzenwürfe.
#grid(
  columns: (1fr, 1fr),
  [
    In Prolog:
    ```prolog
    coin(0).
    coin(1).

    coin2(X, Y) :-
      coin(X),
      coin(Y).
    ```
  ],
  [
    In Haskell: ```haskell
    coin :: [Int]
    coin = [0] ++ [1]

    coin2 :: [(Int, Int)]
    coin2 = do
      x <- coin
      y <- coin
      return (x, y)
    ```
  ]
)

Bewaffnet mit diesen Ideen, modelliere einen fairen 6-seitigen Würfel.
Berechne alle Möglichkeiten, wie man drei Würfel werfen kann, um die
Augenzahl 11 zu erhalten. Gib deine Lösung sowohl in Prolog als auch in
Haskell an. Um zu prüfen, ob die Summe von drei Zahlen einer anderen Zahl
entspricht, kannst du `sum3(X, Y, Z, S) :- S is X + Y + Z.`
nutzen.

#sample[
  ```haskell
  dice :: [Int]
  dice = [1..6]

  eleven :: [(Int, Int, Int)]
  eleven = do
    x <- dice
    y <- dice
    z <- dice
    if x + y + z == 11
      then return (x, y, z)
      else []
  ```
  ```prolog
  dice(X) :- member(X, [1, 2, 3, 4, 5, 6]).

  eleven(X, Y, Z) :- dice(X), dice(Y), dice(Z), sum3(X, Y, Z, 11).
  ```
]
