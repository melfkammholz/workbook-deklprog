Gegeben sei folgendes Python-Programm.
```py
class TodoList:
  def __init__(self):
    self.todos = []
    self.completed = 0

  def add(self, todo):
    self.todos = [todo] + self.todos

  def remove(self, index):
    self.todos.pop(index)
    self.completed += 1
```
In #xref("imperative-variables") haben wir gesehen, wie das Konzept der
imperativen Variablen bzw. mutierbaren Zustands vergleichbar mit dem Einführen
weiterer Funktionsparameter ist. Da wir nun Datentypen kennengelernt haben,
wollen wir das Konzept der Klassen aufgreifen. Entwickle einen Datentypen
`TodoList`, der Todos und die Anzahl der fertigen Todos hält (vgl. obiges
Programm). Zur Vereinfachung kannst du annehmen, dass ein Todo durch eine Zahl
dargestellt wird. Implementiere danach die Funktionen `empty`, `add` und
`remove`, die sich wie die Methoden `__init__`, `add` und `remove` verhalten.

Du kannst davon ausgehen, dass nur valide Indizes zum Löschen von Todos
verwendet werden.

Damit die Tests deinen Datentypen nicht kennen müssen, implementiere außerdem
`todos` und `completed`, die die Todos und die Anzahl der fertigen Todos liefern.
