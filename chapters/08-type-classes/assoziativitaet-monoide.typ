In der Lektion über `foldl` hat die Summe mit `foldl` und `foldr` dasselbe ergeben, andere Faltungen nicht. Hier klären
wir, wann die Gruppierung keine Rolle spielt. Daraus entstehen Faltungen, die du schon aus dem Prelude kennst: `sum`,
`product`, `concat`, `and`, `or` und weitere.

= Wo die Klammern sitzen

`foldr` klammert nach rechts und setzt den Startwert ans Ende. `foldl` klammert nach links und setzt ihn an den Anfang.
Wähle eine Operation und einen Startwert und vergleiche beide Rechnungen.

#bracketing(ops: (
  (op: "+", list: ("1", "2", "3"), assoc: true, starts: ((value: "0", neutral: true), (value: "10", neutral: false))),
  (op: "*", list: ("2", "3", "4"), assoc: true, starts: ((value: "1", neutral: true), (value: "10", neutral: false))),
  (op: "++", list: ("\"a\"", "\"b\"", "\"c\""), assoc: true, starts: ((value: "\"\"", neutral: true), (value: "\"!\"", neutral: false))),
  (op: "-", list: ("1", "2", "3"), assoc: false, starts: ((value: "0", neutral: false), (value: "10", neutral: false))),
))

Zwei Bedingungen entscheiden, ob die Gruppierung egal ist: Die Operation muss assoziativ sein, und der Startwert muss
neutral sein. Mit `++` und `"!"` siehst du, warum die zweite Bedingung nötig ist.

= Was ein Monoid ist

Ein *Monoid* $(T, ast, e)$ besteht aus einem Typ $T$, einer Operation $ast : T -> T -> T$ und einem Element $e : T$.
Dafür gelten zwei Gesetze: $ast$ ist assoziativ, und $e$ ist links und rechts neutral. In Haskell heißen die Operation
`(<>)` und das Element `mempty`.

```
(a <> b) <> c  =  a <> (b <> c)   -- assoziativ
mempty <> a    =  a               -- mempty ist links neutral
a <> mempty    =  a               -- mempty ist rechts neutral
```

Der Compiler prüft diese Gesetze nicht. Du musst sie selbst sicherstellen.

Für jedes Monoid ist `foldr (<>) mempty` eine natürliche Faltung auf Listen. Die Elemente und das Ergebnis haben
denselben Typ, also ist `fcons x y = x <> y` und `fnil = mempty`. Das Ergebnis ist `x1 <> (x2 <> (… <> (xn <> mempty)))`.
Wegen der Assoziativität darfst du die Klammern weglassen, und weil `mempty` neutral ist, verschwindet es aus dem
Ergebnis. Darum ergeben `foldr` und `foldl` hier dasselbe. Haskell nennt diese Faltung `mconcat`.

#remark[
  Assoziativität erlaubt es außerdem, eine Liste an jeder Stelle zu teilen, die Teile getrennt zusammenzufassen und die
  Ergebnisse mit `<>` zu verbinden. Das nutzen parallele Auswertungen wie MapReduce.
]

= Welche Funktion ist das?

Jedes bekannte Monoid liefert eine solche Faltung, und viele davon gibt es schon im Prelude. Überlege zuerst, welche
Funktion dahintersteckt, und prüfe dann.

#quiz(
  [Was ist `foldr (+) 0`?],
  choice[`product`][Das wäre `foldr (*) 1`.],
  choice[`length`][`length` zählt die Elemente, es addiert sie nicht.],
  choice(correct: true)[`sum`][Genau. `(+)` ist assoziativ und `0` neutral: `foldr (+) 0 [1, 2, 3] = 6`.],
  choice[`maximum`][`maximum` nimmt das größte Element.],
)

#quiz(
  [Was ist `foldr (*) 1`?],
  choice(correct: true)[`product`][Genau. Das neutrale Element der Multiplikation ist `1`. Mit `0` käme immer `0`
    heraus.],
  choice[`sum`][Das wäre `foldr (+) 0`.],
  choice[`and`][`and` arbeitet auf Wahrheitswerten.],
  choice[`length`][`length` zählt die Elemente.],
)

#quiz(
  [Was ist `foldr (++) []`?],
  choice[`reverse`][`reverse` hat den Typ `[a] -> [a]`. Hier kommt aus einer Liste von Listen eine Liste.],
  choice(correct: true)[`concat`][Genau: `concat ["ab", "c"] = "abc"`.],
  choice[`id`][Die Identität hat den Typ `[a] -> [a]`. Hier ist die Eingabe eine Liste von Listen.],
  choice[`unwords`][`unwords` fügt Leerzeichen ein. Das tut `(++)` nicht.],
)

#quiz(
  [Was ist `foldr (&&) True`?],
  choice[`or`][Das wäre `foldr (||) False`.],
  choice[`all`][`all` bekommt zusätzlich ein Prädikat.],
  choice[`any`][`any` bekommt zusätzlich ein Prädikat.],
  choice(correct: true)[`and`][Genau. `True` ist neutral für `(&&)`, darum ist `and []` gleich `True`.],
)

#quiz(
  [Was ist `foldr max minBound`?],
  choice[`minimum`][Das wäre `foldr min maxBound`.],
  choice[`sum`][`sum` addiert, es vergleicht nicht.],
  choice(correct: true)[`maximum`][Genau, mit einem Unterschied: Auf der leeren Liste liefert diese Faltung `minBound`,
    während `maximum []` einen Fehler wirft. Dafür braucht diese Faltung ein neutrales Element.],
  choice[`length`][`length` zählt die Elemente.],
)

