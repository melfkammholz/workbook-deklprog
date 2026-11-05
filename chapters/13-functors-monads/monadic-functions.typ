Das Verwenden von monadischen Funktionen kommt einem zum Anfang möglicherweise
als erbitterter Kampf gegen das Typsystem vor. Diese Situationen ergeben sich
bereits aus den scheinbar unschuldigsten Absichten. Oft fehlt dann die
Erfahrung, um die geeignete Funktion auszuwählen bzw. sogar die Kenntnis
darüber, dass es Funktionen gibt, die einem helfen könnten. Hier betrachten
wir ein paar solcher Szenarien.

- Angenommen du sollst eine Funktion `putStrs :: [String] -> IO ()`
  implementieren, die eine Liste von Strings zeilenweise ausgeben soll, dann
  hast du die Möglichkeit, naiv und zielführend die Funktion per Induktion zu
  definieren. Als Nächstes könntest du die Beobachtung machen, dass du die
  gleiche Funktion für jeden String anwenden sollst, was dich an `map`
  erinnern könnte. Du erhältst den folgenden typinkorrekten Code.
  ```haskell
  putStrs :: [String] -> IO ()
  putStrs ss = map putStrLn ss  -- :: [IO ()]
  ```
  An der Stelle wirfst du entweder den Ansatz über den Haufen oder überlegst
  dir, wie eine Funktion vom Typ `[IO ()] -> IO ()` definiert sein
  könnte, um den obigen Code zu reparieren. Implementiere allgemeiner eine
  Funktion `sequence :: Monad m => [m a] -> m [a]` bzw. eine Funktion
  `sequence_ :: Monad m => [m a] -> m ()`, um die obige
  Implementierung von `putStrs` zu reparieren.
- Implementiere, basierend auf der vorherigen Teilaufgabe, eine Funktion
  `mapM :: Monad m => (a -> m b) -> [a] -> m [b]`. (Ein entsprechendes
  `mapM_` kannst du auch implementieren.)
- Andere hilfreiche Funktionen sind
  - `replicateM :: Monad m => Int -> m a -> m [a]`, die eine monadische
    Aktion eine feste Anzahl von Malen ausführt und dann eine Liste der
    Ergebnisse ausgibt.
  - `zipWithM :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m [c]`,
    die `zipWith` auf Monaden verallgemeinert,
  - `join :: Monad m => m (m a) -> m a`, die eine monadische Struktur
    flacher klopft,
  - und #link("https://hackage-content.haskell.org/package/base/docs/Control-Monad.html")[viele weitere]!
  Implementiere die konkret genannten Funktionen.
- Implementiere eine Funktion `putStrN :: Int -> String -> IO ()`, die einen String beliebig häufig ausgibt.
- Was ist `zipWithM safeDiv [1, 2, 3, 4] [0, 1, 0, 1]`, wobei
  `safeDiv` wie folgt definiert sei.
  ```haskell
  safeDiv :: Integral a => a -> a -> Maybe a
  safeDiv _ 0 = Nothing
  safeDiv p q = Just (p `div` q)
  ```
- Was sind
  - `join [[1, 2, 3], [4, 5], [6]]`,
  - `join (Just Nothing)` und
  - `join (Left (Right True))`?
