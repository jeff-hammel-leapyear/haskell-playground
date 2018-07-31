module Playground.SquarewaveSpec (spec_squarewave) where

import Test.Tasty.Hspec

import Playground.Smooth (squareWave)

spec_squarewave :: Spec
spec_squarewave = describe "a square wave" $ do
    it "is a wave" $ do
      (map s $ take 10 x) `shouldBe` (take 10 $ concat $ repeat [negate amplitude, amplitude])
      where
        amplitude = 2.0
        period = 1.0
        s = squareWave amplitude period
        x = [0.25*period,0.75*period..]
