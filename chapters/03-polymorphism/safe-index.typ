Die `(!!)`-Funktion ist unsicher in dem Sinne, dass sie für invalide
Listenzugriffe einen Fehler wirft -- also z.B. für `xs !! (-1)` oder
`xs !! k` mit `k >= length xs`. Die Funktion
`(!?) :: [a] -> Int -> Maybe a` ist eine sichere Variante von
`(!!)`. Sie macht den Fehlerfall explizit durch die Wahl des
Ergebnistypen. Wie fängt der Ergebnistyp diesen Fehlerfall auf? Implementiere
diese Funktion.

#remark[
  Diese Funktion ist auch bereits vorimplementiert:
  #link("https://hackage.haskell.org/package/base-4.21.0.0/docs/Data-List.html#v:-33--63-")[`(!?)` in `Data.List`].
]
