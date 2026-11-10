import Workbook.Check
import Build

-- The tests use their own idea of "balanced": the exercise's `balanced` is the student's.
refBalanced :: Tree a -> Bool
refBalanced (Leaf _)  = True
refBalanced (l :+: r) = refBalanced l && refBalanced r && abs (height l - height r) <= 1

main :: IO ()
main = runChecks
  [ check "balanced (Leaf 1)"                          (balanced (Leaf 1))
  , check "balanced ((Leaf 1 :+: Leaf 2) :+: Leaf 3)"  (balanced ((Leaf 1 :+: Leaf 2) :+: Leaf 3))
  , check "nicht balanced: Leaf 1 :+: (Leaf 2 :+: (Leaf 3 :+: Leaf 4))"
                                                       (not (balanced (Leaf 1 :+: (Leaf 2 :+: (Leaf 3 :+: Leaf 4)))))
  , check "nicht balanced: ein Teilbaum ist unbalanciert, obwohl die Höhen an der Wurzel passen"
      (not (balanced ((Leaf 1 :+: (Leaf 2 :+: (Leaf 3 :+: Leaf 4))) :+: ((Leaf 5 :+: Leaf 6) :+: (Leaf 7 :+: Leaf 8)))))
  , eq "build [1] = Leaf 1"                            (build [1 :: Int]) (Leaf 1)
  , eq "toList (build [1 .. 5]) = [1 .. 5]"            (toList (build [1 .. 5 :: Int])) [1 .. 5]
  , prop "build behält Werte und Reihenfolge"          $ forAll (listOf1 arbitrary) $ \xs ->
                                                         toList (build (xs :: [Int])) == xs
  , prop "build liefert einen balancierten Baum"       $ forAll (listOf1 arbitrary) $ \xs ->
                                                         refBalanced (build (xs :: [Int]))
  ]
