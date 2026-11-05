Ein gängiges Sprichwort ist,
#quote(block: true, attribution: [so ein Typ aus der Bibel vor vielen Jahren])["Wer sucht, der findet."]
Hiermit ist der Aufhänger dieses Tests auch schon beendet.

Während deines Studiums hast du verschiedene Suchen kennengelernt: lineare
Suche, binäre Suche, Tiefensuche, Breitensuche, Suche mit Prioritätslisten und
vermutlich weitere. Im Geiste Haskells ist es nur angebracht, dass wir das
Suchproblem abstrakter betrachten. Im Wesentlichen stellen wir uns bei einer
Suche die folgenden Fragen:
- Was suchen wir?
- Wo beginnt die Suche?
- Wenn wir das Gesuchte an einem Ort nicht gefunden haben, wo suchen wir dann
  als Nächstes?
- In welcher Reihenfolge wollen wir die Suchorte besuchen?

Wenig überraschend wird es das Ziel sein, eine Funktion zu implementieren, die
Antworten auf diese Fragen versucht, das Gesuchte zu finden. Betrachte
folgende Funktionssignatur:
#align(center)[
  ```haskell
  searchM :: (Eq a, Monad m)
    => (a -> [a] -> [a])        -- push
    -> ([a] -> Maybe (a, [a]))  -- pop
    -> (a -> m [a])             -- next
    -> (a -> m Bool)            -- found
    -> a                        -- start
    -> m (Maybe [a], [a])       -- path, visited
   ```
]
Wir schauen uns jeden Parameter genauer an.
- `push` soll eine Funktion sein, die uns sagt, wie wir einen Suchort in
  unsere Liste von Suchorten einfügen können.
- Während `pop` als Gegenstück sagt, welcher Suchort als Nächstes besucht
  werden soll, sofern es einen Nächsten gibt, und ebenso wie sich die Liste
  der Suchorte ändert. Wenn es keinen Suchort mehr gibt, dann gehen wir davon
  aus, dass die Liste der Suchorte leer ist -- deshalb ist der Rückgabetyp
  hier z.B. nicht `(Maybe a, [a])`.
- `next` inspiziert den Suchort und bestimmt ausgehend von diesen neue
  Suchorte.
- `found` bestimmt, ob wir an einem Suchort das Gesuchte gefunden haben.
- `start` ist der erste Suchort.
- `path` ist der Pfad der Suchorte, den wir zum Ziel abgelaufen sind, mit
  Berücksichtigung, wie die Suchorte eingeführt wurden.
- `visited` ist die Menge aller tatsächlich betrachteten Suchorte.
Weiter hat sich eine ominöse Monade `m` hineingeschlichen. Diese
erlaubt es uns später, die `searchM` zu erweitern.

- Bevor wir `searchM` implementieren, lösen wir das Teilproblem der
  Pfad-Rekonstruktion. Dafür möchten wir eine Funktion
  `trace :: Eq a => a -> [(a, a)] -> [a]` implementieren, die
  zurückverfolgt, welche Suchorte auf einem direkten Weg vom Ausgangsort zum
  Zielort abgelaufen wurden. `[(a, a)]` fassen wir hier als Abbildung
  von Suchort zum Vorgänger-Suchort auf. Der Ausgangsort ist sein eigener Vorgänger.
- Implementiere nun die Funktion `searchM`.
- Unter Umständen möchten wir die Suche gar nicht, wie oben erwähnt,
  erweitern. Dafür können wir die `Identity`-Monade aus
  `Data.Functor.Identity` verwenden. Der Datentyp selbst ist definiert
  als `newtype Identity a = Identity { runIdentity :: a }`. Wir können
  also einen Wert `x` in `Identity` stecken und ihn mit `runIdentity` wieder herausholen. Wenn wir also eine Funktion
  `f :: a -> b` haben, dann haben wir mit
  `Identity . f :: a -> Identity b` eine Funktion, die vom Muster her
  oben in `next` oder `found` passen würde. Implementiere eine Funktion `search`, die den gleichen Typ wie `searchM` ohne die Monade hat.
- Definiere auf Basis von `search` die Funktion
  `elem :: Eq a => a -> [a] -> Bool`. (Diese muss nicht effizient
  sein. Es geht mehr um das Verständnis von `search`.)
- Implementiere auf Basis von `searchM` eine Tiefensuche `dfsM`
  und eine `bfsM`. Welche Funktionen spielen dafür eine Rolle?
- Gegeben sei der folgende kanten-gewichtete Graph, dargestellt durch Adjazenzlisten. Die Einträge sind Paare aus Gewicht und Zielknoten.
  ```haskell
  g :: [[(Int, Int)]]
  g = [ [(23, 1), (8, 2)]
      , [(1, 2), (5, 3)]
      , [(30, 3)]
      , []
      ]
  ```
  Passe den folgenden Code so an, dass immer mithilfe von `print`
  ausgegeben wird, welcher Knoten gerade besucht wird.
  ```haskell
  shortestPath :: [[(Int, Int)]] -> Int -> Int -> Maybe Int
  shortestPath graph from to =
    let result = search push pop next stop (0, from)
     in case result of
          (Nothing,   _) -> Nothing
          (Just path, _) -> Just (fst (last path))
    where
      push (d, v) pq
        | v `notElem` map snd pq = insert (d, v) pq
        | otherwise = map (\(d', w) -> if v == w then (min d d', v) else (d', w)) pq
      pop = uncons
      next (d, v) = map (\(w, u) -> (d + w, u)) (graph !! v)
      stop (_, v) = v == to
  ```
  (Warum besucht dieses Verfahren Knoten mehrfach?)

#remark[
  Die Funktionen basieren lose auf
  #link("https://github.com/devonhollowood/search-algorithms")[`search-algorithms`].
  Dort kannst du unter anderem sehen, wie mit assoziierten Datentypen einer Typklasse
  die Datenstruktur für das Suchen allgemein gehalten werden.

  Die Suche entspricht auch der Vorlage, die du in Franks Einführung in die
  Algorithmik für Backtracking-Algorithmen kennengelernt hast.
]
