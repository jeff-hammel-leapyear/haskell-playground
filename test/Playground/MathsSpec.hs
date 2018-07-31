module Playground.MathsSpec (spec_dot) where

import Test.Tasty.Hspec

import Playground.Maths (dot)

spec_dot :: Spec
spec_dot = describe "dot product" $ do
  let a = [1,2,3]; b = [4,5,6]
  it "is an inner product" $ do
    dot a b `shouldBe` 32
