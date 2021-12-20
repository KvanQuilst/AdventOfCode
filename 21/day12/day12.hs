----------------------
--
-- Advent of Code - Day 12
-- Passage Pathing
--
----------------------
import System.IO
import Data.List
import Data.Char

main = do
  contents <- readFile "day12.in"
  let input = words contents
  putStr "The number of simple paths is "
  print $ numPaths $ map (fillMap input) $ createMap input

  putStr "The number of advanced paths is "
  print $ numPathsAdv $ map (fillMap input) $ createMap input


data Node = Node {name :: String, connections :: [String]} deriving (Eq, Show)
type Pathmap = [Node]


createMap :: [String] -> Pathmap
createMap [] = []
createMap (s:ss) = nub $ Node first [] : (Node last [] : createMap ss)
  where n = words $ map (\c -> if c == '-' then ' ' else c) s
        first = head n
        last = head $ tail n

fillMap :: [String] -> Node -> Node
fillMap [] n = n
fillMap (s:ss) n
  | first == name n = fillMap ss $ Node (name n) $ last : connections n
  | last == name n = fillMap ss $ Node (name n) $ first : connections n
  | otherwise = fillMap ss n
  where p = words $ map (\c -> if c == '-' then ' ' else c) s
        first = head p
        last = head $ tail p


numPaths :: Pathmap -> Int
numPaths p = findPathAdv p [] True $ head $ filter (\n -> name n == "start") p
 
numPathsAdv :: Pathmap -> Int
numPathsAdv p = findPathAdv p [] False $ head $ filter (\n -> name n =="start") p


findPathAdv :: Pathmap -> [String] -> Bool -> Node -> Int
findPathAdv p v b n
  | name n == "end" = 1
  | elem "start" v && name n == "start" = 0
  | (not b) && isLower char = if elem (name n) v
                              then sum $ map (findPathAdv p v True) connect
                              else sum $ map (findPathAdv p (name n : v) b) connect
  | b && isLower char = if elem (name n) v
                        then 0
                        else sum $ map (findPathAdv p (name n : v) b) connect
  | otherwise = sum $ map (findPathAdv p v b) connect
  where connect = filter (\c -> elem (name c) (connections n)) p
        char = head $ name n
