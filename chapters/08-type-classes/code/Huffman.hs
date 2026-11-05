module Huffman (Bit (..), HuffmanTree, frequencies, huffmanTree, code, encode, decode) where

#ifndef TEMPLATE
import Data.List (find, group, inits, insert, sort)
import Data.Maybe (fromJust)
#endif

data Bit = Zero | One
  deriving (Eq, Show)

#ifdef TEMPLATE
-- | Add the constructors of your data type here, and an Ord instance.
data HuffmanTree a

frequencies :: Ord a => [a] -> [(a, Int)]
frequencies xs = undefined

huffmanTree :: [(a, Int)] -> HuffmanTree a
huffmanTree hist = undefined

code :: HuffmanTree a -> [(a, [Bit])]
code t = undefined

encode :: Eq a => [a] -> [(a, [Bit])] -> [Bit]
encode xs c = undefined

decode :: [Bit] -> [(a, [Bit])] -> [a]
decode bs c = undefined
#else
frequencies :: Ord a => [a] -> [(a, Int)]
frequencies xs = map (\g -> (head g, length g)) (group (sort xs))

data HuffmanTree a = Leaf a Int | Node (HuffmanTree a) Int (HuffmanTree a)

frequency :: HuffmanTree a -> Int
frequency (Leaf _ n)   = n
frequency (Node _ n _) = n

instance Eq (HuffmanTree a) where
  x == y = frequency x == frequency y

instance Ord (HuffmanTree a) where
  x <= y = frequency x <= frequency y

huffmanTree :: [(a, Int)] -> HuffmanTree a
huffmanTree hist = go (sort (map (uncurry Leaf) hist))
  where
    go [t]           = t
    go (t1 : t2 : ts) = go (insert (Node t1 (frequency t1 + frequency t2) t2) ts)
    go []            = error "huffmanTree: no symbols"

code :: HuffmanTree a -> [(a, [Bit])]
code (Leaf c _) = [(c, [Zero])]
code t          = go t
  where
    go (Leaf c _)     = [(c, [])]
    go (Node l _ r) = map (fmap (Zero :)) (go l) ++ map (fmap (One :)) (go r)

encode :: Eq a => [a] -> [(a, [Bit])] -> [Bit]
encode xs c = concatMap (fromJust . flip lookup c) xs

decode :: [Bit] -> [(a, [Bit])] -> [a]
decode [] _ = []
decode bs c =
  let inverse = map (\(x, w) -> (w, x)) c
      p = fromJust (find (`elem` map fst inverse) (inits bs))
   in fromJust (lookup p inverse) : decode (drop (length p) bs) c
#endif
