import Data.List (sort)
import Workbook.Check
import Reachability

graph :: [(Int, Int)] -> Graph () ()
graph es = Graph [] [(a, (), b) | (a, b) <- es]

main :: IO ()
main = runChecks
  [ eq "succs of a node"            (sort (succs 0 (graph [(0, 1), (0, 2), (1, 2)]))) [1, 2]
  , eq "succs of a sink"            (succs 2 (graph [(0, 1)])) []
  , check "a node reaches itself"   (reachable 0 0 (graph []))
  , check "in a tree"               (reachable 0 3 (graph [(0, 1), (0, 2), (2, 3)]))
  , check "not against an edge"     (not (reachable 1 0 (graph [(0, 1)])))
  , check "in a DAG"                (reachable 0 3 (graph [(0, 1), (0, 2), (1, 3), (2, 3)]))
  , check "ends on a cycle"         (not (reachable 0 9 (graph [(0, 1), (1, 2), (2, 0)])))
  , check "finds past a cycle"      (reachable 0 3 (graph [(0, 1), (1, 0), (1, 2), (2, 3)]))
  , check "yGraph: the left arm"    (reachable 0 50 (yGraph 50))
  , check "yGraph: the arms are apart" (not (reachable 1 60 (yGraph 50)))
  , check "stays fast on a DAG with many paths"
      (not (reachable 0 999 (graph (concat [[(i, i + 1), (i, i + 2)] | i <- [0 .. 200]]))))
  ]
