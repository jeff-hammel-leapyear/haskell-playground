{-# LANGUAGE OverloadedStrings #-}

module Playground.Postgresql where

import Network.URI (parseURI)
-- https://lotz84.github.io/haskellbyexample/ex/url-parsing
-- http://hackage.haskell.org/package/network-uri

-- uriToConnectionString :: String -> Maybe String
-- uriToConnectionString s = case parseURI s of
--   Nothing -> Nothing
--   Just uri -> "TODO"
