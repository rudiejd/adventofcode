defmodule Day1 do
  use Day

  def parse_amount(<<action, amount::binary>>) do
    numeric_amount = String.to_integer(amount)

    if <<action>> == "L" do
      -numeric_amount
    else
      numeric_amount
    end
  end

  def turn_lock(lock_value, turn_amount) do
    abs_amount = abs(lock_value + turn_amount)
    cond do
      lock_value + turn_amount < 0 -> 100 - rem(abs_amount, 100)
      lock_value + turn_amount >= 100 -> rem(abs_amount, 100)
      true -> lock_value + turn_amount
    end 
  end

  def turn_lock_count_zero_passes(lock_value, turn_amount, zero_passes) do
    #TODO: find a cleaner solution
    for i <- 1..abs(turn_amount), reduce: {lock_value, zero_passes} do
      {lock_value, zero_passes} -> 
        cur = if turn_amount < 0 do
          lock_value - 1
        else
          rem(lock_value + 1, 100)
        end

        cur = if cur == -1 do
          99
        else
          cur
        end

        zero_passes = if cur == 0 do
          zero_passes + 1
        else
          zero_passes
        end

        {cur, zero_passes}
    end
  end

  def part1(line_list) do
    # the lock starts at 50

    line_list
    |> Enum.reduce({0, 50}, fn command, {past_zero_times, lock_value} ->
      next = turn_lock(lock_value, parse_amount(command))

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
      turn_amount = parse_amount(command)
      {next, zero_passes} = turn_lock_count_zero_passes(lock_value, turn_amount, past_zero_times)
      IO.inspect("#{zero_passes}, #{turn_amount}, #{next}")

      {zero_passes, next}
    end)
    |> elem(0)
  end
end
