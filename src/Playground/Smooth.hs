-- | Module for performing Laplace (1:2:1) smoothing.
module Playground.Smooth
  ( Point(..)
  , line
  , sample
  , smooth
  , smoothPoints
  , smoothPointsN
  , squareWave
  , toCSV
  ) where


-- 2D coordinate
data Point = Point Float Float

instance Show Point where
  show (Point x y) = show x ++ (',' : show y)

-- | Create a discretized line segment.
line :: Point -> Point -> Int -> [Point]
line (Point x1 y1) (Point x2 y2) n = [Point (x1 + dx*i) (y1 + dy*i) | i <- map fromIntegral [0..n-1] ]
  where
    dx = (x2 - x1)/ dn
    dy = (y2 - y1)/ dn
    dn = fromIntegral $ n - 1

squareWave :: Float -> Float -> Float -> Float
squareWave a period x = if high then a else negate a
  where
    k =  x / period
    high = ((-) k $ fromIntegral $ floor k) > 0.5

sample :: (Float -> Float) -> [Float] -> [Point]
sample f x = [Point x' y | (x', y) <- zip x (map f x)]

toCSV :: [Point] -> String
toCSV l = unlines [ show p | p <- l]

abscissa :: [Point] -> [Float]
abscissa p = [x | (Point x _) <- p]

-- | Returns y coordinates
ordinate :: [Point] -> [Float]
ordinate p = [y | (Point _ y) <- p]

-- | zip a list with its tail, making a list one shorter
pass :: [a] -> [(a,a)]
pass i = zip i' $ tail i'
  where
    i' = init i

-- | Laplacian (1:2:1) smoothing leaving the endpoints fixed
smooth :: [Float] -> [Float]
smooth y = (head y) : ([ 0.25*(y1 + y2 + y3 + y4)
                            | ((y1, y2), (y3, y4)) <- zip ( pass y ) (reverse $ pass $ reverse y)]
                            ++ [last y])

applyY :: [Point] -> ([Float] -> [Float]) -> [Point]
applyY p f = [Point x y | (x, y) <- zip x $ f y]
  where
    x = abscissa p
    y = ordinate p

smoothPoints :: [Point] -> [Point]
smoothPoints p = applyY p smooth

smoothPointsN :: [Point] -> Int -> [Point]
smoothPointsN p n
  | n == 0    = p
  | otherwise = smoothPointsN (smoothPoints p) (n-1)


(+^) :: Num a => [a] -> [a] -> [a]
(+^) = zipWith (+)
infixl 6 +^

(*^) :: Num a => a -> [a] -> [a]
(*^) = map . (*)
infix 7 *^
