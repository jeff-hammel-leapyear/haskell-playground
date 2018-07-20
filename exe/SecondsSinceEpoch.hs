import Control.Concurrent (threadDelay)
import Data.Time.Clock.POSIX (getPOSIXTime)

main :: IO ()
main = do
  round <$> getPOSIXTime >>= print
  threadDelay 1000000
  main