#quiz(
  [Was ergibt `foldr (.) id [(+ 1), (* 2)] 5`?],
  choice[`12`][Das wäre erst `(+ 1)` und dann `(* 2)`. Es ist aber `(+ 1) . (* 2)`: Zuerst wirkt `(* 2)`.],
  choice(correct: true)[`11`][Genau: `(+ 1) . (* 2) . id` auf `5` ist `(+ 1) ((* 2) 5) = 11`. Auch Funktionen bilden
    mit `(.)` und `id` ein Monoid.],
  choice[`10`][Das ist nur `(* 2) 5`. Es fehlt `(+ 1)`.],
  choice[`6`][Das ist nur `(+ 1) 5`. Es fehlt `(* 2)`.],
)

Zur Übersicht stehen alle Monoide hier zusammen:

#table(
  columns: 3,
  table.header([Monoid], [Faltung], [Bekannt als]),
  [`(Int, +, 0)`], [`foldr (+) 0`], [`sum`],
  [`(Int, *, 1)`], [`foldr (*) 1`], [`product`],
  [`([a], ++, [])`], [`foldr (++) []`], [`concat`],
  [`(Bool, &&, True)`], [`foldr (&&) True`], [`and`],
  [`(Bool, ||, False)`], [`foldr (||) False`], [`or`],
  [`(Int, max, minBound)`], [`foldr max minBound`], [`maximum` #muted[ohne Fehler bei `[]`]],
  [`(Int, min, maxBound)`], [`foldr min maxBound`], [`minimum` #muted[ohne Fehler bei `[]`]],
  [`(a -> a, (.), id)`], [`foldr (.) id`], [#muted[`Data.Monoid` nennt es `Endo`]],
  [`(T, (<>), mempty)`], [`foldr (<>) mempty`], [`mconcat` #muted[alle Fälle zugleich]],
)

Für Zahlen gibt es mehrere Monoide, zum Beispiel `(+)` und `(*)`. Darum gibt es in `Data.Monoid` die Wrapper `Sum` und
`Product`, mit denen man eines auswählt.

= Weitere Faltungen auf Listen

Nicht jede Faltung kommt von einem Monoid. Wenn das Ergebnis einen anderen Typ hat als die Elemente, braucht man ein
eigenes `fcons`. Viele bekannte Funktionen lassen sich trotzdem so schreiben:

```
length   = foldr (\_ n -> 1 + n) 0
map f    = foldr (\x ys -> f x : ys) []
filter p = foldr (\x ys -> if p x then x : ys else ys) []
xs ++ ys = foldr (:) ys xs
reverse  = foldl (flip (:)) []
```

Beides lässt sich verbinden: `foldMap` bildet jedes Element zuerst in ein Monoid ab und fasst dann zusammen.

```
foldMap :: Monoid m => (a -> m) -> [a] -> m
foldMap f = foldr (\x acc -> f x <> acc) mempty

length xs = getSum (foldMap (const (Sum 1)) xs)
```

= Verständnisfragen

#quiz(
  [Wann ergeben `foldl` und `foldr` dasselbe Ergebnis?],
  choice(correct: true)[Wenn die Operation assoziativ und der Startwert neutral ist][Genau: Das ist der Fall, wenn
    $(T, ast, e)$ ein Monoid ist. Zwingend nötig ist es nicht, aber es reicht.],
  choice[Immer, wenn die Liste Zahlen enthält][Mit `(-)` auf `[1, 2, 3]` ist das nicht so. Probiere es oben aus.],
  choice[Wenn die Operation kommutativ ist][Kommutativ reicht nicht. Es kommt auf die Klammern an, nicht auf die
    Reihenfolge der Argumente.],
)

#quiz(
  [Sei $(T, ast, e)$ ein Monoid. Was ist `foldr (*) e`, mit `(*)` für $ast$?],
  choice(correct: true)[Eine Funktion `[T] -> T`, die alle Elemente mit $ast$ zusammenfasst][Genau. Für `(Int, +, 0)`
    ist das `sum`, für `(Bool, &&, True)` ist es `and`.],
  choice[Die Identität auf `[T]`][Die Identität hat den Typ `[T] -> [T]`. Hier kommt ein einzelnes `T` heraus.],
  choice[Eine Funktion `T -> T`][Die Eingabe ist eine Liste, nicht ein einzelnes Element.],
)

#quiz(
  [Was ergibt `foldr (-) 0 [1, 2, 3]`?],
  choice[`-6`][Das ist `foldl (-) 0 [1, 2, 3]`. Dort sitzen die Klammern links.],
  choice(correct: true)[`2`][Genau: `1 - (2 - (3 - 0)) = 1 - (2 - 3) = 2`. Weil `(-)` nicht assoziativ ist, ist `foldl`
    hier eine andere Funktion.],
  choice[`0`][Rechne von rechts: `1 - (2 - (3 - 0))`.],
)

#quiz(
  [Was ist `foldr max minBound []` für `Int`?],
  choice[Ein Fehler][Dieses Verhalten hat `maximum []`. Hier gibt es einen Startwert.],
  choice(correct: true)[`minBound`][Genau: `minBound` ist neutral für `max` und kommt bei der leeren Liste heraus.],
  choice[`0`][`0` ist nicht das neutrale Element von `max`. Das wäre bei negativen Zahlen falsch.],
)

= Zusammenfassung

- Ist $(T, ast, e)$ ein Monoid, dann fasst `foldr (*) e` (mit `(*)` für $ast$) alle Elemente einer Liste zusammen, und
  `foldl` liefert dasselbe.
- Ohne Assoziativität oder ohne neutrales Element können `foldl` und `foldr` verschiedene Ergebnisse liefern.
- `sum`, `product`, `concat`, `and` und `or` sind genau solche Monoid-Faltungen.

#practice("semigroup-monoid")
