In der vorletzten Serie haben wir eine abstrakte Repräsentation von JSON-Dokumenten in Haskell definiert.

```haskell
data JSON = JNull
          | JBool Bool
          | JInt Int
          | JFloat Float
          | JString String
          | JArray [JSON]
          | JObject [(String, JSON)]
  deriving (Show, Eq)
```

Definiere eine Typklasse `ToJSON` mit einer Funktion `toJSON`, die einen Wert eines beliebigen Typs nach JSON konvertiert.

Gib dann `ToJSON`-Instanzen an für:

- boolesche Werte vom Typ `Bool`,
- polymorphe Listen vom Typ `[a]`,
- polymorphe Tupel vom Typ `(a, b)`,
- knotenbeschriftete Bäume vom Typ `Tree a`, definiert durch

```haskell
data Tree a = Empty | Node (Tree a) a (Tree a)
```

Die Abbildung von `(a, b)` und `Tree a` nach JSON ist nicht eindeutig: Es gibt mehrere sinnvolle Möglichkeiten. Wähle
eine, aus der sich der Wert wieder zurückgewinnen lässt. Die Tests prüfen genau diesen Vorschlag:

- `(x, y)` wird zu einem Objekt mit den Schlüsseln `"fst"` und `"snd"`.
- `Empty` wird zu einem Objekt mit dem einzigen Schlüssel `"tag"` und dem Wert `JString "Empty"`.
- `Node l x r` wird zu einem Objekt mit den Schlüsseln `"tag"` (`JString "Node"`), `"left"`, `"value"` und `"right"`, in dieser Reihenfolge.

#hint[Welche Voraussetzung braucht die Instanz für `[a]`? Was rufst du für die Elemente auf?]
#hint[Für `(a, b)` brauchst du zwei Voraussetzungen, für `Tree a` eine. Die Instanz für `Tree a` ruft sich für die Teilbäume selbst auf.]
