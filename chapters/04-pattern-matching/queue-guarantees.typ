Diese Seite geht über die Vorlesung hinaus und ist für dich, falls dich das Thema besonders interessiert. Sie gehört zu #xref("queue").

Wenn sogar `length xs >= length ys` für eine queue `Q xs ys` gewährleistet wird
und die Liste `ys` schrittweise an `xs` angehängt wird, dann hilft uns lazy
evaluation: Die Operationen bleiben amortisiert konstant, aber eine einzelne
`dequeue`-Operation braucht nur noch logarithmische statt linearer Laufzeit. Die
amortisierten Laufzeiten gelten dann auch, wenn alte Versionen einer queue
weiterverwendet werden. Dafür muss man die Längen der Listen immer vorhalten.
Mit einer weiteren Liste, die die Auswertung vorzieht, ist sogar jede Operation
im schlechtesten Fall konstant. Mehr darüber findest du in
#link("https://www.cambridge.org/core/journals/journal-of-functional-programming/article/simple-and-efficient-purely-functional-queues-and-deques/7B3036772616B39E87BF7FBD119015AB")[Simple and efficient purely functional queues and deques]
von Chris Okasaki lesen. Falls dich funktionale Datenstrukturen allgemein
interessieren, sei dir
#link("https://www.cs.cmu.edu/~rwh/students/okasaki.pdf")[seine
Doktorarbeit] empfohlen.
