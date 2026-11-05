Gegeben sei folgendes Haskell-Programm.
```haskell
main :: IO ()
main = do
  putStr "Hello"
  return ()
  putStrLn ", world!"
  return ()
```
Was ist die Ausgabe des Programm und warum? Wie steht das im Konflikt mit dem,
was du aus imperativen Programmiersprachen kennst?
