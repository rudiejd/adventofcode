defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  @tag timeout: :infinity
  test "do the problem" do
    {grid, len} = Day6.read_input()
    IO.inspect(Day6.part1(grid))
    IO.inspect(Day6.part2(grid, len))
  end
end
