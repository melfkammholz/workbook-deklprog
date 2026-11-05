Gegeben sei der Datentyp `data Tree a = Empty | Node (Tree a) a (Tree a)`
und die Faltungsfunktion `foldTree :: r -> (r -> a -> r -> r) -> Tree a -> r`.

Vergewissere dich, dass die Implementierung der folgenden Funktion, die alle
Beschriftungen durch den gleichen Wert ersetzt, korrekt ist.
```haskell
replace :: b -> Tree a -> Tree b
replace x = foldTree Empty (const . flip Node x)
```
Zeige, dass `const . flip Node x = \l y r -> Node l x r` ist.

#remark[
  Es gibt Programmierende, die einen sogenannten
  #link("https://wiki.haskell.org/Pointfree")[punktfreien Stil] bevorzugen.
  Weil es teilweise unterhaltsam sein kann, sich darüber Gedanken zu machen,
  was eine äquivalente punktfreie Funktion zu einem Lambda-Ausdruck sein könnte,
  steht hier eben `const . flip Node x` statt
  `\l _ r -> Node l x r`. Falls du damit herumspielen möchtest, findest
  du hier #link("https://pointfree.io/")[eine Seite], auf der du Haskell-Code in
  punktfreien Haskell-Code übersetzen kannst.
]

#sample[
  ```haskell
    const . flip Node x               -- Definition (.)
  = \l -> const (flip Node x l)       -- Definition flip
  = \l -> const (Node l x)            -- Definition const
  = \l -> \y -> Node l x              -- Notation
  = \l y -> Node l x                  -- Eta-Expansion
  = \l y r -> Node l x r
  ```
]
