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

Wichtig ist, was ein Test _nicht_ kann. Edsger Dijkstra hat es 1970 so formuliert#note[Edsger W. Dijkstra. _Concern for Correctness as a Guiding Principle for Program Composition._ EWD 288, Juli 1970.]:

#remark(
  quote(
    block: true,
    attribution: [
      Edsger W. Dijkstra, #link("https://www.cs.utexas.edu/~EWD/transcriptions/EWD02xx/EWD288.html")[Concern for Correctness as a Guiding Principle for Program Composition] (EWD 288, Juli 1970)
    ],
    [
      The first moral of this story is that program testing can be used very
      efficiently to show the presence of bugs, but never to show their absence.
    ]
  )
)

Tests können also Fehler finden, aber nie ihre Abwesenheit beweisen.

Aus softwaretechnischer Sicht dienen Tests ebenso der Dokumentation von Software
und sie Unterstützen die Softwareevolution. Letzteres wird erreicht, indem die
Tests erneut durchgeführt, wenn ein Programm verändert wurde. So können uns
vergewissern, ob unsere Änderungen fehlerhaft waren. In diesem Fall werden
Tests auch #emph[Regressionstests] genannt.

= Wie viele Tests sind genug?

Eine Funktion ```hs f :: Int -> Int -> Int``` hat bei 64-Bit-Zahlen 
$2^64 dot 2^64 = 2^128$ mögliche Eingaben.

#quiz(
  [
    Angenommen, wir prüfen eine Milliarde Eingaben pro Sekunde. Wie lange dauert 
    es, alle Eingaben von `f` zu prüfen?
  ],
  choice[Eine Sekunde][In einer Sekunde schaffen wir $10^9 approx 2^30$ Tests. Wir bräuchten aber $2^128$.],
  choice[Etwa ein Jahr][Ein Jahr hat rund $3 dot 10^7$ Sekunden, das ergibt etwa $3 dot 10^16$ Tests. Wir bräuchten aber $2^128 approx 3 dot 10^38$.],
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
  die #emph[gerade noch] ein ähnliches Verhalten aufweisen.
  Betrachte z.B. $x > 0$ für alle $x in ZZ$. Hier sind die Äquivalenzklassen
  $ZZ_(<= 0)$ und $ZZ_(> 0)$, wenn wir die Funktion nach Ausgaben
  klassifizieren. Besondere Eingaben sind hier $0$ und $1$, da sie jeweils einen
  Randwert der Intervalle darstellen.

  Genau solche Überlegungen wollen wir an dieser Stelle unterlassen. Wir verlassen uns
  darauf, dass das Spezifizieren der Eigenschaften genügt.
]
