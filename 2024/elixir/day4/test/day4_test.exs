defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "do the problem" do
    contents = File.read!('./test/day4input')
    rows = contents
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.reject(&length(&1) < 1)

    IO.inspect(Day4.word_search(rows))
  end

end
