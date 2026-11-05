{-# LANGUAGE ScopedTypeVariables #-}
import Data.List (isPrefixOf, sort, tails)
import Workbook.Check
import Huffman

codeOf :: String -> [(Char, [Bit])]
codeOf = code . huffmanTree . frequencies

roundTrip :: String -> String
roundTrip s = let c = codeOf s in decode (encode s c) c

main :: IO ()
main = runChecks
  [ eq "frequencies counts every symbol"     (sort (frequencies "abca")) [('a', 2), ('b', 1), ('c', 1)]
  , eq "frequencies of nothing"              (frequencies "") []
  , eq "the most frequent symbol gets 1 bit" (length <$> lookup 'a' (codeOf "aaaabbc")) (Just 1)
  , eq "aaaabbc needs 10 bits"               (length (encode "aaaabbc" (codeOf "aaaabbc"))) 10
  , eq "encoding and decoding gives it back" (roundTrip "abracadabra") "abracadabra"
  , eq "one symbol still has a code"         (roundTrip "aaaa") "aaaa"
  , prop "no code is the start of another" $ \(NonEmpty (s :: String)) ->
      let ws = map snd (codeOf s) in and [not (isPrefixOf u v) | (u : vs) <- tails ws, v <- vs]
  , prop "any text comes back" $ \(NonEmpty (s :: String)) -> roundTrip s == s
  ]
