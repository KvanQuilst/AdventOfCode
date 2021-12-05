----------------------
--
-- Advent of Code - Day 5
-- Hydrothermal Venture
--
----------------------
import System.IO
import Data.List

main :: IO ()
main = do
  contents <- readFile "day5.in"
  print $ ends $ lines contents


ends :: [String] -> [((Int, Int), (Int, Int))]
ends [] = []
ends (s:xs) = ((read (head v), read (v !! 1)), (read (v !! 3), read (v !! 4))) : ends xs
  where v = words $ map (\c -> if c == ',' then ' ' else c) $ s
