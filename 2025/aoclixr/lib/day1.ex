defmodule Day1 do
  use Day

  def turn_lock(<<action, amount::binary>>) do
    numeric_amount = String.to_integer(amount)

    if <<action>> == "L" do
      -numeric_amount
    else
      numeric_amount
    end
  end

  def part1(line_list) do
    # the lock starts at 50

    line_list
    |> Enum.reduce({0, 50}, fn command, {past_zero_times, lock_value} ->
      next = rem(lock_value + turn_lock(command), 100)

      if next == 0 do
        {past_zero_times + 1, next}
      else
        {past_zero_times, next}
      end
    end)
    |> elem(0)
  end

  def part2(line_list) do
    # the lock starts at 50
    line_list
    |> Enum.reduce({0, 50}, fn command, {past_zero_times, lock_value} ->
      turn_amount = turn_lock(command)
      next = rem(lock_value + turn_amount, 100)

      if next == 0 do
        {rem(next, 100) + 1 + past_zero_times, next}
      else
        {rem(next, 100) + past_zero_times, next}
      end
    end)
    |> elem(0)
  end
end
