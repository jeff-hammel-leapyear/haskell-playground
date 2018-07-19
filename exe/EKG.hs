{-# LANGUAGE OverloadedStrings #-}

import System.Remote.Monitoring

complicatedCalculation :: (Num a, Foldable t) => t a -> a
complicatedCalculation series = (product series) + (sum series)

complicatedCalculations :: [Int] -> IO ()
complicatedCalculations (x:xs) = do
  let val = complicatedCalculation [1..x]
  print val
  complicatedCalculations xs
complicatedCalculations [] = putStrLn "You're done!"

main :: IO ()
main = do
  forkServer "localhost" 8001
  let sizes = map (10^) [1..maxPower10]
  complicatedCalculations $ cycle sizes
  where
    maxPower10 = 7
