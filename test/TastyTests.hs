-- | Example of tasty:
-- | https://hackage.haskell.org/package/tasty

module TastyTests where

import Test.Tasty
import Test.Tasty.HUnit

test_tree :: IO TestTree
test_tree = pure $ testGroup "TastyTests" [unitTests]

unitTests = testGroup "Unit tests"
  [ testCase "List comparison (different length)" $
      [1, 2, 3] `compare` [1,2] @?= GT

  -- the following test does not hold
  , testCase "List comparison (same length)" $
      [1, 2, 3] `compare` [1,2,2] @?= GT
  ]
