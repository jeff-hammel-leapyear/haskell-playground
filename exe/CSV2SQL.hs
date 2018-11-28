{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

-- Convert CSV to SQL (an experiment!)
-- See https://github.com/haskell-hvr/cassava

import qualified Data.ByteString.Lazy as BL
import Data.Semigroup ((<>))
import Dava.Csv
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
