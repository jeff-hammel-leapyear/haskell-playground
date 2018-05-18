module Playground.Xml ( extractNodes
                      , findElements
                      , flattenNodes
                      , parse'
                      ) where

import Data.ByteString.Char8 (ByteString(..), pack, unpack)
import Xeno.DOM (Node(..), Content(..), children, contents, name, parse)

parse' :: ByteString -> Node
parse' str = case (parse str) of
    Right node -> node
    Left l -> error $ show l

flattenNodes :: Node -> [Node]
flattenNodes node = node : (concat $ map flattenNodes $ children node)

extractNodes :: ByteString -> [Node]
extractNodes = flattenNodes . parse'

findElements :: String -> String -> [Node]
findElements elem xml = filter (\n -> name n == elem' ) $ flattenNodes parsed
  where
    parsed = parse' . pack $ xml
    elem' = pack elem
