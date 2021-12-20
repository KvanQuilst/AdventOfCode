----------------------
--
-- Advent of Code - Day 17
-- Trick Shot
--
----------------------
import System.IO
import Data.List
import Data.Word
import qualified Data.ByteString as B

main = do
  contents <- readFile "day17.in"
  print $ maxHeight $ target contents


type Target = ([Int], [Int])
type Velocity = (Int, Int)


target :: String -> Target
target s = 
  let split = words s
      space = map (\c -> if c == '.' || c == ',' then ' ' else c)
      x     = map read $ words $ space $ drop 2 $ split !! 2
      y     = map read $ words $ space $ drop 2 $ split !! 3
  in ([(head x)..(head $ tail x)], [(head y)..(head $ tail y)])


maxHeight :: Target -> Int
maxHeight t = 
  let ys    = abs $ maximum $ snd t
      l     = filter (/=(-1)) $ map (maxHeight' t 0) [1..(10 * ys)]
  in maxY 0 $ length l 
      
maxHeight' :: Target -> Int -> Int -> Int
maxHeight' t y v
  | elem y yr = 1
  | y < (maximum yr) = -1
  | otherwise = maxHeight' t (y+v) (v-1)
  where yr = snd t

maxY :: Int -> Int -> Int
maxY y v
  | v == 0 = y
  | otherwise = maxY (y+v) (v-1)
