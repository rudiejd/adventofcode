defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "do the problem" do
    contents = File.read!('./test/day4input')

    # I stole this
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

    IO.inspect(Day4.word_search(map))
    IO.inspect(Day4.x_search(map))

    
  end

end
