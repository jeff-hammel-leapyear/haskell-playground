module Playground.Reverse ( enumerate
                          , find
                          , rvrs
                          , words'
                          ) where

enumerate xs = zip [1..length xs] xs

find i xs = [x | (x, y) <- enumerate xs, y == i ]

words' xs = [take (i-1) xs | i <- find ' ' xs ++ [length xs]]

rvrs :: String -> String
rvrs x = concat (reverse y)
  where
    y = words' x

