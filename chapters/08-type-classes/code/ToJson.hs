module ToJson (JSON (..), Tree (..), ToJSON (..)) where

data JSON = JNull
          | JBool Bool
          | JInt Int
          | JFloat Float
          | JString String
          | JArray [JSON]
          | JObject [(String, JSON)]
  deriving (Show, Eq)

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving Show

#ifdef TEMPLATE
-- Define the class ToJSON here (replace the method signature if you like).
class ToJSON a where
  toJSON :: a -> JSON

-- Fill in the instances. Think about which contexts they need.
instance ToJSON Bool where
  toJSON = undefined

instance ToJSON [a] where
  toJSON = undefined

instance ToJSON (a, b) where
  toJSON = undefined

instance ToJSON (Tree a) where
  toJSON = undefined
#else
class ToJSON a where
  toJSON :: a -> JSON

instance ToJSON Bool where
  toJSON = JBool

instance ToJSON a => ToJSON [a] where
  toJSON xs = JArray (map toJSON xs)

instance (ToJSON a, ToJSON b) => ToJSON (a, b) where
  toJSON (x, y) = JObject [("fst", toJSON x), ("snd", toJSON y)]

instance ToJSON a => ToJSON (Tree a) where
  toJSON Empty = JObject [("tag", JString "Empty")]
  toJSON (Node l x r) = JObject
    [ ("tag", JString "Node")
    , ("left", toJSON l)
    , ("value", toJSON x)
    , ("right", toJSON r)
    ]
#endif
