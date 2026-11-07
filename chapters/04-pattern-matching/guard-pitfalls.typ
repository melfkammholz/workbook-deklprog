Mit Guards unterscheiden wir Fälle anhand von Bedingungen:

```haskell
abs' :: Int -> Int
abs' n
  | n < 0     = -n
  | otherwise = n
```

Diese Aufgabe sammelt die typischen Stolperfallen. Im Editor findest du
vier Funktionen. Überlege dir bei jeder Frage zuerst eine Antwort und probiere
sie dann im Interpreter aus. Ändere den Code ruhig: GHCs Warnungen erscheinen
direkt im Editor.

+ *Welche Regel wird angewendet?*
  Was ergeben `describe 20`, `describe 5`, `describe 0` und `describe (-3)`?
  Lösche danach die letzte Gleichung `describe _ = "negativ"`. Was passiert
  jetzt bei `describe (-3)`? Lies die Fehlermeldung genau: GHC spricht von
  "patterns", obwohl ein Guard nicht zutraf. Warum?

+ *Wann brauchen wir `otherwise`?*
  - `sign` stürzt für keine Zahl vom Typ `Int` ab. Warum warnt GHC trotzdem?
    Ändere `sign` so, dass die Warnung verschwindet.
  - Ergänze in `describe` als letzten Guard `| otherwise = "klein"`. Was
    passiert mit den Gleichungen darunter, und welche Warnung zeigt GHC?
  - Was ist `otherwise` eigentlich? Frag den Interpreter mit `:t otherwise`.

  Wann brauchen wir also ein `otherwise`, und wann nicht?

+ *Auf die Reihenfolge kommt es an.*
  Für welche Punktzahlen gibt `grade` `"sehr gut"` zurück? Warnt GHC dich?
  Korrigiere `grade`.

+ *`where` und Guards.*
  `safeDiv 7 0` stürzt nicht ab, obwohl `q` durch `y` teilt. Warum nicht?

#hint[
  Zu 1: Eine Gleichung passt erst dann, wenn ihre Muster passen _und_ einer
  ihrer Guards zutrifft. Sonst probiert Haskell die nächste Gleichung.
]
#hint[
  Zu 4: Wann wird `q` ausgerechnet?
]

#remark[
  Für `Double` ist die Warnung bei `sign` mehr als Pedanterie: Für
  `0 / 0` (`NaN`) sind alle drei Vergleiche `False`, und `sign` stürzt ab.
]

#sample[
  1. `"groß"`, `"positiv"`, `"null"` und `"negativ"`. Die Guards der ersten
     Gleichung werden von oben nach unten geprüft. Trifft keiner zu, probiert
     Haskell die nächste Gleichung: `describe 0` landet bei
     `describe 0 = "null"`.

     Ohne die letzte Gleichung passt für `describe (-3)` keine Gleichung mehr,
     und die Auswertung bricht ab mit
     ```text
     Non-exhaustive patterns in function describe
     ```
     Für GHC gehören Muster und Guards einer Gleichung zusammen: Eine Gleichung
     passt nur, wenn beides passt. Die Meldung sagt also nur, dass keine
     Gleichung gepasst hat, nicht dass ein Muster fehlt.
]

#sample[
  2. GHC prüft nicht, was Bedingungen wie `n < 0` bedeuten. Für den Compiler
     sind es beliebige `Bool`-Ausdrücke, und er kann nicht sehen, dass einer
     davon immer zutrifft. Ersetze den letzten Guard durch
     `| otherwise = 1`, dann ist die Warnung weg.

     Mit `| otherwise = "klein"` in `describe` trifft die erste Gleichung immer
     zu. Die Gleichungen darunter werden nie erreicht, GHC warnt mit
     "Pattern match is redundant", und `describe 0` ergibt jetzt `"klein"`.

     `otherwise` ist keine besondere Syntax, sondern ein gewöhnlicher Wert aus
     dem Prelude: `otherwise = True`.

     Wir brauchen `otherwise`, wenn die Guards einer Gleichung alle übrigen
     Fälle abdecken sollen. Es zeigt Leserinnen, Lesern und dem Compiler, dass
     dies der letzte Fall ist. Wir lassen es weg, wenn die übrigen Fälle von
     den folgenden Gleichungen behandelt werden sollen.
]

#sample[
  3. Für keine. Jede Punktzahl ab 90 ist auch mindestens 50, also trifft
     schon der erste Guard zu. GHC warnt nicht, denn er kann die Bedingungen
     nicht vergleichen. Die strengere Bedingung muss zuerst kommen:
     ```haskell
     grade points
       | points >= 90 = "sehr gut"
       | points >= 50 = "bestanden"
       | otherwise    = "nicht bestanden"
     ```
]

#sample[
  4. Die Bindungen im `where` sind in allen Guards sichtbar, werden aber erst
     ausgerechnet, wenn sie gebraucht werden. Bei `y == 0` wird `q` nie
     verwendet, also wird auch nicht durch 0 geteilt.
]
