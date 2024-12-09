defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  def out_of_order(update, rules) do
      Enum.with_index(update)
      |> Enum.any?(fn {val, idx} -> 
        Enum.slice(update, 0, idx)
        |> Enum.any?(&rules[val] && MapSet.member?(rules[val], &1))
        end)
  end

  def part1(rules, updates) do
    updates
    |> Enum.reduce(0, fn update, acc -> 
      case out_of_order(update, rules) do
        true -> acc
        false -> acc + Enum.at(update, div(length(update), 2))
      end
    end)
  end

  def goes_before(a, b, rules) do
      rules_a = Map.get(rules, a)
      rules_a != nil && MapSet.member?(rules_a, b)
  end

  def reorder(update, rules) do
    Enum.sort(update, fn a, b -> 
      goes_before(a, b, rules)
    end)
  end

  def part2(rules, updates) do
    updates
    |> Enum.reduce(0, fn update, acc -> 
      case out_of_order(update, rules) do
        true -> 
        acc + Enum.at(reorder(update, rules), div(length(update), 2))
        _ -> acc 
      end
    end)
  end


  def read_input() do
    [raw_rules, raw_updates] = File.read!('./test/day5input')
    |> String.split("\n\n", parts: 2)

    rules = raw_rules
    |> String.split("\n")
    |> Enum.reduce(%{}, fn val, map -> 
      parts = val
      |> String.split("|")
      [left, right] = parts

      left_num = String.to_integer(left)
      right_num = String.to_integer(right)
      case Map.get(map, left_num) do
        %MapSet{} = set -> Map.put(map, left_num, MapSet.put(set, right_num))
        nil -> Map.put(map, left_num, MapSet.new([right_num]))
      end
    end)
    |> Map.new

    updates = raw_updates
    |> String.split("\n")
    |> Enum.reject(&String.length(&1) <= 0)
    |> Enum.map(fn rules -> 
      String.split(rules, ",") 
      |> Enum.map(&String.to_integer/1)
    end)

    {rules, updates}
  end
end
