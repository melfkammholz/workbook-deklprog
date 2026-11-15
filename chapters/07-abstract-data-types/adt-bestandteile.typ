Ein ADT besteht aus einer Signatur, also den Namen und Typen seiner
Funktionen, und aus Gesetzen. In dieser Lektion geht es um die Signatur. Wir
schreiben sie in Haskell-Notation: Der ADT bekommt einen Typnamen, hier
`Set a` für Mengen mit Elementen vom Typ `a`, und jede Funktion eine
Typsignatur.

Eine `data`-Deklaration schreiben wir _nicht_. `data Set a = Set [a]` wäre
schon eine Implementierung, und die gehört nicht zum ADT.

= Vier Arten von Funktionen

Die Funktionen eines ADTs teilen wir nach ihren Aufgaben ein.

*Konstruktoren* erzeugen Werte des ADTs. Jeder Wert soll sich mit ihnen bauen
lassen. Für Mengen genügen zwei:

```haskell
empty  :: Set a                -- die leere Menge
insert :: a -> Set a -> Set a  -- ein Element hinzufügen
```

Jede endliche Menge lässt sich so bauen, zum Beispiel die Menge {1, 2, 3} als
```hs insert 1 (insert 2 (insert 3 empty))```. Die Konstruktoren eines ADTs
sind gewöhnliche Funktionen, keine Konstruktoren einer `data`-Deklaration:
Wie `insert` intern arbeitet, bleibt offen.

*Selektoren* liefern Informationen über einen Wert des ADTs, und zwar als Wert
eines anderen Typs:

```haskell
size   :: Set a -> Int        -- Anzahl der Elemente
member :: a -> Set a -> Bool  -- ist das Element enthalten?
```

*Testfunktionen* sind Selektoren, deren Ergebnis ein Wahrheitswert ist. Sie
prüfen eine Eigenschaft eines Werts. `member` gehört also auch dazu, und
außerdem:

```haskell
isEmpty :: Set a -> Bool      -- ist die Menge leer?
```

*Operationen* sind alle übrigen Funktionen. Meist nehmen sie Werte des ADTs
und liefern einen neuen:

```haskell
delete :: a -> Set a -> Set a      -- ein Element entfernen
union  :: Set a -> Set a -> Set a  -- zwei Mengen vereinigen
```

#remark[
  Für den Vergleich von Elementen setzen wir stillschweigend voraus, dass `a`
  Gleichheit kennt. In Haskell schreibt man dafür `Eq a =>` vor den Typ, etwa
  ```hs member :: Eq a => a -> Set a -> Bool```.
]

= Konstruktor oder Operation?

Auch `delete` und `union` liefern Mengen. Trotzdem zählen sie nicht zu den
Konstruktoren: Jede Menge, die `delete` oder `union` liefern kann, lässt sich
auch mit `empty` und `insert` bauen. Die Konstruktoren sind eine Auswahl von
Funktionen, mit denen sich _alle_ Werte bauen lassen. Welche das sind, ist eine
Entscheidung beim Entwurf des ADTs. Meist wählt man möglichst wenige und
einfache.

Darüber machen wir uns allerdings weniger Gedanken. Wir genügen uns damit: zu
den Konstruktoren muss mindestens eine Funktion gehören, mit der wir einen
Wert des Typen erstmal überhaupt erzeugen können. Wenn dann z.B. eine Funktion
wie `insert` unter den Operationen eingeordnet wird. Dann ist das für uns auch
in Ordnung.

#quiz(
  [`delete :: a -> Set a -> Set a` liefert eine Menge. Ist `delete` ein
  Konstruktor?],
  choice[Ja, jede Funktion, die eine Menge liefert, ist ein
    Konstruktor][Dann wäre auch `union` ein Konstruktor. Entscheidend ist, ob man die Funktion braucht,
    um alle Mengen bauen zu können.],
  choice(correct: true)[Nein, sie ist eine Operation][Genau: Jede Menge lässt
    sich schon mit `empty` und `insert` bauen. Mit `delete` kommt keine Menge
    hinzu, die man ohne `delete` nicht bauen könnte.],
  choice[Nein, sie ist ein Selektor][Ein Selektor liefert einen Wert eines
    _anderen_ Typs, etwa eine Zahl oder einen Wahrheitswert. `delete` liefert
    eine Menge.],
)

#quiz(
  [Zu welcher Art gehört `isEmpty :: Set a -> Bool`?],
  choice[Konstruktor][`isEmpty` erzeugt keine Menge, es fragt eine Menge
    etwas.],
  choice[Operation][Eine Operation liefert meist einen neuen Wert des ADTs.
    `isEmpty` liefert einen Wahrheitswert.],
  choice(correct: true)[Testfunktion, also ein Selektor][Genau: `isEmpty`
    liefert einen Wahrheitswert über die Menge. Testfunktionen sind ein
    Sonderfall der Selektoren.],
)

#quiz(
  [Zu welcher Art gehört `size :: Set a -> Int`?],
  choice(correct: true)[Selektor][Genau: `size` liefert eine Information über
    die Menge als Wert eines anderen Typs.],
  choice[Testfunktion][Testfunktionen liefern einen Wahrheitswert. `size`
    liefert eine Zahl.],
  choice[Operation][`size` liefert keine Menge, sondern eine Zahl, und gehört
    damit zu den Selektoren.],
)

= Die Signatur für Mengen

Zusammen ergibt das die Signatur unseres ADTs:

_Konstruktoren_
- `empty :: Set a` erzeugt eine leere Menge.
- `insert :: a -> Set a -> Set a` fügt ein Element in eine Menge ein.

_Selektoren_
- `size :: Set a -> Int` gibt die Anzahl der in einer Menge enthaltenden 
  Elemente zurück.

_Testfunktionen_
- `isEmpty :: Set a -> Bool` prüft, ob eine Menge leer ist.
- `member :: a -> Set a -> Bool` prüft, ob ein Element in einer Menge enthalten
  ist.

_Operationen_
- `delete :: a -> Set a -> Set a` entfernt ein (nicht notwendigerweise 
  enthaltendes) Element in einer Menge.
- `union :: Set a -> Set a -> Set a` vereinigt zwei Mengen.

Die Signatur sagt noch nicht, was die Funktionen tun. Ein `insert`, das sein
Element einfach ignoriert, hätte denselben Typ. Was die Funktionen bedeuten,
legen erst die Gesetze fest, um die es in der nächsten Lektion geht.

Zur Signatur wollen wir auch immer kurz angeben, was die jeweilige Funktion tun
soll. Das ersetzt nicht die Spezifikaton der Semantik mithilfe von Gesetzen!

#practice("adt-constructors")
