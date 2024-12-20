defmodule Day2 do
  @moduledoc """
  Day 2 for advent of code! 
  6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9

This example data contains six reports each containing five levels.

The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

    The levels are either all increasing or all decreasing.
    Any two adjacent levels differ by at least one and at most three.

In the example above, the reports can be found safe or unsafe by checking those rules:

    7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
    1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
    9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
    1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
    8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
    1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.

So, in this example, 2 reports are safe.

Analyze the unusual data from the engineers. How many reports are safe?
--- Part Two ---

The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener.

The Problem Dampener is a reactor-mounted module that lets the reactor safety systems tolerate a single bad level in what would otherwise be a safe report. It's like the bad level never happened!

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

    7 6 4 2 1: Safe without removing any level.
    1 2 7 8 9: Unsafe regardless of which level is removed.
    9 7 6 2 1: Unsafe regardless of which level is removed.
    1 3 2 4 5: Safe by removing the second level, 3.
    8 6 4 4 1: Safe by removing the third level, 4.
    1 3 6 7 9: Safe without removing any level.

Thanks to the Problem Dampener, 4 reports are actually safe!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?
  """

  @doc """
  Check whether a level is safe, i.e. monotonic and all successive numbers have a
  difference of at least one and at most 3.

  ## Examples

      iex> Day2.is_report_safe?([7, 6, 4, 2, 1])
      true

      iex> Day2.is_report_safe?([8, 1, 7, 6, 5, 4])

      iex> Day2.is_report_safe?([1, 9, 8, 7, 6, 5])
      false

      iex> Day2.is_report_safe?([9, 2, 8, 7, 6, 5])
      false

      iex> Day2.is_report_safe?([9, 8, 7, 6, 5, 10])
      false

      iex> Day2.is_report_safe?([9, 90, 7, 6, 5, 4])
      false

      iex> Day2.is_report_safe?([72, 69, 67, 65, 63, 62])
      false
  """
  @spec is_report_safe?(list(String.t())) :: boolean()
  def is_report_safe?(report) when is_list(report) do
    res = Enum.reduce(report, %{ascending: nil, last: nil, valid: true}, fn level, acc ->
      currently_ascending = if acc[:last] == nil, do: nil, else: level > acc[:last]
      monotonic? = acc[:ascending] == nil or currently_ascending == acc[:ascending]
      difference_valid? = acc[:last] == nil or (abs(level - acc[:last]) >= 1 and abs(level - acc[:last]) <= 3)

      valid? = monotonic? and difference_valid?
      new_ascending = if not valid?, do: acc[:ascending], else: currently_ascending 
      new_last = if not valid?, do: acc[:last], else: level 
      %{acc | ascending: new_ascending, last: new_last, valid: acc[:valid] and valid? } 
    end)
    res[:valid]
  end

  # todo: this could be better maybe?
  # total time to run both part 1 and 2 = 0.03 seconds
  def is_report_nearly_safe?(report) when is_list(report) do
    Enum.any?(0..length(report), 
      &List.delete_at(report, &1) |> is_report_safe?())
  end

end
