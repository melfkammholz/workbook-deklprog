Implementiere ein IO-Programm `dan :: IO ()`, das wie folgt abläuft:
- Es werden solange Namen eingegeben, bis eine leere Zeile eingegeben wird.
- Danach beginnt ein unendlicher Dialog zwischen den Personen, deren Namen
  eingegeben wurden. Dabei soll jede Person im Sekunden-Takt nacheinander
  "Nein, ich bin der dreckige Dan!" sagen. Beim ersten Mal soll "Ich bin der
  dreckige Dan!" ausgegeben werden. Die Pausen kannst du mithilfe der Funktion
  #link("https://hackage-content.haskell.org/package/base/docs/Control-Concurrent.html#v:threadDelay")[`threadDelay :: Int -> IO ()`]
  aus dem Modul `Control.Concurrent` umsetzen.

Ein Programmablauf könnte wie folgt aussehen.
```text
ghci> dan
Bob
Patrick

Bob: Ich bin der dreckige Dan!
Patrick: Nein, ich bin der dreckige Dan!
Bob: Nein, ich bin der dreckige Dan!
...
```
