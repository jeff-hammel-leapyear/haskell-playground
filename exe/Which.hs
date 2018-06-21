import Data.Maybe (fromMaybe)
import Playground.Path (executables, listExecutableTuples, pathToList)
import System.Environment (lookupEnv)

main :: IO ()
main = do
  path <- fromMaybe "" <$> lookupEnv env
  directories <- pathToList sep path
  -- The following line fails:
  exe <- concat <$> mapM listExecutableTuples directories
  putStr $ unlines $ map snd exe
  where
    sep = ":"
    env = "PATH"
--  executables' <- executables "PATH" ":"
--  print executables'
