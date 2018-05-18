{-# LANGUAGE RecordWildCards #-}

-- | optparse-applicative sample
-- Ref:
-- - https://ocharles.org.uk/blog/posts/2012-12-17-24-days-of-hackage-optparse-applicative.html
-- - https://github.com/pcapriotti/optparse-applicative#arguments

import Options.Applicative
import Data.Semigroup ((<>))

data Sample = Sample
  { hello      :: String
  , quiet      :: Bool
  , enthusiasm :: Int }

sample :: Parser Sample
sample = Sample
      <$> argument str
          ( metavar "TARGET"
         <> help "Target for the greeting" )
      <*> switch
          ( long "quiet"
         <> short 'q'
         <> help "Whether to be quiet" )
      <*> option auto
          ( long "enthusiasm"
         <> help "How enthusiastically to greet"
         <> showDefault
         <> value 1
         <> metavar "INT" )

main :: IO ()
main = do
  Sample {..} <- execParser opts
  putStrLn hello
  where
    opts = info (sample <**> helper)
      ( fullDesc
     <> progDesc "optparse-applicative sample"
     <> header "You asked for --help" )
