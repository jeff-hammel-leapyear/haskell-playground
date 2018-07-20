{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

-- Example of EKG monitoring;
-- see https://github.com/tibbe/ekg .

import Data.Semigroup ((<>))
import Options.Applicative
import System.Remote.Monitoring (forkServer)

data Options = Options { port :: Int
                       , base :: Int
                       , maxPower :: Int }

parser :: Parser Options
parser = Options
      <$> option auto
           ( metavar "port"
          <> short 'p'
          <> long "port"
          <> value 8001
          <> help "port to serve EKG on" )
      <*> option auto
           ( short 'b'
          <> long "base"
          <> value 2
          <> help "integer base" )
      <*> option auto
           ( short 'm'
          <> long "max"
          <> value 16
          <> help "number of powers to cycle through" )


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
  Options {..} <- execParser opts
  forkServer "localhost" port
  let sizes = map ((^) base) [1..maxPower]
  complicatedCalculations $ cycle sizes
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "EKG sample program"
     <> header "You asked for --help" )
