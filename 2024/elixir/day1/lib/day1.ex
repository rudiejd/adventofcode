defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Sum the differences between each pair of numbers in two lists
  """
  @spec part1(list(non_neg_integer()), list(non_neg_integer())) :: non_neg_integer()
  def part1(first_locations, second_locations) when is_list(first_locations) and is_list(second_locations) do
    first =
      first_locations
      |> Enum.sort()

    second =
      second_locations
      |> Enum.sort()

    Enum.zip(first, second)
    |> Enum.map(&abs(elem(&1, 1) - elem(&1, 0)))
    |> Enum.sum()
  end



  @spec part2(list(non_neg_integer()), list(non_neg_integer())) :: non_neg_integer()
  def part2(first_locations, second_locations) when is_list(first_locations) and is_list(second_locations) do
    first_frequences =
      first_locations
      |> Enum.reduce(%{}, &Map.put(&2, &1, Map.get(&2, &1, 0) + 1))

    second_frequencies =
      second_locations
      |> Enum.reduce(%{}, &Map.put(&2, &1, Map.get(&2, &1, 0) + 1))

    first_frequences
    |> Map.keys()
    |> Enum.map(&(Map.get(second_frequencies, &1, 0) * &1))
    |> Enum.sum()
  end
end
