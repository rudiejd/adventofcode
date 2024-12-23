defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "do the problem" do

    grid = Day6.read_input()
    IO.inspect(Day6.part1(grid))
  end
end
