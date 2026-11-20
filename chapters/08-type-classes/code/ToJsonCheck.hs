import Workbook.Check
import ToJson

leaf :: a -> Tree a
leaf x = Node Empty x Empty

empty :: JSON
empty = JObject [("tag", JString "Empty")]

node :: JSON -> JSON -> JSON -> JSON
node l v r = JObject [("tag", JString "Node"), ("left", l), ("value", v), ("right", r)]

main :: IO ()
main = runChecks
  [ eq "Bool True"                (toJSON True) (JBool True)
  , eq "Bool False"               (toJSON False) (JBool False)
  , eq "empty list"               (toJSON ([] :: [Bool])) (JArray [])
  , eq "list of Bool"             (toJSON [True, False]) (JArray [JBool True, JBool False])
  , eq "nested lists"             (toJSON [[True], []]) (JArray [JArray [JBool True], JArray []])
  , eq "pair"                     (toJSON (True, False))
      (JObject [("fst", JBool True), ("snd", JBool False)])
  , eq "pair of list and pair"    (toJSON ([True], (False, True)))
      (JObject [("fst", JArray [JBool True]), ("snd", JObject [("fst", JBool False), ("snd", JBool True)])])
  , eq "empty tree"               (toJSON (Empty :: Tree Bool)) empty
  , eq "single node"              (toJSON (leaf True)) (node empty (JBool True) empty)
  , eq "tree of lists"            (toJSON (Node (leaf [True]) [] Empty))
      (node (node empty (JArray [JBool True]) empty) (JArray []) empty)
  , eq "list of trees"            (toJSON [leaf False, Empty])
      (JArray [node empty (JBool False) empty, empty])
  ]
