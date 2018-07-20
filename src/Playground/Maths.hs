module Playground.Maths (dot) where

dot :: Num a => [a] -> [a] -> a
dot a b = sum $ zipWith (*) a b
