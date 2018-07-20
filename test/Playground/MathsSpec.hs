module Playground.MathsSpec (spec) where

import Test.Hspec

import Playground.Maths (dot)

spec :: Spec
spec = describe "dot product" $ do
  let a = [1,2,3]; b = [4,5,6]
  it "is an inner product" $ do
    dot a b `shouldBe` 32
