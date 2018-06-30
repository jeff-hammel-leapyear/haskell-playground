import Data.Maybe (fromMaybe)
import Options.Applicative
import Playground.Path (allExecutables, executables, listExecutableTuples, pathToList)
import System.Environment (lookupEnv)

data Options = Options { exes :: [String] }

main :: IO ()
main = do
  exe <- allExecutables env sep
  putStr $ unlines $ map snd exe
  where
    sep = ":"
    env = "PATH"

