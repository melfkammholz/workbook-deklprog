Gegeben sei der Datentyp
#align(center)[`data Direction = North | East | South | West`.]

- Implementiere eine `Enum`-Instanz für `Direction`, die sich wie die vom GHC abgeleitete Instanz verhält. Probiere dabei `[North ..]` aus. Was passiert, wenn du nur `fromEnum` und `toEnum` angibst, und welche weitere Funktion solltest du deshalb angeben?
- Implementiere eine `Bounded`-Instanz für `Direction`, die sich
  wie die vom GHC abgeleitete Instanz verhält.
- Implementiere die Funktionen `turnLeft :: Direction -> Direction`
  und `turnRight :: Direction -> Direction`, die die Himmelsrichtungen
  entsprechend ihrer Bezeichnung durchgehen.
- Implementiere eine Funktion `allDirections :: [Direction]`, die
  alle Himmelsrichtungen auflistet. Nutze dafür Funktionen, die dir durch
  die vorherigen Typklassen bereitgestellt werden.
