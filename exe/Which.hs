{-# LANGUAGE RecordWildCards #-}

import Data.Semigroup ((<>))
import Options.Applicative
import Playground.Path (allExecutables, listExecutableTuples, pathToList, which, whichAll)
import System.Environment (lookupEnv)
import System.Exit (exitFailure)

data Options = Options { program :: Maybe String,
                         allProgs :: Bool}
parser :: Parser Options
parser = Options
      <$> (optional $ strArgument
           ( metavar "program"
          <> help "program to locate" ) )
      <*> switch
           ( short 'a'
          <> long "all"
          <> help "list all matches on PATH" )

main :: IO ()
main = do
  Options {..} <- execParser opts
  case program of
    Just x -> if allProgs
        then do
          progs <- whichAll x
          if null progs
            then
            exitFailure
            else
            putStr $ unlines progs
        else do
          path <- which x
          case path of
            Just p -> putStrLn p
            Nothing -> exitFailure
    Nothing -> do
      exe <- allExecutables env sep
      putStr $ unlines $ map snd exe
  where
    sep = ":"
    env = "PATH"
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "Haskell fancy which"
     <> header "You asked for --help" )
