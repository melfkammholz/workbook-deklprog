Gegeben seien folgende Funktionen:
- `rgbToHsv :: RGB -> HSV`, die eine Farbe von einer Darstellung
  in eine andere konvertiert, und
- `hue :: HSV -> Float`, die den Farbwert einer Farbe im Wertebereich
  $[0°, 360°)$ im HSV-Farbraum zurückgibt.
Du bekommst als Eingabe ein Bild, das hier als Liste von `RGB`-Werten
dargestellt ist. Jeder `RGB`-Wert korrespondiert zu einem Pixel.
Schreibe eine Funktion, die berechnet, wie viele blaue Pixel das Bild hat.
Hier bezeichnen wir eine Farbe als blau, wenn ihr Farbwert zwischen $200°$ und
$250°$ (inklusiv) liegt. Nutze für die Definition der Funktion sowohl
`map` als auch `filter`.
