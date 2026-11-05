Eine Halbgruppe ist eine Struktur $(H, ast.op)$, wobei $H$ eine Menge ist und
$ast.op$ eine assoziative, binäre Verknüpfung $ast.op : H times H -> H$ ist.
Ein Monoid erweitert die Halbgruppe um ein neutrales Element bzgl. $ast.op$.

Definiere Typklassen `Semigroup` und `Monoid`, die diese Strukturen implementieren. Da die Prelude beide bereits exportiert, brauchst du dafür `import Prelude hiding (Semigroup (..), Monoid (..))`. Gib auch beispielhaft ein paar Instanzen für
diese an.

#remark[
  Diese Typklassen sind vorimplementiert in Haskell. Sie befinden sich in den
  Modulen #link("https://hackage-content.haskell.org/package/base/docs/Data-Semigroup.html")[`Data.Semigroup`]
  und #link("https://hackage-content.haskell.org/package/base/docs/Data-Monoid.html")[`Data.Monoid`].
]
