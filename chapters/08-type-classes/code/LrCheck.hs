import Data.Ratio ((%))
import Workbook.Check
import LinearAlgebra

type Q = Rational

-- A lower and an upper triangular matrix with non-zero diagonals, so their product has an LR.
newtype Factorable = Factorable (Mat Q) deriving Show

instance Arbitrary Factorable where
  arbitrary = do
    k <- chooseInt (1, 4)
    let entry = (% 1) . fromIntegral <$> chooseInt (-5, 5)
        pivot = (% 1) . fromIntegral <$> elements [-3, -2, -1, 1, 2, 3 :: Int]
    ls <- sequence [sequence [if j < i then entry else pure (if j == i then 1 else 0) | j <- [1 .. k]] | i <- [1 .. k]]
    rs <- sequence [sequence [if j > i then entry else if j == i then pivot else pure 0 | j <- [1 .. k]] | i <- [1 .. k]]
    pure (Factorable (Mat ls * Mat rs))

a2 :: Mat Q
a2 = Mat [[2, 1], [4, 5]]

main :: IO ()
main = runChecks
  [ eq "lu of a 1x1 matrix"             (lu (Mat [[3 :: Q]])) (Just (Mat [[1]], Mat [[3]]))
  , eq "lu of a 2x2 matrix"             (lu a2) (Just (Mat [[1, 0], [2, 1]], Mat [[2, 1], [0, 3]]))
  , eq "lu of a singular matrix"        (lu (Mat [[1, 2], [2, 4 :: Q]])) Nothing
  , eq "det of a 2x2 matrix"            (det a2) 6
  , eq "det of a singular matrix"       (det (Mat [[1, 2], [2, 4 :: Q]])) 0
  , eq "forward solves Lx = b"          (forward (Mat [[1, 0], [2, 1]]) (Mat [[1], [4 :: Q]])) (Mat [[1], [2]])
  , eq "backward solves Rx = b"         (backward (Mat [[2, 1], [0, 3]]) (Mat [[3], [3 :: Q]])) (Mat [[1], [1]])
  , eq "solve finds x"                  (solve a2 (Mat [[3], [9]])) (Just (Mat [[1], [1]]))
  , eq "inv of a 2x2 matrix"            (fmap (a2 *) (inv a2)) (Just (identity 2))
  , prop "lu gives the factors back" $ \(Factorable m) -> fmap (uncurry (*)) (lu m) == Just m
  , prop "solve gives a solution" $ \(Factorable m@(Mat rows)) ->
      let b = Mat (map (const [1]) rows) in fmap (m *) (solve m b) == Just b
  ]
