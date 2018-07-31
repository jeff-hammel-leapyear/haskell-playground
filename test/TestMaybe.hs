{-# LANGUAGE ScopedTypeVariables #-}

-- | Test our understanding of Maybe patterns

module TestMaybe where

import Data.Maybe (catMaybes)
import Test.Tasty
import Test.Tasty.HUnit

-- Let's say you have multiple types and you want to act on them differently

data Foo = Bar Int | Fleem Float Int | Baz String

testdata = [Bar 2, Fleem 3.5 3, Bar 7, Baz "hello"]

getMaybeInt :: Foo -> Maybe Int
getMaybeInt foo = case foo of
  Bar i -> Just i
  Fleem _ i -> Just i
  Baz _ -> Nothing

-- This is what we want to test
getInts :: [Foo] -> [Int]
getInts f = catMaybes $ map getMaybeInt f

tests :: TestTree
tests = testGroup "TastyTests" [unitTests]

unitTests = testGroup "Unit tests"
  [
    testCase "Test our getInts" $
      getInts testdata @?= [2,3,7]
  ]

unit_testMaybe :: IO ()
unit_testMaybe = getInts testdata @?= [2,3,7]

