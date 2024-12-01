defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Sum the differences between each pair of numbers in two lists
  """
  @spec day1(list(String.t())) :: non_neg_integer()
  def day1(input) when is_list(input) do
    first = input
    |> Enum.map(&List.first(&1))
    |> Enum.map(&Integer.parse(&1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sort()

    second = input
    |> Enum.map(&List.last(&1))
    |> Enum.map(&Integer.parse(&1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sort()

    Enum.zip(first, second)
    |> Enum.map(&abs(elem(&1, 1) - elem(&1, 0)))
    |> Enum.sum()
  end
end
