-- | Credit goes to David Thomas for this one.

{-# LANGUAGE MagicHash #-}

import GHC.Prim (reallyUnsafePtrEquality#)

all' f = and' . map f

and' lead@(x:lag) = x && go lead lag
  where
    go :: [Bool] -> [Bool] -> Bool
    go [] _ = True
    go [True] _ = True
    go (True:True:lead) (_:lag) =
      case reallyUnsafePtrEquality# lead lag of
        0# -> go lead lag
        1# -> True  -- cycle detected
    go _ _ = False
