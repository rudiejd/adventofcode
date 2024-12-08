defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "do the problem" do
    [raw_rules, raw_updates] = File.read!('./test/day5input')
    |> String.split("\n\n", parts: 2)

    rules = raw_rules
    |> String.split("\n")
    |> Enum.flat_map(fn val -> 
      parts = val
      |> String.split("|")
      [left, right] = parts
      [{String.to_integer(left), String.to_integer(right)}]
    end)

  end
end
