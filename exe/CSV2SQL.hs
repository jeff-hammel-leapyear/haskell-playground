{-# LANGUAGE RecordWildCards #-}

-- Conver CSV to SQL (an experiment!)

import Data.Semigroup ((<>))
import Playground.CSV (CSVType(..))
import Options.Applicative ( Parser
                           , (<**>)
                           , argument
                           , execParser
                           , fullDesc
                           , header
                           , help
                           , helper
                           , info
                           , metavar
                           , progDesc
                           , str
                           )


data Options = Options { path :: String }
parser :: Parser Options
parser = Options
      <$> argument str
          ( metavar "PATH"
         <> help "Path to CSV file" )

main :: IO ()
main = do
  Options {..} <- execParser opts
  putStr path
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "something something something CSV"
     <> header   "You asked for --help" )
