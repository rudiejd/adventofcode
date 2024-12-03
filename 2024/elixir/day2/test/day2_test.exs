defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "does the problem" do
    {:ok, contents} = File.read("./test/day2input")
    level_lists = contents
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(
      &String.trim(&1) 
      |> String.split(" ") 
      |> Enum.map(fn s -> String.to_integer(s) end)
      )

    part1 = Enum.count(level_lists, &Day2.is_report_safe?(&1))
    IO.inspect(part1)

    part2 = Enum.count(level_lists, &Day2.is_report_nearly_safe?(&1))
    IO.inspect(part2)
  end
end
