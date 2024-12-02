defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "does the problem" do
    {:ok, contents} = File.read("./test/day1input")
    numbers = contents
    |> String.split("\n")
    |> Enum.map(&String.split(&1))
    |> Enum.filter(&length(&1) > 1)

    first_locations =
      numbers
      |> Enum.map(&List.first(&1))
      |> Enum.map(&String.to_integer(&1))

    second_locations =
      numbers
      |> Enum.map(&List.last(&1))
      |> Enum.map(&String.to_integer(&1))

    IO.inspect(Day1.part1(first_locations, second_locations))
    IO.inspect(Day1.part2(first_locations, second_locations))
  end
end
