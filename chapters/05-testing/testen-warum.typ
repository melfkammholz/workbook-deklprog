Das Entwickeln zuverlässiger Software ist eine nicht-triviale Aufgabe. Oftmals
ist es mit großem Aufwand verbunden, eine weitgehend fehlerfreie Ausführung von 
Programmen zu gewährleisten - ein Problem, das mit der Größe und Komplexität
immer schwieriger wird. 

= Verifikation ist aufwendig

- Viele Programme lassen sich nicht automatisch verifizieren und müssen deshalb
  manuell geprüft werden. 
- Oft wissen wir gar nicht genau, was "korrekt" bedeutet. Eine Spezifikation
  aufzuschreiben ist schwer, und manchmal ist sie unbekannt oder ändert sich.
- Formale Verifikation ist teuer. Sie wird vor allem bei sicherheitskritischer
  Software eingesetzt -- etwa in der Luft- und Raumfahrt, in Kernkraftwerken
  oder in der Medizintechnik.

= Tests als praktischer Ausweg

Unsere Lösung für das zuvor angesprochene Problem ist pragmatisch.
Wir führen ein Programm mit ausgewählten Eingaben aus und vergleichen das 
erwarteten Ergebnis. Je mehr Eingaben wird testen, desto wahrscheinlicher wird
es, dass wir einen Test aufdecken.

Wichtig ist, was ein Test _nicht_ kann:

// TODO properly cite "Concern for Correctness as a Guiding Principle for Program Composition."
// TODO put this as a quote here
#check[
  Tests können Fehler finden, aber nie ihre Abwesenheit beweisen. Edsger
  Dijkstra hat das so gesagt: Testen zeigt die Anwesenheit von Fehlern, niemals
  ihre Abwesenheit.
]

// TODO the spacing between paragraphs and the #check is off-balance.

Aus softwaretechnischer Sicht dienen Tests ebenso der Dokumentation von Software
und sie Unterstützen die Softwareevolution. Letzteres wird erreicht, indem die
Tests erneut durchgeführt, wenn ein Programm verändert wurde. So können uns
vergewissern, ob unsere Änderungen fehlerhaft waren. In diesem Fall werden
Tests auch #emph[Regressionstests] genannt.

= Wie viele Tests sind genug?

Eine Funktion ```hs f :: Int -> Int -> Int``` hat bei 64-Bit-Zahlen 
$2^64 dot 2^64 = 2^128$ mögliche Eingaben.

// TODO i get the spirit of the questions as a fun questions to ask, but the
// explanations to the answers suffer from inaccuracy since no testing speed
// is given. Please fix this
#quiz(
  [
    Angenommen, wir prüfen eine Milliarde Eingaben pro Sekunde. Wie lange dauert 
    es, alle Eingaben von `f` zu prüfen?
  ],
  choice[Ein Sekunde][Selbst mit einer großzügigen Taktfrequenz eines Prozessor müssten wir mehr als $2^105$ Tests pro Takt durchführen. Das ist viel zu wenig Zeit.],
  choice[Etwa ein Jahr][Ein Jahr hat rund $3 dot 10^7$ Sekunden. Das ergäbe nur etwa $3 dot 10^16$ Eingaben.],
  choice(correct: true)[Länger als das Alter des Universums][Genau: $2^128 approx 3 dot 10^38$ Eingaben, geteilt durch $10^9$ pro Sekunde sind etwa $3 dot 10^29$ Sekunden. Das Universum ist erst rund $4 dot 10^17$ Sekunden alt.],
)

Alle Eingaben zu testen, ist also keine Option. Wir könnten uns also stattdessen
die Fragen stellen: #emph[Welche Eigenschaften können wir testen?]. Mit dieser
Fragestellung folgenden wir dem deklarativen Programmierparadigma. Statt 
einzelne handgewählte Beispiele zu testen, spezifizieren wir Eigenschaften,
die eine Funktion erfüllen soll. Wenn wir diese Ideen, um eine automatische
Testdatengenierung ergänzen, erhalten wir #emph[QuickCheck].

#remark[
  In der Softwaretechnik nutzt man unter anderem Techniken wie
  #emph[boundary-value analysis], um Eingaben in Äquivalenzklassen zu finden,
  die #emph[gerade noch] ein Verhalten äquivalantes Verhalten aufweisen.
  Betrachte z.B. $x > 0$ für alle $x in ZZ$. Hier sind die Äquivalenzklassen
  $ZZ_(<= 0)$ und $ZZ_(> 0)$, wenn wir die Funktion nach Ausgaben
  klassifizieren. Besondere Eingaben sind hier $0$ und $1$, da sie jeweils einen
  Randwert der Intervalle darstellen.

  Genau solche Ideen wollen wir an dieser Stelle unterlassen. Wir lassen uns
  darauf, dass das Spezifizieren der Eigenschaften genügt.
]
