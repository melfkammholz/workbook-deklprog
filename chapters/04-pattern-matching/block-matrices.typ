#let mA = $bold(upright(A))$
In der numerischen Mathematik gibt es Algorithmen, die über Blockmatrizen
ausgedrückt werden. Dabei wird eine Matrix $mA in K^(n times n)$ als
$ mA = mat(a_(1 1), mA_(1 *); mA_(* 1), mA_(**)) quad "oder" quad mA = mat(mA_(**), mA_(* n); mA_(n *), a_(n n)). $
aufgefasst, wobei $a_11, a_(n n) in K, mA_(1 *), mA_(n *) in K^(1 times (n - 1))$,
$mA_(* 1), mA_(* n) in K^((n - 1) times 1)$ und $mA_(**) in K^((n - 1) times (n - 1))$
sind.

Implementiere sowohl `unblock :: Mat a -> (Mat a, Mat a, Mat a, Mat a)`
als auch `block :: (Mat a, Mat a, Mat a, Mat a) -> Mat a` für beide
Darstellungen in ```text LinearAlgebra.hs```. Der Datentyp `Mat a` sei
hier wie folgt definiert `newtype Mat a = Mat [[a]]`.

Hier sind ein paar Beispiele.
```haskell
> unblock (Mat [[1, 2, 3], [3, 4, 5]])
(Mat [[1]], Mat [[2, 3]], Mat [[3]], Mat [[4, 5]])
> unblock' (Mat [[1, 2, 3], [3, 4, 5]])
(Mat [[1, 2]], Mat [[3]], Mat [[3, 4]], Mat [[5]])
> block (Mat [[1]], Mat [[2, 3]], Mat [[4], [7]], Mat [[5, 6], [8, 9]])
Mat [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
```

In der Vorlage findest du auch andere unimplementierte Funktionen
`vstack, hstack, vsplitn, hsplit1, hsplitn`, die als Hilfsfunktionen
für `block, unblock, unblock'` gedacht sind.

Dieses Abenteuer arbeitet in derselben Datei weiter, sodass du deine Funktionen später wiederverwenden kannst.
