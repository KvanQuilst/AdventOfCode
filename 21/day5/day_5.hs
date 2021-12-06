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
  let endpoints = ends $ lines contents
  print $ uniq $ normal endpoints ++ diag endpoints

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

diag :: [((Int, Int), (Int, Int))] -> [(Int, Int)]
diag [] = []
diag (p:ps)
  | abs (x2-x1) == abs (y2-y1) = (diag' x1 x2 y1 y2) ++ diag ps
  | otherwise = diag ps
  where x1 = fst $ fst p
        x2 = fst $ snd p
        y1 = snd $ fst p
        y2 = snd $ snd p

diag' :: Int -> Int -> Int -> Int -> [(Int, Int)]
diag' w x y z
  | (w < x) && (y < z) = zip [w..x] [y..z]
  | (w < x) && (y > z) = zip [w..x] (reverse [z..y])
  | (w > x) && (y < z) = zip (reverse [x..w]) [y..z]
  | (w > x) && (y > z) = zip (reverse [x..w]) (reverse [z..y])
  | otherwise = []


uniq :: [(Int, Int)] -> Int
uniq [] = 0
uniq (p:ps)
  | any (==p) ps = 1 + (uniq $ filter (/=p) ps)
  | otherwise = uniq ps
