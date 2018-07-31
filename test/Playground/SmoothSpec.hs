module Playground.SmoothSpec (spec_smooth) where

import Test.Tasty.Hspec

import Playground.Smooth (smooth)

spec_smooth :: Spec
spec_smooth = describe "Laplacian smoothing" $ do
    let rough = [0.0, 2.0, 0.0, 2.0, 0.0]; smoothed = [0.0, 1.0, 1.0, 1.0, 0.0]
    it "smooths" $ do
      smooth rough `shouldBe` smoothed
    it "returns data of the same length" $ do
      length ( smooth rough ) `shouldBe` length smoothed
