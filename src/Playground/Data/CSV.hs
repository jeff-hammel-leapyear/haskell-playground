-- | CSV related functionality

module Playground.Data.CSV (toCSV, toTable) where

import Data.List (intercalate)
import Data.String (String(..))

toTable :: [(a -> b)] -> [a] -> [[b]]
toTable f a = [fmap ($ a') f | a' <- a]

-- TODO:
-- show' :: Show a => a -> String
-- show' String a = a
-- show' b = show b

toCSV :: Show a => [[a]] -> String
toCSV table = unlines $ map showRow table
  where
    showRow = (intercalate ",") . (map show)
