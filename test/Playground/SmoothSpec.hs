module Playground.SmoothSpec (spec) where

import Test.Hspec

import Playground.Smooth (smooth)

spec :: Spec
spec = describe "Laplacian smoothing" $ do
    let rough = [0.0, 2.0, 0.0, 2.0, 0.0]; smoothed = [0.0, 1.0, 1.0, 1.0, 0.0]
    it "smooths" $ do
      smooth rough `shouldBe` smoothed
    it "returns data of the same length" $ do
      length ( smooth rough ) `shouldBe` length smoothed
