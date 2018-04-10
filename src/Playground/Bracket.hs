#!/usr/bin/env stack
-- stack --resolver lts-10.3 script --package shell-conduit --package unix --package random --package directory

module Main where

import Control.Exception (bracket)

-- https://hackage.haskell.org/package/directory-1.3.2.0/docs/System-Directory.html
import System.Directory (createDirectory,
                         doesPathExist,
                         removeDirectoryRecursive)
import System.Random (getStdGen, randomRs)


-- to generalize
tmpdir = "/tmp"


sample :: Int -> IO String
sample len = do
  gen <- getStdGen
  return [allowedRandoms !! i | i <- take len $ randomRs (0, arLength-1) gen]
    where allowedRandoms = ['a'..'z'] ++ ['0'..'9'] ++ ['A'..'Z']
          arLength = length allowedRandoms

makeDirectory :: FilePath -> IO FilePath
makeDirectory directory = do
  createDirectory directory
  return directory

createTemporaryDirectory :: IO FilePath
createTemporaryDirectory = do
  filename <- sample 12
  let directory = tmpdir ++ "/" ++ filename
  exists <- doesPathExist directory
  d <- (if exists then createTemporaryDirectory else makeDirectory directory)
  return d

-- https://wiki.haskell.org/Bracket_pattern
withTemporaryDirectory :: (FilePath -> IO c) -> IO c
withTemporaryDirectory f = bracket createTemporaryDirectory removeDirectoryRecursive f

main :: IO ()
main = do
  withTemporaryDirectory putStrLn
