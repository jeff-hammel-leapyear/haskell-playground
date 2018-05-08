{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

-- | Convert XML to text via SAX

module Main where

import Control.Monad.State.Strict (evalStateT)
import qualified Data.ByteString as BS
import Data.ByteString.Char8 (unpack, pack)
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
import System.IO (readFile)
import Xeno.SAX (process)

data Options = Options { src :: String }

parser :: Parser Options
parser = Options
      <$> strOption
          ( long "xml"
         <> metavar "SOURCE"
         <> help "XML file to read from"
         )

dumpText :: ByteString -> IO ()
dumpText =
  process
      (\_ -> pure ()) -- Open tag
      (\_ _ -> pure ()) -- Tag attribute
      (\_ -> pure ()) -- End open tag
      (\text -> BS.putStr text) -- Text
      (\_ -> pure ()) -- Close tag
      (\_ -> pure ()) -- CDATA

main :: IO ()
main = do
  Options {..} <- execParser opts
  xml <- BS.readFile $ src
  dumpText xml
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "Convert XML to text via SAX"
     <> header "You asked for --help" )
