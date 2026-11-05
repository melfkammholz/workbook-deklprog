Das Wortproblem für reguläre Ausdrücke kann mithilfe der
Brzozowski-Ableitung#note[In Berechnungen und Logik werden diese als
Linksquotienten vorgestellt, sofern sie behandelt werden.]
entschieden werden, also ob $w in L(R)$ für ein Wort $w in Sigma^*$ und einen
regulären Ausdruck $R$ über $Sigma$ gilt.

Die Brzozowski-Ableitung ist definiert als die Sprache
$ u^(-1) L = { v in Sigma^* | u v in L } $
für eine Sprache $L subset.eq Sigma^*$ und ein Wort $u in Sigma^*$. Die
Sprache $u^(-1) L$ ist also die Menge aller Wörter aus $L$, bei denen das Präfix
$u$ entfernt wurde.

Im Reiter ```text RegExp.hs``` findest du den Datentypen `RegExp`, den deine Vorlage
importiert. Vergleiche ihn mit deinem aus #xref("regexp-type"). In dieser Aufgabe
kannst du reguläre Ausdrücke im Interpreter auch als Zeichenketten schreiben, zum
Beispiel `"ab" :*: Kleene "c"`.

- Für welches $u in Sigma^*$ gilt
  $ w in L(R) <=> u in w^(-1) L(R)? $
- Implementiere eine Funktion `nullable :: RegExp -> Bool`, die bestimmt, ob
  $epsilon in L(R)$ gilt.
- Die Brzozowski-Ableitung für einen Buchstaben $a in Sigma$ wird wie folgt
  gebildet.
  #grid(
    columns: (auto, auto),
    gutter: 3em,
    [
      #emph[Basiselemente]
      - $a^(-1) a = epsilon$,
      - $a^(-1) b = emptyset$, falls $a != b$,
      - $a^(-1) epsilon = emptyset$,
      - $a^(-1) emptyset = emptyset$
    ],
    [
      #emph[Induktive Regeln]
      - $a^(-1) (R | S) = a^(-1) R | a^(-1) S$,
      - $a^(-1) (R S) = (a^(-1) R) S$, falls $epsilon in.not L(R)$,
      - $a^(-1) (R S) = (a^(-1) R) S | a^(-1) S$, falls $epsilon in L(R)$, und
      - $a^(-1) (R^*) = (a^(-1) R) R^*$.
    ]
  )
  Implementiere eine Funktion `brzozowski :: Char -> RegExp -> RegExp`, die die
  Brzozowski-Ableitung bzgl. eines Buchstaben berechnet.
- Implementiere eine Funktion `derivative :: String -> RegExp -> RegExp`, die die
  Brzozowski-Ableitung bzgl. eines Wortes berechnet.
- Implementiere eine Funktion `member :: String -> RegExp -> Bool`, die das
  Wortproblem für reguläre Ausdrücke löst.

#remark[
  Mit einem anderen Programmierstil lässt sich das Wortproblem auch direkter lösen.
  Falls dich das interessiert: #xref("member-continuations").
]
