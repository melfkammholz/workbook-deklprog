Monaden sind ausdrucksstärker als applikative Funktoren, und applikative
Funktoren sind ausdrucksstärker als Funktoren.
- Implementiere `fmap`, `pure` und `(<*>)` mithilfe von
  `return` und `(>>=)`.
- Implementiere `fmap` mithilfe von `pure` und `(<*>)`.

#remark[
  Die Erkenntnis dieses Tests kannst du nutzen, wenn es für dich einfacher
  ist eine Monaden-Instanz anzugeben, anstatt Funktoren- und applikative
  Funktor-Instanzen anzugeben oder um Zeit zu sparen.
]
