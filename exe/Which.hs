import Playground.Path (executables)
import System.Environment (lookupEnv)

main :: IO ()
main = do
  executables' <- executables "PATH" ":"
  print executables'
