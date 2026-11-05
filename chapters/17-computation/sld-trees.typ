#import "@preview/cetz:0.5.3"

#let qq = math.op("?-")
#let cd = math.op(":-")

Ein SLD-Baum stellt einzelne SLD-Resolutionsschritte graphisch dar. Die Wurzel des
Baumes ist mit der zu beweisenden Anfrage beschriftet. Betrachte beim Lesen parallel
den unten abgebildeten Ausschnitt eines SLD-Baums.

Für einen Knoten, der mit der Anfrage $qq L_1, ..., L_n.$ beschriftet ist, gehen wir
wie folgt vor.

+ *Fertig?* Ist $n = 0$, die Anfrage also $qq .$, dann haben wir einen Beweis gefunden.
  Wir geben die Lösung an (siehe unten) und backtracken, um weitere Lösungen zu finden.
+ *Literal wählen.* Nach der Auswertungsstrategie von Prolog wählen wir das erste
  Literal $L_1$ aus und versuchen, es zu beweisen.
+ *Klausel wählen.* Wir schauen uns die Klauseln der Reihe nach an und benennen die
  Variablen der nächsten Klausel $X cd R_1, ..., R_m.$ ($m >= 0$) frisch um.
+ *Unifizieren.* Ist die linke Seite $X$ mit $L_1$ unifizierbar, es existiert also
  $phi = "Unifikator"(L_1, X)$, dann ...
  - ersetzen wir $L_1$ durch die rechte Seite $R_1, ..., R_m$,
  - wenden $phi$ auf die neue Anfrage an, also $qq phi(R_1, ..., R_m, L_2, ..., L_n).$,
  - zeichnen eine Kante zu diesem neuen Knoten und schreiben die umbenannte Klausel und
    den Unifikator als Hilfestellung an die Kante, und
  - machen bei dem neuen Knoten mit Schritt 1 weiter.
+ *Backtracken.* Passt keine weitere Klausel, dann gehen wir zur zuvor bearbeiteten
  Anfrage zurück und versuchen dort, mit der nächsten noch nicht ausprobierten Klausel
  einen alternativen Beweis zu finden. Im Bild ist das durch die rechteste Kante
  angedeutet.

*Die Lösung.* Sind $A$ die ursprüngliche Anfrage und $phi_1, ..., phi_l$ die
Unifikatoren auf dem Weg von $A$ nach $qq .$, dann berechnen wir die Komposition von der
Lösung bis zur Wurzel und schränken sie auf die Variablen der ursprünglichen Anfrage
ein:
$ sigma = (phi_l compose ... compose phi_1) |_("Vars"(A)). $

*Der Cut.* Ist das aktuelle Literal ein Cut, dann betrachten wir im nächsten Schritt die
Anfrage ohne den Cut. Das Beweisen des Cuts führt dazu, dass sowohl für die Regel, die
den Cut eingeführt hat, als auch für alle Literale, die in dieser Regel links vom Cut
stehen, keine alternativen Resolutionsschritte mehr durchgeführt werden.

#align(center, cetz.canvas({
  import cetz.draw: *

  set-style(mark: (end: ">"))

  content((0, 0), [$qq ...$], padding: 0.5em, name: "query0")
  content((0, -2), [$qq L_1, ..., L_n.$], padding: 0.5em, name: "query1")
  content((-5, -5), [$qq ...$], padding: 0.5em, name: "query2")
  content((0, -5), [$qq phi(R_1, ..., R_m, L_2, ..., L_n).$], padding: 0.5em, name: "query3")
  content((5, -5), [$qq ...$], padding: 0.5em, name: "query4")
  content((0, -7), [$qq ...$], padding: 0.5em, name: "query6")

  line("query0", "query1", stroke: (dash: "dotted"))

  line("query1", "query3", name: "step")
  content("step.mid", padding: 0.5em, anchor: "west", [$X cd R_1, ..., R_m$ \ $phi = "Unifikator"(L_1, X)$])

  bezier("query1.west", "query2.north", (-4.5, -2), stroke: (dash: "dotted"))
  bezier("query1.east", "query4.north", (4.5, -2), stroke: (dash: "dotted"))

  line("query3", "query6", stroke: (dash: "dotted"))
}))
