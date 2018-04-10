-- | wordcount

module Main where

import Data.Map (toList)

import Playground.Words (count, sortCount)

text = "the man says a man a plan a canal panama canal"

main :: IO ()
main = do
  putStr $ toCSV $ sortCount $ toList counted
  where
    counted = count $ words text
    toCSV l = unlines [ a ++ "," ++ (show b) | (a,b) <- l]
