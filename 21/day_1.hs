----------------------
--
-- Advent of Code - Day 1
-- Sonar Sweep
--
----------------------
import System.IO

main = do
  
  -- 1. Sonar Sweep
  depth <- readFile "day1_1.in"
  print timesDeeper depth -1
  

timesDeeper :: IO String -> Int -> Int
timesDeeper input val1 =
