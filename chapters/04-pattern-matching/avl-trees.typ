In den Übungsaufgaben hast du einen Suchbaum ohne Höhenbalancierung
implementiert. Die Rotationen für einen AVL-Baum lassen sich durch das
pattern matching in Haskell vergleichsweise elegant implementieren - erinnere
dich z.B. an die Implementierung aus Einführung in die Algorithmik, die recht
verbos ist.

Die Höhe eines Teilbaums kann z.B. als weiteres Attribut im Knoten gespeichert
werden. Eine ineffizientere Variante ist es, die Höhe mit einer Funktion
wiederkehrend zu berechnen. Letztere Variante ist für den Anfang
übersichtlicher.

Die Vorlage nutzt die einfachere Variante ohne gespeicherte Höhe.

Implementiere eine Funktion `rotate :: SearchTree a -> SearchTree a`,
die einen Teilbaum an der Wurzel rebalanciert, sollte der Teilbaum
unbalanciert sein. Diese Funktion kannst du dann nutzen, um die gängigen
Operationen `insert` und `delete` auf Suchbäumen anzupassen.

#remark[
  #link("https://de.wikipedia.org/wiki/AVL-Baum#Rebalancierung")[Rebalancierung eines AVL-Baums].
]
