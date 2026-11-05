In dieser Challenge möchten wir Daten mithilfe der Huffman-Kodierung
komprimieren. Wir bekommen als Eingabe eine Folge von Symbolen und geben
eine kürzere Folge von Bits zurück. Die Kernidee ist es, Symbole nach der
Häufigkeit ihres Vorkommens in der Eingabe zu kodieren. Wenn ein Symbol
besonders häufig vorkommt, sollte es eine möglichst kurze Kodierung bekommen.

Mithilfe von sogenannten Huffman-Bäumen können wir diese Kodierung
konstruieren. Dabei starten wir mit Blättern, die das Symbol und dessen
Häufigkeit in der Eingabe speichern. Darauf nehmen wir uns zwei Blätter (oder
interne Knoten) mit den geringsten Häufigkeiten und verknüpfen diese, indem wir einen internen Knoten einführen, der diese genommenen Knoten als Kindknoten
hat und mit der kumulierten Häufigkeit beschriftet ist. Den konstruierten
Knoten packen wir dann zu der Auswahl von anderen Knoten zurück. Wir
wiederholen das Ziehen der Knoten, bis nur noch ein Knoten übrig
geblieben ist. Durch dieses Verfahren entsteht ein Binärbaum, dessen Blätter
mit geringster Häufigkeit am tiefsten im Baum liegen. Wenn wir nun den
Huffman-Baum zu den Blättern ablaufen und verfolgen, welche Kanten wir dabei
ablaufen, können wir die Folge von Kanten in ein binäres Wort übersetzen.
Zum Beispiel können wir dann das Absteigen in einen linken Teilbaum mit Null
kodieren und das Absteigen in einen rechten mit Eins. Daraus ergibt sich eine optimale präfixfreie Kodierung für die Eingabe. Kommt in der Eingabe nur ein Symbol vor, dann bekommt es die Kodierung `[Zero]`.

- Implementiere eine Funktion `frequencies :: Ord a => [a] -> [(a, Int)]`,
  die die Anzahl der Vorkommen eines Elements in einer gegebenen Liste
  zurückgibt. Die Ausgabe soll als Funktion aufgefasst werden können.
- Implementiere einen Datentypen `data HuffmanTree a`, um Huffman-Bäume
  darzustellen. Definiere weiter eine Ordnung auf diesen basierend auf den
  in den Knoten abgelegten Häufigkeiten.
- Implementiere eine Funktion `huffmanTree :: [(a, Int)] -> HuffmanTree a`,
  die einen Huffman-Baum wie oben beschrieben basierend auf einem Histogramm
  konstruiert.
- Gegeben den Datentypen `data Bit = Zero | One deriving (Eq, Show)`,
  implementiere eine Funktion `code :: HuffmanTree a -> [(a, [Bit])]`,
  die eine Kodierung auf Basis eines Huffman-Baumes berechnet.
- Implementiere Funktionen `encode :: Eq a => [a] -> [(a, [Bit])] -> [Bit]`
  und `decode :: [Bit] -> [(a, [Bit])] -> [a]`, die eine Eingabe enkodieren und dekodieren können.

#remark[
  Eine Kodierung muss injektiv sein, damit wir sie dekodieren können. Die Huffman-Kodierung ist sogar präfixfrei: Kein Codewort ist Anfang eines anderen.
]
