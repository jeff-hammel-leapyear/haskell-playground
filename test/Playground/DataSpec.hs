-- data related tests

{-# LANGUAGE QuasiQuotes #-}
module Playground.DataSpec (spec_tables) where

import Test.Tasty.Hspec
import Text.RawString.QQ

import Playground.Data.CSV (toTable, toCSV)

csvtestdata = [[1,2,3],[4,5,6],[7,8,9]]
csv = [r|1,2,3
4,5,6
7,8,9
|]

sqr x = x*x
functions = [(*2), sqr, (+3)]
testdata = [2, 3]
testresults = [[4, 4, 5], [6, 9, 6]]

data Person = Person { name :: String,
                       age :: Int,
                       height :: Float  -- in meters, obviously
                     }
people = [ Person { name = "Papu", age = 5, height = 1.8 },
           Person { name = "Gary Oldman", age = 50, height = 1.7 } ]
peoplecsv = [r|"Papu","5","1.8"
"Gary Oldman","50","1.7"
|]
peoplefunctions = [name, show . age, show . height]

spec_tables :: Spec
spec_tables = describe "tables" $ do

  it "makes a table" $ do
    toTable functions testdata `shouldBe` testresults


  it "converts to CSV" $ do
    toCSV csvtestdata `shouldBe` csv

  it "can print CSV records" $ do
    toCSV (toTable peoplefunctions people) `shouldBe` peoplecsv
