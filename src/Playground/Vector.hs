module Playground.Vector

class Vector v where
  (+^) :: v -> v -> v
  infixl 6 +^
  (*^) :: Float -> v -> v
  infix 7 *^

