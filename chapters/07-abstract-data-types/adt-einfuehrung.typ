Angenommen du hast eine Folge von Zahlen und möchtest mithilfe eines Programms
feststellen, ob diese Folge Duplikate enthält. Eine mögliche Lösung ist es,
diese der Reihe nach in eine Menge einzufügen. Bevor wir eine Zahl einfügen,
prüfen wir, ob sie bereits in der Menge enthalten war. Wenn ja, dann haben wir
ein Duplikat gefunden. Wenn der Test niemals anschlägt, dann sind keine 
Duplikate in der Folge enthalten.

Du hast oder du hast nicht bemerkt, dass in den vorherigen Überlegungen kein
einziges Mal Überlegungen darüber stattgefunden haben, wie die genutzte Menge
dargestellt wird. Wir haben lediglich das #emph[abstrakte] Konzept einer Menge
zur Lösung des Problems verwendet. Genau diese Trennung von zwischen formaler
Schnittstelle und konkreter Implementierung wollen wir im Folgenden weiter
ergründen.

= Datentyp und Datenstruktur

Ein *abstrakter Datentyp* (ADT) besteht aus

- einem Namen für einen Typ, zum Beispiel `Set a`,
- den Funktionen, die auf Werten dieses Typs arbeiten, mit ihren Typen, und
- Gesetzen, die festlegen, wie sich diese Funktionen verhalten sollen.

Über die Werte des Typs wissen wir nichts außer dem, was die Funktionen und ihre
Gesetze verraten. Ein ADT ist damit eine Sammlung von Funktionen auf gemeinsamen
Daten: Der Typ `Set a` bekommt erst durch z.B. `insert`, `member` und die
anderen Funktionen eine Bedeutung.

Eine *Datenstruktur* ist dagegen eine konkrete Darstellung im Speicher
zusammen mit Algorithmen, die auf ihr arbeiten: eine Liste, ein AVL-Baum, eine
Hashtabelle. Eine Datenstruktur kann einen ADT _implementieren_. Der ADT selbst
legt aber keine Datenstruktur fest.

#quiz(
  [Welche der folgenden Angaben gehört _nicht_ zu einem ADT für Mengen?],
  choice[`insert :: a -> Set a -> Set a`][Doch: Die Funktionen und ihre Typen
    sind der Kern eines ADTs.],
  choice[`member x (insert x s) == True` für alle `x` und `s`][Doch: Gesetze wie
    dieses legen fest, was `insert` und `member` bedeuten.],
  choice(correct: true)[`data Set a = Set [a]`][Genau: Das ist bereits eine
    Implementierung. Sie legt fest, dass eine Menge als Liste dargestellt wird,
    und genau das soll ein ADT offenlassen.],
)

= Die Implementierung ist eine Black Box

Für einen ADT sind seine Funktionen Black Boxes: Wir kennen ihre Namen, ihre
Typen und die Regeln, die sie befolgen sollen. Was in ihnen passiert, gehört
nicht zum ADT. *Eine Implementierung steht neben dem ADT, nicht in ihm.*

Das bedeutet: Eine Implementierung darf ihre Daten darstellen, wie sie will.
Sie darf Werte mehrfach speichern, sortieren oder unsortiert lassen, einen
AVL-Baum oder eine Hashtabelle verwenden. Solange die Funktionen sich so
verhalten, wie die Gesetze es verlangen, ist sie eine korrekte Implementierung.

Hier ist dieselbe Menge in vier Implementierungen, gebaut mit
```hs insert 3 (insert 1 (insert 3 empty))```. Innen sieht sie jedes Mal
anders aus, von außen nicht:

