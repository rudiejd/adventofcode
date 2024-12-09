defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "do the problem" do

    {rules, updates} = Day5.read_input()
    Day5.part1(rules, updates) |> IO.inspect()
    Day5.part2(rules, updates) |> IO.inspect()
  end
end
