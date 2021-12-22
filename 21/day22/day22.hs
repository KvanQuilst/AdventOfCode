----------------------
--
-- Advent of Code - Day 22
-- Reactor Reboot
--
----------------------
import System.IO
import Data.List
import Data.Char

main = do
  contents <- readFile "day22_test.in"
  print $ length $ part1 [] $ lines contents


type Cuboid = (Int, Int, Int)


part1 :: [Cuboid] -> [String] -> [Cuboid]
part1 q [] = q
part1 q (s:ss) = 
  let nums = map read $ words $ map (\d -> if not $ repl d then ' ' else d) s
      onoff = (take 2 s) == "on"
      xl = [(if nums !! 0 >= -50 then nums !! 0 else -50)..
            (if nums !! 1 <= 50 then nums !! 1 else 50)]
      yl = [(if nums !! 2 >= -50 then nums !! 2 else -50)..
            (if nums !! 3 <= 50 then nums !! 3 else 50)]
      zl = [(if nums !! 4 >= -50 then nums !! 4 else -50)..
            (if nums !! 5 <= 50 then nums !! 5 else 50)]
      repl c = isDigit c || c == '-'
      cuboids = [(x, y, z) | x <- xl, y <- yl, z <- zl]
      a = nub $ cuboids ++ q
      r = filter (\x -> notElem x cuboids) q
  in part1 (if onoff then a else r) ss
