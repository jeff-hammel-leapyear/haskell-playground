-- Perform Laplacian smoothing

import Playground.Smooth ( Point(..)
                         , line
                         , sample
                         , smoothPointsN
                         , squareWave
                         , toCSV
                         )

main :: IO ()
main = do
    putStr $ toCSV $ smoothPointsN added npasses
    where
      n = 100
      npasses = n `div` 10
      l = line (Point 0.0 0.0) (Point 1.0 1.0) n
      domain = [x | Point x y <- l]
      wave = squareWave 0.1 0.2
      noise = sample wave domain
      added = [Point x1 (y1 + y2) | ((Point x1 y1),(Point x2 y2)) <- zip l noise]
