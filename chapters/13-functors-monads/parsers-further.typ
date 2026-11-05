In der Evaluation des Moduls im Wintersemester 2025/2026 hat sich eine Person
gewünscht, dass das Prolog-Interpreter-Projekt erweitert wird, sodass auch der
Parser selbst gebaut werden muss. Leider ist in diesem Modul zu wenig Zeit, um dieses
Thema hinreichend zu behandeln. Das rabbit hole soll dir mit dieser Bemerkung neben
den vorigen Tests und Challenges etwas weiter eröffnet werden.

- Der Parser aus dem Projekt basiert auf
  #link("https://hackage.haskell.org/package/parsec")[parsec], einer Bibliothek
  bestehend aus verschiedenen monadischen Parser-Kombinatoren. Die wesentlichen
  Ideen, die diese Bibliothek nutzt, findest du in dem paper
  #link("https://www.cambridge.org/core/journals/journal-of-functional-programming/article/monadic-parsing-in-haskell/E557DFCCE00E0D4B6ED02F3FB0466093")[Monadic parsing in Haskell]
  beschrieben. Etwas weniger in die Tiefe geht einer der Co-Autoren in diesem Video
  #link("https://www.youtube.com/watch?v=dDtZLm7HIJs")[Functional Parsing].
- Mit dieser Bibliothek lassen sich sogenannte
  #link("https://en.wikipedia.org/wiki/Recursive_descent_parser")[recursive descent parser]
  spezifizieren. Die Syntax der Kombinatoren ermöglicht es, dass entsprechende
  Grammatiken fast direkt aus der mathematischen Notation in ein Haskell-Programm
  überführt werden können.
- Als Nächstes benötigen wir eine Grammatik für die Syntax von Prolog. Nicht jede
  Grammatik ist dafür geeignet, insbesondere müssen wir bei rekursiven
  Abstiegsparsern darauf achten, dass die Grammatik nicht linksrekursiv ist.
- So können wir dann einen abstrakten Syntaxbaum berechnen, so wie du ihn aus dem
  Projekt kennst. Der Baum wird durch die vielen gegebenen Typen dargestellt.

Je nachdem wie dich das Thema interessiert, behandelt Frank z.B. in seiner Vorlesung
"Funktionale Programmierung" monadisches Parsen. Wenn du noch tiefer einsteigen
willst, dann wird auch hin und wieder das Modul "Übersetzerbau" angeboten. Für einen
tieferen Einstieg wird oft folgende Literatur empfohlen.
- Compilers: Principles, Techniques, and Tools von Alfred V. Aho, Monica S. Lam, Ravi
  Sethi und Jeffrey D. Ullman (auch dragon book genannt) und
- Engineering a Compiler von Keith D. Cooper und Linda Torczon (das Modul
  Übersetzerbau nutzt dieses Buch)
