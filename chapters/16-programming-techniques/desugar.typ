In diesem Test ergänzen wir den SAT-Löser aus #xref("sat-solver") um die Implikation
und Äquivalenz. Anstatt das `eval`-Prädikat entsprechend zu
erweitern, wollen wir diese Terme in andere Terme übersetzen, die wir bereits
auswerten können. Das können wir mit folgenden Regeln erreichen:
$ (A => B) quad <=> quad (not A or B) quad quad "und" quad quad (A <=> B) quad <=> quad (A => B and B => A) $
Implementiere dafür ein Prädikat `desugar/2`. Als
Konstruktoren kannst du z.B. `impl/2` und `iff/2`
verwenden.
