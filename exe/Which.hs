import Playground.Path (pathToList')
import System.Environment (lookupEnv)

main :: IO ()
main = do
  path <- lookupEnv "PATH"
  case path of
    Just path -> do
      directories <- pathToList' path
      putStr $ unlines directories
    Nothing -> putStrLn ""
