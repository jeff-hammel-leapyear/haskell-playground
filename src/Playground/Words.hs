module Playground.Words ( count
                        , sortCount
                        ) where

import Data.List (sortBy)
import Data.Map (Map(..), fromListWith, toList)

count :: (Ord k, Num a) => [k] -> Map k a
count items = fromListWith (+) counted
  where
    counted = [ (k, 1) | k <- items ]

sortCount :: Ord a => [(String, a)] -> [(String, a)]
sortCount = sortBy (flip compare')
  where
    compare' a b | snd a == snd b = compare (fst a) (fst b)
                 | otherwise = compare (snd a) (snd b)
