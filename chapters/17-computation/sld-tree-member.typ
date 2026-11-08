Gegeben sei das Programm `member.pl`. Zeichne den SLD-Baum für die Anfrage
`?- member(X, [1, 2]), Y is X + 1.` Schreibe an jeden Schritt die umbenannte Klausel
und den Unifikator, und an jedes Blatt die Lösung oder den Grund für den Fehlschlag.
Dein Baum wird gegen das Programm geprüft, und du siehst jeden Fehler, der darin steckt.

Die vollständige Notation steht in der
#link("https://github.com/melfkammholz/sldcheck/blob/main/NOTATION.md")[Dokumentation von sldcheck]
(auf Englisch), das deinen Baum prüft.

#hint[Die zweite Klausel von `member` hat die Variablen `X`, `_` und `T`. Benenne sie in jedem Schritt neu, zum Beispiel `X2`, `_2` und `T2`, und achte darauf, dass jeder Name nur einmal vorkommt.]
#hint[`Y is 1 + 1` ist ein eingebautes Prädikat: Der Schritt heißt `builtin`, und der Unifikator ist `{Y |-> 2}`.]
#hint[Der zweite Teil der Anfrage, `Y is X + 1`, wird erst gewählt, wenn `member` bewiesen ist. Bis dahin bleibt er unverändert am Ende jedes Knotens stehen.]
#hint[Auf die leere Liste passt keine Klausel von `member`. Das Blatt endet mit `no rule`.]
