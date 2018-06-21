-- | Functionality for dealing with PATH and similar

module Playground.Path ( executables
                       , isExecutable
                       , listDirectoryWith
                       , listExecutableTuples
                       , listExecutables
                       , pathToList
                       , pathToList') where

import Control.Monad (filterM)
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import qualified Data.Map as Map
import System.Directory ( canonicalizePath
                        , doesDirectoryExist
                        , doesFileExist
                        , executable
                        , findExecutablesInDirectories
                        , getPermissions
                        , listDirectory )
import System.IO (FilePath)
import System.Environment (lookupEnv)
import System.FilePath ((</>), takeFileName)

pathToList :: String -> String -> IO [String]
pathToList sep path = filterM doesDirectoryExist split
  where
    split = splitOn sep path

pathToList' = pathToList ":"

listDirectoryWith :: (FilePath -> IO Bool) -> FilePath -> IO [FilePath]
listDirectoryWith check directory = do
  contents <- listDirectory directory
  paths <- filterM check [ directory </> f | f <- contents ]
  return $ map takeFileName paths

isExecutable :: FilePath -> IO Bool
isExecutable = fmap executable . getPermissions

listExecutables :: FilePath -> IO [FilePath]
listExecutables directory = do
  contents <- listDirectoryWith doesFileExist directory
  exes <- filterM isExecutable [ directory </> f | f <- contents ]
  return $ map takeFileName exes

listExecutableTuples :: FilePath -> IO [(FilePath, FilePath)]
listExecutableTuples directory = do
  abs <- canonicalizePath directory
  exe <- listExecutables abs
  return [(f, abs </> f) | f <- exe]

executables :: String -> String -> IO (Map.Map FilePath FilePath)
executables env sep = do
  path <- fromMaybe "" <$> lookupEnv env
  directories <- pathToList sep path
  exe <- concat <$> mapM listExecutableTuples directories
  return $ Map.fromList exe

-- whichAll :: String -> IO [String]

-- which :: String -> Maybe String
