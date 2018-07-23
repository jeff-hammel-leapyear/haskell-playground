module Playground.ProcessSpec (spec) where

import Test.Hspec

import Playground.Process (retryProcess)

spec :: Spec
spec = describe "process" $ do
  let command = "exit $(( RANDOM % 7 ))"
  it "should exit after several retries" $ do
    1 `shoudlBe` 1
