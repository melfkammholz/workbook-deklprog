{-# LANGUAGE ScopedTypeVariables #-}
import Prelude hiding (all, any, elem, length, maximum, minimum, notElem, null, product, sum)
import qualified Prelude as P
import Workbook.Check
import FoldTree

fromList :: [a] -> Tree a
fromList []     = Empty
fromList (x:xs) = Node (fromList l) x (fromList r)
  where (l, r) = splitAt (P.length xs `div` 2) xs

inorder :: Tree a -> [a]
inorder Empty        = []
inorder (Node l x r) = inorder l ++ [x] ++ inorder r

tree :: Tree Int
tree = Node (Node Empty 1 Empty) 2 (Node Empty 3 Empty)

main :: IO ()
main = runChecks
  [ check "any finds a match"          (any even tree)
  , check "any on the empty tree"      (not (any even (Empty :: Tree Int)))
  , check "all fails on one mismatch"  (not (all even tree))
  , check "all on the empty tree"      (all even (Empty :: Tree Int))
  , check "elem finds 3"               (elem 3 tree)
  , check "notElem for 4"              (notElem 4 tree)
  , eq "toList goes from left to right" (toList tree) [1, 2, 3]
  , check "null on the empty tree"     (null (Empty :: Tree Int))
  , check "null on a node"             (not (null tree))
  , eq "length"                        (length tree) 3
  , eq "maximum"                       (maximum tree) 3
  , eq "minimum"                       (minimum tree) 1
  , eq "sum"                           (sum tree) 6
  , eq "product"                       (product tree) 6
  , eq "sum of the empty tree"         (sum Empty) 0
  , eq "product of the empty tree"     (product Empty) 1
  , prop "all of them agree with lists" $ \(NonEmpty (xs :: [Int])) ->
      let t = fromList xs; l = inorder t
       in toList t == l && length t == P.length l && sum t == P.sum l
            && maximum t == P.maximum l && minimum t == P.minimum l
            && any even t == P.any even l && all even t == P.all even l
  ]
