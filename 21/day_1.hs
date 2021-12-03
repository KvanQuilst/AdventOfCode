----------------------
--
-- Advent of Code - Day 1
-- Sonar Sweep
--
----------------------
import System.IO
import Data.List

main :: IO ()
main = do
  contents <- readFile "day1_1.in"

  let nums = map read $ lines contents
  putStr "The number of depth increases is "
  print $ timesDeeper nums (-1)

timesDeeper :: [Int] -> Int -> Int
--timesDeeper :: [IO a] -> a -> a
timesDeeper [] _ = error "list cannot be empty"
timesDeeper [x] y = maxBin x y
timesDeeper (x:xs) y
  | y == -1 = timesDeeper xs x
  | otherwise =  maxBin x y + timesDeeper xs x

maxBin :: Int -> Int -> Int
maxBin x y
  | x >= y = 1
  | otherwise = 0
