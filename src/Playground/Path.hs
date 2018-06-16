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
                        , executable
                        , findExecutablesInDirectories
                        , getPermissions
                        , listDirectory )
import System.IO (FilePath)
import System.Environment (lookupEnv)
import System.FilePath ((</>))

pathToList :: String -> String -> IO [String]
pathToList sep path = filterM doesDirectoryExist split
  where
    split = splitOn sep path

pathToList' = pathToList ":"

listDirectoryWith :: (FilePath -> IO Bool) -> FilePath -> IO [FilePath]
listDirectoryWith check directory = listDirectory directory >>= filterM check

isExecutable :: FilePath -> IO Bool
isExecutable = fmap executable . getPermissions

listExecutables :: FilePath -> IO [FilePath]
listExecutables = listDirectoryWith isExecutable

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
