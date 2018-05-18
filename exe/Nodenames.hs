{-# LANGUAGE RecordWildCards #-}

-- | Extract + print node names in order

module Main where

import Options.Applicative

import Data.ByteString.Char8 (unpack, pack)
import Data.Semigroup ((<>))
import Xeno.DOM (name)

import Playground.Xml (extractNodes)

newtype Options = Options { path :: String }

parser :: Parser Options
parser = Options
      <$> argument str
          ( metavar "PATH"
         <> help "Path to XML file" )

main :: IO ()
main = do
  Options {..} <- execParser opts
  xml <- readFile path
  putStr $ unlines $ map strname ( extractNodes $ pack xml )
  where
    opts = info ( parser <**> helper)
      ( fullDesc
     <> progDesc "XML node names" )
    strname = unpack . name
