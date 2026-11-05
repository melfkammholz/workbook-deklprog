Entwickle ein Prädikat `nth/3`, das das $n$-te Element
einer Liste zurückgibt. Zum Beispiel soll folgende Anfrage beweisbar sein.
```prolog
?- nth([3, 1, 4, 1, 5], s(s(o)), X).
X = 4.
```
