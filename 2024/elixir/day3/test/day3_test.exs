defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "does the problem" do
    {:ok, contents} = File.read("./test/day3input")
    scrambled_string = contents
    |> String.trim()

    part1 = Day3.part1(scrambled_string)
    part2 = Day3.part2(scrambled_string)
    IO.inspect(part1)
    IO.inspect(part2)
  end
end
