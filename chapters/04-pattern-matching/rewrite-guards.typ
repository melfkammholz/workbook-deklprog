Guards, `if-then-else` und `case` können dieselben Fallunterscheidungen
ausdrücken. In dieser Aufgabe schreibst du Funktionen von einer Form in die
andere um. Die Tests prüfen, ob deine Variante dasselbe berechnet wie das
Original.

+ `clamp` ist mit verschachtelten `if-then-else`-Ausdrücken geschrieben.
  Schreibe `clampGuards`, das dasselbe mit Guards berechnet.
+ `temperature` ist mit Guards geschrieben. Schreibe
  - `temperatureIf` mit `if-then-else`,
  - `temperatureCase` mit `case`.
+ Welche der drei Formen liest sich für dich bei `temperature` am besten?
  Warum?

#hint[
  Auch die Alternativen eines `case`-Ausdrucks können Guards haben:
  ```haskell
  case xs of
    (x : _) | x > 0 -> "beginnt positiv"
    _               -> "sonst"
  ```
]

#remark[
  Wie bei Gleichungen gilt auch in `case`: Trifft kein Guard einer Alternative
  zu, geht es mit der nächsten Alternative weiter.
]

#sample[
  ```haskell
  temperatureCase t = case t of
    _ | t < 0     -> "eisig"
      | t < 10    -> "kalt"
      | t < 25    -> "angenehm"
      | otherwise -> "heiß"
  ```
  Bei vielen Fällen lesen sich Guards meist am besten: Jede Bedingung steht
  in einer eigenen Zeile mit ihrem Ergebnis daneben. Verschachtelte
  `if-then-else` rücken mit jedem Fall weiter ein, und der `case`-Ausdruck
  unterscheidet hier gar keine Muster, sondern nur Bedingungen.
]
