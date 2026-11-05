In imperativen Programmiersprachen (hier Java) iterieren wir über Listen oft
in folgender Form.
```java
List<Integer> a = new ArrayList<>();
a.add(3); a.add(1); a.add(4); a.add(1); a.add(5);

List<Integer> b = new ArrayList<>();
for (int i = 0; i < a.size(); i++) {
  b.add(2 * a.get(i));
}
```
Wenn wir diesen Code naiv in Haskell übersetzen, könnten wir z.B. folgenden
Code erhalten.
```haskell
double :: [Int] -> Int -> [Int]
double xs i | i < length xs = 2 * xs !! i : double xs (i + 1)
            | otherwise     = []
```
Das wollen wir niemals so tun.
- Was gefällt uns nicht?
- Wie unterscheiden sich die Laufzeiten?
- Optimiere die Funktion `double`, sodass sie lineare Laufzeit in der Länge
  der Liste hat.
Dein Ergebnis sollte Haskell-idiomatisch sein.
