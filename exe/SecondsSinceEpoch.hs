-- | The world's most pointless clock.

{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (threadDelay)
import Data.String (fromString)
import Data.Time.Clock.POSIX (getPOSIXTime)
import System.Remote.Gauge (Gauge(..), set)
import System.Remote.Monitoring (forkServer, getGauge)


loop :: Gauge -> IO ()
loop g = do
  t <-round <$> getPOSIXTime
  print t
  set g t
  threadDelay 1000000
  loop g


main :: IO ()
main = do
  handle <- forkServer "localhost" 8000
  gauge <- getGauge (fromString "SecondsSinceEpoch") handle
  loop gauge
