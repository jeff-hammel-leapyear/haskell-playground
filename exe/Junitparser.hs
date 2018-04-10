-- | parse Junit and do something with it, I suppose

module Main where

import Data.Semigroup ((<>))
import Options.Applicative
import Text.XML.HXT.Core
import Text.XML.HXT.Curl

data Options = Options
  { src :: String
  , dst :: String }

-- TODO: https://github.com/pcapriotti/optparse-applicative#arguments
parser :: Parser Options
parser = Options
      <$> strOption
          ( long "src"
         <> metavar "SOURCE"
         <> help "location of XML source" )
      <*> strOption
          ( long "dest"
         <> metavar "DESTINATION"
         <> help "where to write XML output to " )

copyXML :: String -> String -> IO [XmlTree]
copyXML src dst = runX $
    readDocument [withValidate no
                 ,withCurl []
                 ] src
    >>>
    writeDocument [withIndent yes
                  ,withOutputEncoding isoLatin1
                  ] dst

main :: IO ()
main = do
  options <- execParser opts
  copyXML (src options) (dst options)
  return ()
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "Copy some exicting XML"
     <> header "Do some things with Junit XML" )
