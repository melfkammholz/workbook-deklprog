Definiere einen abstrakten Datentyp für Listen. Denke dabei an seine
Konstruktoren, Selektoren und Operationen mit ihren zugehörigen Gesetzen.

Folgende Operationen sollen möglich sein:

- Erstellen einer leeren Liste
- Einfügen am Anfang der Liste
- Einfügen an einem beliebigen Index
- Nachschlagen an einem beliebigen Index
- Einfügen am Ende der Liste
- Entfernen am Ende der Liste
- Slicing mit nur einer unteren Grenze, nur einer oberen Grenze und beiden
  Grenzen

Manche Fälle legt die Aufgabe nicht fest, zum Beispiel ob Indizes bei `0`
beginnen, was beim Nachschlagen an einem ungültigen Index passiert oder ob
die obere Grenze beim Slicing dazugehört. Entscheide selbst und schreibe deine
Entscheidung auf.

#hint[Beginne mit den Konstruktoren: Mit welchen möglichst wenigen Funktionen
  kannst du jede Liste bauen? Nicht jede Funktion, die eine Liste liefert, muss
  ein Konstruktor sein.]
#hint[Zwei Konstruktoren genügen: die leere Liste und das Einfügen am Anfang.
  Das Einfügen am Ende ist dann eine Operation. Schreibe als Nächstes für jede
  verlangte Funktion eine Typsignatur auf und ordne sie als Konstruktor,
  Selektor, Testfunktion oder Operation ein.]
#hint[Schreibe für jeden Selektor und jede Operation ein Gesetz pro Konstruktor:
  Was liefert die Funktion für die leere Liste, was für eine Liste, die mit dem
  Einfügen am Anfang gebaut ist?]
#hint[Nachschlagen in einer leeren Liste und Entfernen am Ende einer leeren
  Liste haben kein sinnvolles Ergebnis. Lege fest, wie du damit umgehst:
  Vorbedingung, `Maybe` oder bewusst offen. Beim Slicing kannst du Grenzen
  außerhalb der Liste abschneiden, statt sie zu verbieten.]
#hint[Das Slicing mit beiden Grenzen lässt sich durch die beiden anderen
  ausdrücken.]

#sample[
  Sei `List a` der zu spezifizierende ADT. Indizes beginnen bei `0`.

  _Konstruktoren_
  - `empty :: List a` ist die leere Liste.
  - `cons :: a -> List a -> List a` fügt ein Element am Anfang ein.

  _Selektoren_
  - `size :: List a -> Int` ist die Anzahl der Elemente.
  - `at :: Int -> List a -> a` liefert das Element an einem Index.

  _Testfunktionen_
  - `isEmpty :: List a -> Bool` prüft, ob die Liste leer ist.

  _Operationen_
  - `insertAt :: Int -> a -> List a -> List a` fügt ein Element an einem Index
    ein. Die folgenden Elemente rücken nach hinten.
  - `snoc :: a -> List a -> List a` fügt ein Element am Ende ein.
  - `removeLast :: List a -> List a` entfernt das letzte Element.
  - `from :: Int -> List a -> List a` liefert die Elemente ab Index `i`
    (untere Grenze).
  - `upTo :: Int -> List a -> List a` liefert die Elemente vor Index `j`
    (obere Grenze, nicht eingeschlossen).
  - `slice :: Int -> Int -> List a -> List a` liefert die Elemente mit
    Index `i` bis ausschließlich `j`.

  _Gesetze_

  Für alle Elemente `x`, `y`, alle Listen `l` und alle Zahlen `i`, `j`:

  ```haskell
  isEmpty empty      == True
  isEmpty (cons x l) == False

  size empty      == 0
  size (cons x l) == size l + 1

  at 0 (cons x l) == x
  0 < i && i <= size l ==> at i (cons x l) == at (i - 1) l

  insertAt 0 x l == cons x l
  0 < i && i <= size l + 1 ==> insertAt i x (cons y l) == cons y (insertAt (i - 1) x l)

  snoc x empty      == cons x empty
  snoc x (cons y l) == cons y (snoc x l)

  removeLast (cons x empty)      == empty
  removeLast (cons x (cons y l)) == cons x (removeLast (cons y l))

  i <= 0 ==> from i l == l
  i > 0  ==> from i empty == empty
  i > 0  ==> from i (cons x l) == from (i - 1) l

  upTo j empty == empty
  j <= 0 ==> upTo j (cons x l) == empty
  j > 0  ==> upTo j (cons x l) == cons x (upTo (j - 1) l)

  slice i j l == from i (upTo j l)
  ```

  Die Entscheidungen dahinter:

  - *Ungültige Indizes:* `at` hat nur Gesetze für `0 <= i < size l`, und
    `insertAt` nur für `0 <= i <= size l`. Für andere Indizes und für
    `removeLast empty` gibt es bewusst kein Gesetz. Alternativ könnten `at`
    und `removeLast` ein `Maybe` liefern, dann braucht jeder Fall ein Gesetz,
    etwa ```hs at i empty == Nothing```.
  - *Einfügen am Ende:* `insertAt (size l) x l` ist erlaubt und fügt am Ende
    ein. Es gilt also ```hs insertAt (size l) x l == snoc x l```. Das folgt
    aus den Gesetzen und muss nicht extra aufgeschrieben werden.
  - *Slicing:* Grenzen außerhalb der Liste werden abgeschnitten, wie in Python.
    `from` und `upTo` sind deshalb für alle Zahlen definiert. Negative Indizes,
    die wie in Python vom Ende zählen, gibt es nicht. Wer sie möchte, braucht
    eigene Gesetze dafür. Die obere Grenze gehört nicht dazu. Dadurch gilt
    zum Beispiel ```hs size (upTo j l) == j``` für `0 <= j <= size l`.
  - *Konstruktoren:* Statt `cons` hätten wir `snoc` als Konstruktor wählen
    können. Dann wäre `cons` eine Operation, und die Gesetze würden vom Ende
    her denken.
  - *Gleichheit:* Zwischen `empty` und `cons` gibt es keine Gesetze wie bei
    Mengen. Zwei Listen sind gleich, wenn sie gleich lang sind und an jedem
    Index dasselbe Element haben.
]

#remark[
  Prüfe deine Lösung auf diese Punkte: keine `data`-Deklaration als Teil des
  ADTs, Variablen statt fester Werte (```hs size (cons 1 empty) == 1``` ist ein
  Testfall, kein Gesetz) und keine Gesetze für `at` oder `removeLast` ohne
  Vorbedingung, die für die leere Liste nicht gelten können.
]
