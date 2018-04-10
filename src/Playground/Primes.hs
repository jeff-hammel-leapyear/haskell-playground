module Playground.Primes ( isPrime
                         , primes'
                         , primes
                         ) where

factor n = [i|i <- [2..n], mod n i == 0]

isPrime n = factor n == [n]

primes' n = [i|i <- [2..n], isPrime i]

primes = 2 : [n | n <- [3,5..], and [n `mod` k /= 0 | k <- takeWhile (<= floor (sqrt $ fromInteger n)) primes]]
