Ein Parser macht aus einem Text einen Wert: aus `"(a|b)*c"` zum Beispiel einen
regulären Ausdruck. In Haskell lassen sich Parser aus wenigen kleinen Bausteinen
zusammensetzen, und das Ergebnis liest sich fast wie die zugehörige Grammatik.

Dieses Abenteuer startet in #xref("parser-combinators"), wo du einen Parser nur mit
Funktionen höherer Ordnung baust. In #xref("parser-monadic") stellst du fest, dass du
dabei die ganze Zeit eine Monade benutzt hast. Am Ende parst du in
#xref("regexp-parser") reguläre Ausdrücke.
