module Playground.Words ( count
                        , reverses
                        , sortCount
                        ) where

import Data.List (sortBy)
import Data.Map (Map(..), fromListWith, toList)
import qualified Data.Set as Set


count :: (Ord k, Num a) => [k] -> Map k a
count items = fromListWith (+) counted
  where
    counted = [ (k, 1) | k <- items ]

sortCount :: Ord a => [(String, a)] -> [(String, a)]
sortCount = sortBy (flip compare')
  where
    compare' a b | snd a == snd b = compare (fst b) (fst a) -- keep alpha ascending
                 | otherwise = compare (snd a) (snd b)

reverses :: [String] -> [(String, String)]
reverses words' = [(word, reverse word) |
                   word <- Set.toAscList wordset,
                   reverse word `Set.member` wordset]
  where
    wordset = Set.fromList words'
