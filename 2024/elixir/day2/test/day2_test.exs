defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "does the problem" do
    {:ok, contents} = File.read("./test/day2example")
    level_lists = contents
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(
      &String.trim(&1) 
      |> String.split(" ") 
      |> Enum.map(fn s -> String.to_integer(s) end)
      )

    res = Enum.reduce(level_lists, 0, fn lst, acc -> 
      if elem(Day2.is_report_safe?(lst), 0) == :true, do: acc + 1, else: acc
    end)
    IO.inspect(res)

    part2answer = Enum.reduce(level_lists, 0, fn lst, acc -> 
      if elem(Day2.is_report_safe?(lst), 1) == :true, do: acc + 1, else: acc
    end)
    IO.inspect(part2answer)
  end
end
