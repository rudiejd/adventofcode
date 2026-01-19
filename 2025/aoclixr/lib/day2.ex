defmodule Day2 do
  use Day

  def parse_range(str) do
    [{low, _}, {high, _}] =
      str
      |> String.split("-")
      |> Enum.map(&Integer.parse/1)

    {low, high}
  end

  def do_is_repeat?(_num, 1) do
    false
  end

  def do_is_repeat?(num, digit_count) do
    if rem(digit_count, 2) == 0 do
      div(num, 10 ** div(digit_count, 2)) == rem(num, 10 ** div(digit_count, 2))
    else
      false
    end
  end

  def is_repeat?(num) do
    digit_count =
      num
      |> :math.log10()
      |> :math.ceil()
      |> Kernel.trunc()

    do_is_repeat?(num, digit_count)
  end

  def find_repeats({low, high}, count \\ 0) do
    cond do
      low == high ->
        if is_repeat?(low) do
          count + low
        else
          count
        end

      is_repeat?(low) ->
        find_repeats({low + 1, high}, count + low)

      true ->
        find_repeats({low + 1, high}, count)
    end
  end

  def do_is_repeat?(_num, 1) do
    false
  end

  def do_is_repeat?(num, digit_count) do
    if rem(digit_count, 2) == 0 do
      div(num, 10 ** div(digit_count, 2)) == rem(num, 10 ** div(digit_count, 2))
    else
      false
    end
  end


  def is_repeat_part2?(num) when num < 100 do
    rem(num, 10) == div(num, 10)
  end

  def is_repeat_part2?(num) do
    str = Kernel.inspect(num)
    {[first], rest} = str
      |> String.graphemes()
      |> Enum.split(1)

    # next time the first character occurs
    next = Enum.find_index(rest, fn c -> c == first end)

    dbg()
    if is_nil(next) do
      false
    else
      seq_size = next + 1
      String.slice(num, 0..seq_size) == String.slice(num, (next + 1)..seq_size)
    end
  end

  def find_repeats_part2({low, high}, count \\ 0) do
    cond do
      low == high ->
        if is_repeat_part2?(low) do
          count + low
        else
          count
        end

      is_repeat_part2?(low) ->
        find_repeats({low + 1, high}, count + low)

      true ->
        find_repeats_part2({low + 1, high}, count)
    end
  end

  def part1([line]) do
    line
    |> String.split(",")
    |> Enum.map(&parse_range/1)
    |> Enum.map(&find_repeats/1)
    |> Enum.sum()
  end

  def part2([line]) do
    line
    |> String.split(",")
    |> Enum.map(&parse_range/1)
    |> Enum.map(&find_repeats_part2/1)
    |> Enum.sum()
  end
end