#tabs(
  label: "Implementierung",
  tab("Liste")[
    Jedes `insert` hängt vorne an, auch wenn das Element schon da ist:
    ```text
    [3, 1, 3]
    ```
    `insert` ist billig, `member` und `size` müssen die ganze Liste
    durchsuchen.

    #table(
      columns: 2,
      [*Aufruf*], [*Ergebnis*],
      [`member 1 s`], [`True`],
      [`member 2 s`], [`False`],
      [`size s`], [`2`],
      [`isEmpty s`], [`False`],
    )
  ],
  tab("Sortierte Liste")[
    Ohne Duplikate und aufsteigend sortiert:
    ```text
    [1, 3]
    ```
    `insert` muss die richtige Stelle suchen, dafür ist `size` nur die Länge.

    #table(
      columns: 2,
      [*Aufruf*], [*Ergebnis*],
      [`member 1 s`], [`True`],
      [`member 2 s`], [`False`],
      [`size s`], [`2`],
      [`isEmpty s`], [`False`],
    )
  ],
  tab("Suchbaum")[
    Ein binärer Suchbaum, links die kleineren Werte:
    ```text
        3
       /
      1
    ```
    In einem balancierten Baum (etwa einem AVL-Baum) brauchen `insert` und
    `member` nur logarithmisch viele Schritte.

    #table(
      columns: 2,
      [*Aufruf*], [*Ergebnis*],
      [`member 1 s`], [`True`],
      [`member 2 s`], [`False`],
      [`size s`], [`2`],
      [`isEmpty s`], [`False`],
    )
  ],
  tab("Hashtabelle")[
    Vier Fächer, jedes Element landet im Fach `x mod 4`:
    ```text
    0: []    1: [1]    2: []    3: [3]
    ```
    `insert` und `member` sind im Mittel in konstanter Zeit fertig.

    #table(
      columns: 2,
      [*Aufruf*], [*Ergebnis*],
      [`member 1 s`], [`True`],
      [`member 2 s`], [`False`],
      [`size s`], [`2`],
      [`isEmpty s`], [`False`],
    )
  ],
)

Du kennst verschiedene Implementierungen von Mengen: Listen, Hashsets,
Suchbäume und Union-Find für Zerlegungen in disjunkte Mengen. Keine davon passt
für alle Zwecke, jede ist in anderen Dingen gut. Mit dem Begriff des ADTs hat
diese Wahl aber nichts zu tun: Der ADT beschreibt, _was_ eine Menge kann. Welche
Implementierung du wählst, entscheidest du später und unabhängig davon.

#quiz(
  [Eine Implementierung speichert jedes Element einer Menge doppelt, um
  Fehler im Speicher zu erkennen. Ist sie eine korrekte Implementierung des
  ADTs?],
  choice[Nein, eine Menge enthält jedes Element nur einmal][Das gilt für die
    Menge, wie man sie von außen sieht, also für das, was `member` und `size`
    liefern. Wie die Implementierung intern speichert, ist ihre Sache.],
  choice(correct: true)[Ja, wenn alle Funktionen die Gesetze erfüllen][Genau:
    Wenn `size` trotzdem die Anzahl der verschiedenen Elemente liefert und
    `member` richtig antwortet, kann niemand den Unterschied bemerken.],
  choice[Das hängt davon ab, ob `insert` effizient ist][Effizienz ist eine
    wichtige Eigenschaft einer Implementierung, aber kein Teil des ADTs.],
)

= Werte ändern sich nicht

Mathematische Objekte sind unveränderlich. `3 + 1` ändert die Zahl `3` nicht,
sondern bezeichnet eine andere Zahl. Genauso ändert `insert 2 s` die Menge `s`
nicht: Das Ergebnis ist eine neue Menge, und `s` ist danach dieselbe wie
vorher.

```haskell
s1 = insert 1 empty
s2 = insert 2 s1
-- member 2 s1 == False, member 2 s2 == True
```

Das ist mehr als eine Eigenheit von Haskell. Weil sich Werte nicht ändern,
liefert eine Funktion für dieselben Argumente immer dasselbe Ergebnis. Erst
dadurch können wir das Verhalten eines ADTs mit Gleichungen beschreiben:
`member 2 s1` hat einen festen Wert, egal wann und wie oft wir es auswerten.
Könnte `s1` sich nachträglich ändern, müssten wir dazusagen, _wann_ eine
Gleichung gelten soll.

= ADTs und Schnittstellen

Aus der objektorientierten Programmierung kennst du Schnittstellen, zum
Beispiel das Interface `Set<E>` in Java. Ein Interface gibt Namen und Typen von
Methoden vor, und jede Klasse, die es implementiert, muss diese Methoden
bereitstellen. Das entspricht dem ersten Teil eines ADTs.

Was die Methoden _tun_ sollen, steht in einem Java-Interface aber nur als
Kommentar in der Dokumentation, und der Compiler prüft es nicht. Ein ADT
schreibt genau diesen Teil als Gesetze auf. Man kann einen ADT also als
Schnittstelle mit einer präzisen Beschreibung ihres Verhaltens lesen.

#practice("adt-what-is")
