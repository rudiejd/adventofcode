defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "do the problem" do

    contents = File.read!('./test/day6input')

    # I stole this from the other problem!
    map = contents
    |> String.split("\n")
    |> Enum.with_index
    |> Enum.flat_map(fn {line, row} ->
      String.to_charlist(line)
      |> Enum.with_index
      |> Enum.flat_map(fn {char, col} ->
        position = {row, col}
        [{position, char}]
      end)
    end)
    |> Map.new
  end
end
