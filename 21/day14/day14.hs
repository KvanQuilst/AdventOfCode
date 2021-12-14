----------------------
--
-- Advent of Code - Day 13
-- Transparent Origami
--
----------------------
import System.IO
import Data.List
import Data.Word
import qualified Data.ByteString as B

main = do
  contents <- readFile "day14.in"
  let template = head $ lines contents
      rules = insertions contents
      final = steps 40 template rules
  print $ [(x, length $ filter (==x) final) | x <- ['A'..'Z']]


type Template = String
type PairRules = [(String, Char)]


insertions :: String -> PairRules
insertions s = 
  let split = tail $ dropWhile (/= "") $ lines s
      pairs = [words $ map (\c -> if c == '-' || c == '>' then ' ' else c) p | p <- split]
  in [(head p, head $ head $ tail p) | p <- pairs]


steps :: Int -> Template -> PairRules -> Template
steps 0 t _ = t
steps s t p = steps (s-1) (steps' t p) p

steps' :: Template -> PairRules -> Template
steps' (a:[]) _ = a : []
steps' (a:b:bs) p =
  let index = head $ findIndices (==[a,b]) $ map fst p
  in a : (snd $ p !! index) : (steps' (b:bs) p)
