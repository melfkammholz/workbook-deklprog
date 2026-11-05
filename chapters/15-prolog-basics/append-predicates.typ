Mithilfe von `append/3` lassen sich sehr viele andere Prädikate
auf Listen definieren. Überlege dir, wie du folgende Prädikate unter dessen
Nutzung implementieren kannst. Die Prädikate sollen sich wie deren
entsprechenden Haskell-Funktionen verhalten, wenn dir der Name des Prädikats
bekannt vorkommt.
- `head/2` und `tail/2`,
- `last/2`,
- `member/2` (entspricht `elem` in Haskell)
- `dups/2` soll alle Elemente in einer Liste finden, die
  genau zweimal vorkommen. Du darfst `not_member/2` als
  Hilfsprädikat verwenden. Es ist definiert durch
  `not_member(X, L) :- \+ member(X, L).`. Als Zwischenschritt
  kannst du `dups/2` so implementieren, dass geprüft wird, ob
  ein Element mindestens zweimal vorkommt.
- `sublist/2` soll erfüllbar sein, wenn eine Liste in einer
  anderen ohne Lücken enthalten ist.
// - `subsequence/2` soll erfüllbar sein, wenn eine Liste in einer
//   anderen mit möglichen Lücken enthalten ist.

Warum ist `member/2` hier zweistellig?
