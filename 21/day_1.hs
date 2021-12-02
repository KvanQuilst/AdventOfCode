----------------------
--
-- Advent of Code - Day 1
-- Sonar Sweep
--
----------------------
import System.IO

main :: IO ()
main = do
  input <- openFile "day1_1.hs" ReadMode
  timesDeeper' input (-1) 
  hClose input

timesDeeper' :: Handle -> Int -> Int
timesDeeper' _ 0 = 0
timesDeeper' input y
  | y == -1 = timesDeeper' input x
  | otherwise = maxBin x y + timesDeeper' input x
  where x = getInt input

getInt :: Handle -> Int
getInt input = do
  hGetLine input
  num <- read line
  return num

timesDeeper :: [Int] -> Int -> Int
timesDeeper [] _ = error "list cannot be empty"
timesDeeper [x] y = maxBin x y
timesDeeper (x:xs) y
  | y == -1 = timesDeeper xs x
  | otherwise =  maxBin x y + timesDeeper xs x

maxBin :: Int -> Int -> Int
maxBin x y
  | x >= y = 0
  | y < x = 1
