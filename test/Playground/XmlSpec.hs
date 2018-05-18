{-# LANGUAGE QuasiQuotes #-}

module Playground.XmlSpec (spec) where

import Control.Exception (throw)
import Data.ByteString.Char8 (pack, unpack)
import Data.Either (fromRight)
import Playground.Xml (findElements)
import Test.Hspec
import Text.RawString.QQ
import qualified Data.Map as Map
import qualified Xeno.SAX as SAX
import qualified Xeno.DOM as DOM

data Person = Person { name :: String,
                       age :: Int,
                       height :: Float } deriving (Eq, Show)

xml = [r|<foo>
<bar nm="Bob" yo="32" size="1.8"></bar>
<bar nm="Alice" yo="28" size="1.4"><child name="Nikki"></child></bar>
</foo>
|]

foldAttrs :: String -> [(String, String)]
foldAttrs xml = reverse $ either (error . show) id ( SAX.fold
  const -- open
  (\s k v -> (unpack k, unpack v) : s)
  const -- end open
  const -- text
  const -- close
  const -- CDATA
  []
  (pack xml)
  )

updateFromAttrs :: Person -> String -> String -> Person
updateFromAttrs person key value
  | key == "nm" = person { name = value }
  | key == "yo" = person { age = read value :: Int }
  | key == "size" = person { height = read value :: Float }
  | otherwise = person  -- ignore other attributes


spec :: Spec
spec = describe "Parsing XML" $ do

  it "should be able to steal attributes" $ do
    foldAttrs xml `shouldBe` [("nm", "Bob"),
                              ("yo", "32"),
                              ("size", "1.8"),
                              ("nm", "Alice"),
                              ("yo", "28"),
                              ("size", "1.4"),
                              ("name", "Nikki")]

  it "should be able to make a person" $ do
    let bob = Person { name = "", age = 0, height = 0.0 }
    let attrs = [("yo", "71"), ("nm", "Bob"), ("size", "6.0")]
    foldr (\x p -> updateFromAttrs p (fst x) (snd x)) bob attrs `shouldBe` Person { name = "Bob", age = 71, height = 6.0 }

  it "should be able to find 'foo' nodes" $ do
    (length $ findElements "bar" xml) `shouldBe` 2

