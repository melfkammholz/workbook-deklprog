module GraphColoring (minColor) where

import Data.Functor.Identity (Identity (..))
import Search (dfsM)

-- | Colours a graph with as few colours as possible. The graph is given by the
-- neighbours of every node, and the result has the colour of every node.
minColor :: [[Int]] -> [Int]
#ifdef TEMPLATE graph-coloring
minColor graph = undefined
#else
minColor graph = head [c | k <- [1 ..], Just c <- [color k]]
  where
    n = length graph

    -- A search place is a partial colouring of the first nodes.
    color k =
      case runIdentity (dfsM (Identity . next k) (Identity . ((== n) . length)) []) of
        (Just path, _) -> Just (reverse (last path))
        _              -> Nothing

    next k cs =
      [c : cs | length cs < n, c <- [0 .. k - 1], allowed c cs]

    allowed c cs =
      let v = length cs
          colorOf w = reverse cs !! w
       in and [colorOf w /= c | w <- graph !! v, w < v]
#endif
