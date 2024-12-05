defmodule Day4 do
@moduledoc """
 "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

 As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

 This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:


 ..X...
 .SAMX.
 .A..A.
 XMAS.S
 .X....
 The actual word search will be full of letters instead. For example:

 MMMSXXMASM
 MSAMXMSMSA
 AMXSXMAAMM
 MSAMASMSMX
 XMASAMXAMM
 XXAMMXXAMA
 SMSMSASXSS
 SAXAMASAAA
 MAMMMXMMMM
 MXMXAXMASX
 In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

 ....XXMAS.
 .SAMXMS...
 ...S..A...
 ..A.A.MS.X
 XMASAMX.MM
 X.....XA.A
 S.S.S.S.SS
 .A.A.A.A.A
 ..M.M.M.MM
 .X.X.XMASX
 Take a look at the little Elf's word search. How many times does XMAS appear?
"""

<<<<<<< HEAD
@dirs [{0, 1}, {1, 0}, {1, 1}, {0, -1}, {-1, 0}, {-1, -1}, {1, -1}, {-1, 1}]

# TODO turn this into a map
@spec at(list(list(String.t())), Position.t()) :: non_neg_integer()
def at(grid, {x, y}) do
  if length(grid) <= y or length(grid) <= x do
    nil
  else 
    Enum.at(grid, y) |> Enum.at(x)
  end
end

def go({x, y}, {x1, y1}) do
  {x + x1, y + y1}
end

defp do_word_search(grid, pos, []), do: 1 |> dbg()
defp do_word_search(grid, pos, [first_char|rest]) do
  case at(grid, pos) do
     ^first_char -> 
      Enum.reduce(@dirs, 0, fn d, acc -> 
        acc + do_word_search(grid, go(pos, d), rest) end)
     _ -> 0
  end
  
end

@doc """

  Check the number of times "XMAS" occurs in a word search
"""
# reduce the grid, try moving in every direction, check if the match exists
@spec word_search(list(list(String.t()))) :: non_neg_integer()
def word_search(grid) do
  Enum.reduce(0..length(grid), 0, fn y, acc ->
    acc + Enum.reduce(0..length(grid), 0, fn x, a -> 
      a + do_word_search(grid, {x, y}, ~c'XMAS')
    end)
  end)
end

end
