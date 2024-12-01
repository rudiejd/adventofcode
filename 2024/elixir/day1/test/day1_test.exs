defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "does the problem" do
    {:ok, contents} = File.read("./test/day1input")
    numbers = contents
    |> String.split("\n")
    |> Enum.map(&String.split(&1))
    |> Enum.filter(&length(&1) > 1)

    IO.inspect(Day1.day1(numbers))
  end
end
