{-# LANGUAGE RecordWildCards #-}

import Data.Semigroup ((<>))
import Playground.Data.CSV (pairToCSV)
import Playground.Words (reverses)
import Options.Applicative

data Options = Options { path :: String }
parser :: Parser Options
parser = Options
      <$> argument str
          ( metavar "PATH"
         <> help "Path to dictionary file" )

main :: IO ()
main = do
  Options {..} <- execParser opts
  contents <- readFile path
  putStr $ pairToCSV $ reverses $ words contents
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "find all words that are reverse from a dictionary"
     <> header "You asked for --help" )
