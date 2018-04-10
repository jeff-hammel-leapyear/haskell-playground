-- Environment report; in Haskell

module Playground.Envreport ( intercalate'
                            , envReport
                            ) where

import Data.List (intercalate)
import System.Environment (getEnvironment)


intercalate' :: String -> (String, String) -> String
intercalate' a b = intercalate a [fst b, snd b]

envReport :: IO String
envReport = do
  env <- getEnvironment
  return (unlines $ [ intercalate' "=" a | a <- env ])
