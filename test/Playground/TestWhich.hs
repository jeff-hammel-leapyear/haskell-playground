module Playground.TestWhich (unit_which) where

import Test.Tasty.HUnit

import Playground.Path (which)

-- `bash` *should* probably be at `/bin/bash`
-- If not, pull requests welcome :)
unit_which :: IO ()
unit_which = do
  bash <- which "bash"
  assertEqual "bash should be /bin/bash on POSIX (probably)" bash (Just "/bin/bash")
