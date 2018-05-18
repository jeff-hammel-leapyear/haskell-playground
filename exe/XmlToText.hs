{-# LANGUAGE OverloadedStrings #-}

-- | Convert XML to text

module Main where

import Data.Semigroup ((<>))
import Data.ByteString.Char8 (ByteString(..), pack, unpack)
import Options.Applicative ( (<**>)
                           , Parser
                           , execParser
                           , fullDesc
                           , info
                           , header
                           , help
                           , helper
                           , long
                           , metavar
                           , progDesc
                           , strOption)
import Playground.Xml (parse')
import System.IO (readFile)
import Xeno.DOM (Node(..), Content(..), contents, parse)

data Options = Options { src :: String }

parser :: Parser Options
parser = Options
      <$> strOption
          ( long "xml"
         <> metavar "SOURCE"
         <> help "XML file to read from"
         )

process' :: Content -> [String]
process' n = case n of
  Element n -> concat $ map process' $ contents n
  Text t -> [unpack t]
  otherwise -> []

main :: IO ()
main = do
  options <- execParser opts
  xml <- readFile $ src options
  putStr $ unlines $ concat $ map process' $ contents $ parse' $ pack xml
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "Convert XML to text via DOM"
     <> header "--HELP!" )
