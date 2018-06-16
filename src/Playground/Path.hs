-- | Functionality for dealing with PATH and similar

module Playground.Path (pathToList, pathToList') where

import Control.Monad (filterM)
import Data.List.Split (splitOn)
import System.Directory (doesDirectoryExist)
-- https://hackage.haskell.org/package/directory-1.3.2.2/docs/System-Directory.html

-- pathToList :: String -> String -> IO [String]
-- pathToList sep path = filterM $ doesDirectoryExist $ splitOn sep path

pathToList :: String -> String -> IO [String]
pathToList sep path = filterM doesDirectoryExist split
  where
    split = splitOn sep path

pathToList' = pathToList ":"

-- executables :: String -> IO
-- executables key
