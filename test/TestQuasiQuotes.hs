-- | Illustrate quasi-quotes
-- Reference:
-- - https://stackoverflow.com/questions/22918837/how-can-i-write-multiline-strings-in-haskell
-- - https://kseo.github.io/posts/2014-02-06-multi-line-strings-in-haskell.html

{-# LANGUAGE QuasiQuotes #-}
import Data.List (intercalate)
import Text.RawString.QQ
import Test.Tasty
import Test.Tasty.HUnit

sample = [r|<testcase classname="tests.test_api" file="tests/test_api.py" line="4" name="test_one" time="0.0007510185241699219"></testcase>|]
expected = "<testcase classname=\"tests.test_api\" file=\"tests/test_api.py\" line=\"4\" name=\"test_one\" time=\"0.0007510185241699219\"></testcase>"

multiline = [r|the quick brown
fox
jumped over
the lazy dog|]

multiexpected = intercalate "\n" ["the quick brown",
                                  "fox",
                                  "jumped over",
                                  "the lazy dog"]

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "TastyTests" [unitTests]

unitTests = testGroup "Quoting tests"
  [
    testCase "Quasiquoting" $
      sample @?= expected
  , testCase "Multiline" $
      multiline @?= multiexpected
  ]
