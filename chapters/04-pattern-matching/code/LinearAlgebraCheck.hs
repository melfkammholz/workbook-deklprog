import Workbook.Check
import LinearAlgebra

newtype Square = Square (Mat Int) deriving Show

instance Arbitrary Square where
  arbitrary = do
    n <- chooseInt (2, 6)
    Square . Mat <$> vectorOf n (vectorOf n arbitrary)

m3 :: Mat Int
m3 = Mat [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

main :: IO ()
main = runChecks
  [ eq "vstack"                    (vstack (Mat [[1, 2]]) (Mat [[3, 4 :: Int]])) (Mat [[1, 2], [3, 4]])
  , eq "hstack"                    (hstack (Mat [[1], [2]]) (Mat [[3], [4 :: Int]])) (Mat [[1, 3], [2, 4]])
  , eq "hsplit1 splits off the first column" (hsplit1 m3) (Mat [[1], [4], [7]], Mat [[2, 3], [5, 6], [8, 9]])
  , eq "hsplitn splits off the last column"  (hsplitn m3) (Mat [[1, 2], [4, 5], [7, 8]], Mat [[3], [6], [9]])
  , eq "vsplitn splits off the last row"     (vsplitn m3) (Mat [[1, 2, 3], [4, 5, 6]], Mat [[7, 8, 9]])
  , eq "unblock of the example"    (unblock (Mat [[1, 2, 3], [3, 4, 5 :: Int]]))
       (Mat [[1]], Mat [[2, 3]], Mat [[3]], Mat [[4, 5]])
  , eq "unblock' of the example"   (unblock' (Mat [[1, 2, 3], [3, 4, 5 :: Int]]))
       (Mat [[1, 2]], Mat [[3]], Mat [[3, 4]], Mat [[5]])
  , eq "unblock of a 3x3 matrix"   (unblock m3)
       (Mat [[1]], Mat [[2, 3]], Mat [[4], [7]], Mat [[5, 6], [8, 9]])
  , eq "unblock' of a 3x3 matrix"  (unblock' m3)
       (Mat [[1, 2], [4, 5]], Mat [[3], [6]], Mat [[7, 8]], Mat [[9]])
  , eq "block of the example"
       (block (Mat [[1]], Mat [[2, 3]], Mat [[4], [7]], Mat [[5, 6], [8, 9]])) m3
  , prop "block undoes unblock" $ \(Square m) -> block (unblock m) == m
  , prop "block undoes unblock'" $ \(Square m) -> block (unblock' m) == m
  ]
