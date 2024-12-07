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

@dirs [{0, 1}, {1, 0}, {1, 1}, {0, -1}, {-1, 0}, {-1, -1}, {1, -1}, {-1, 1}]

def at(grid, pos) do
  Map.get(grid, pos)
end

def go({x, y}, {x1, y1}) do
  {x + x1, y + y1}
end

defp word_match?(grid, _pos, _dir, [], path) do
:true
end

defp word_match?(grid, pos, dir, [first_char|rest], path \\ []) do
  case at(grid, pos) do
     ^first_char -> 
        word_match?(grid, go(pos, dir), dir, rest, path ++ [pos])
     _ -> :false
  end
end

@doc """

  Check the number of times "XMAS" occurs in a word search
"""
# reduce the grid, try moving in every direction, check if the match exists
def word_search(grid) do
  Enum.reduce(grid, 0, fn {pos, _}, cnt ->
    @dirs
    |> Enum.reduce(cnt, fn dir, cnt ->
      case word_match?(grid, pos, dir, ~c'XMAS') do
         true -> cnt + 1
         false -> cnt
      end
    end)
  end)
end

end
