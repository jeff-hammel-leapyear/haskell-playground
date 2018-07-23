module Playground.Process (retryProcess) where

import Control.Concurrent (threadDelay)
import System.Exit (ExitCode(..))
import System.Process (readProcessWithExitCode)


retryProcess :: FilePath -> [String] -> String -> Int -> Int -> IO (ExitCode, String, String)
retryProcess exe args stdin retries delay = do
  (code, stdout, stderr) <- readProcessWithExitCode exe args stdin
  if (retries == 0) then return (code, stdout, stderr) else return (code, stdout, stderr)

