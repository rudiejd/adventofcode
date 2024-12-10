defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """


  defp go({x, y}, {x1, y1}) do
    {x + x1, y + y1}
  end

  @dir_idx %{{0, -1} => 0, {1, 0} => 1, {0, 1} => 2, {-1, 0} => 3}
  @dirs %{0 => {0, -1}, 1 => {1, 0}, 2 => {0, 1}, 3 => {-1, 0}}
  defp guard_wander(grid, guard_pos, dir \\ {0, -1}, cnt \\ 0) do
    next_pos = go(guard_pos, dir)
    dbg()
    case grid[next_pos] do 
      ?# -> guard_wander(grid, guard_pos, @dirs[rem(@dir_idx[dir] + 1, length(Map.keys(@dirs)))], cnt)
      ?.-> guard_wander(grid, go(guard_pos, dir), dir, cnt + 1)
      ?^-> guard_wander(grid, go(guard_pos, dir), dir, cnt + 1)
      _ -> cnt
    end
  end

  def part1(grid) do
     {guard_pos, _val}= grid
      |> Enum.filter(fn {{_, _}, val} -> val == ?^ end)
      |> hd

      guard_wander(grid, guard_pos)
  end


  def read_input() do
    contents = File.read!('./test/day6input')

    # I stole this from the other problem!
    map = contents
    |> String.split("\n")
    |> Enum.with_index
    |> Enum.flat_map(fn {line, row} ->
      String.to_charlist(line)
      |> Enum.with_index
      |> Enum.map(fn {char, col} ->
        {{col, row}, char}
      end)
    end)
    |> Map.new
  end
end
