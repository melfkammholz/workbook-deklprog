Implementiere Arrays als nicht-mutierende Datenstruktur in Python. Die
Klasse soll so funktionieren, dass der folgende Beispielcode lauffähig ist
und die angegebene Ausgabe erzeugt.
```py
a = Array.fromList(5, [(2, 4), (3, 3)])

b = a.update([(1, 3), (2, 2)])
for i in range(len(a)):
  print(a[i], b[i])
```
Die Ausgabe des Programms soll
```text
None None
None 3
4 2
3 3
None None
```
sein.

Das Beispielprogramm steht in deiner Datei als Funktion `main`. Im Interpreter rufst du es mit `main()` auf.
