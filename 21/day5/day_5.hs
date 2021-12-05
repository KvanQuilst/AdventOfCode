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
  print $ uniq $ normal $ ends $ lines contents

ends :: [String] -> [((Int, Int), (Int, Int))]
ends [] = []
ends (s:xs) = ((read $ head v, read $ v !! 1), (read $ v !! 3, read $ v !! 4)) : ends xs
  where v = words $ map (\c -> if c == ',' then ' ' else c) $ s

normal :: [((Int, Int), (Int, Int))] -> [(Int, Int)]
normal [] = []
normal (p:ps) 
  | x1 == x2 = if y1<y2 then zip (repeat x1) [y1..y2] ++ normal ps
    else zip (repeat x1) [y2..y1] ++ normal ps
  | y1 == y2 = if x1<x2 then zip [x1..x2] (repeat y1) ++ normal ps
    else zip [x2..x1] (repeat y1) ++ normal ps
  | otherwise = normal ps
  where x1 = fst $ fst p
        x2 = fst $ snd p
        y1 = snd $ fst p
        y2 = snd $ snd p

uniq :: [(Int, Int)] -> Int
uniq [] = 0
uniq (p:ps)
  | any (==p) ps = 1 + (uniq $ filter (/=p) ps)
  | otherwise = uniq ps
