-- | CSV Experiments

-- TODO:  deduplicate from Playground.Data.CSV

module Playground.CSV ( CSVType(..)
                      ) where

import Data.Text (Text(..))

data CSVType a = CSVInt Int | CSVFloat Float | CSVString Text

-- castRow :: [String] -> [CSVType]

-- cast :: [[String]] -> [[CSVType]]
-- cast a = map castRow a
