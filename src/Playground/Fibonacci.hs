module Playground.Fibonacci (fibonacci) where

fibonacci :: (Integral n) => n -> [n]
fibonacci 1 = [1]
fibonacci 2 = [1, 1]
fibonacci n = x ++ [(x !! ((length x) - 2)) + last x]
  where x = fibonacci (n-1)
