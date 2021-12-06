----------------------
--
-- Advent of Code - Day 5
-- Lanternfish
--
----------------------
import System.IO
import Data.List
import qualified Data.ByteString as B

main = do
  contents <- readFile "day6_test.in"

  let fish = map read $ words $ map (\c -> if c == ',' then ' ' else c) $ contents :: [Int]
  print $ sum $ map (gen 80) fish
  --print $ gen 5 14

gen :: Int -> Int -> Int
gen d c 
  | s <= 0 = 0
  | otherwise = t + (sum $ map (gen 8) [s - (x * 7) | x <- [0..(t-1)]])
  where t = (div s c) + (if (mod s 7) == 0 then 0 else 1)
        s = d - c - 1
