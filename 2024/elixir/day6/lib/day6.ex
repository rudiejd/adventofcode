defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  defp go({x, y}, {x1, y1}) do
    {x + x1, y + y1}
  end

  @dir_idx %{{0, -1} => 0, {1, 0} => 1, {0, 1} => 2, {-1, 0} => 3}
  @dirs %{0 => {0, -1}, 1 => {1, 0}, 2 => {0, 1}, 3 => {-1, 0}}
  defp guard_wander(grid, guard_pos, dir \\ {0, -1}, explored \\ %MapSet{}) do
    facing = go(guard_pos, dir)
    explored = MapSet.put(explored, guard_pos)

    {next_pos, dir} =
      case grid[facing] do
        ?# -> {guard_pos, @dirs[rem(@dir_idx[dir] + 1, length(Map.keys(@dirs)))]}
        ?. -> {facing, dir}
        ?^ -> {facing, dir}
        nil -> {nil, nil}
      end

    if not is_nil(next_pos) do
      guard_wander(grid, next_pos, dir, explored)
    else
      MapSet.size(explored)
    end
  end

  defp guard_wander_check_loops(grid, guard_pos, dir \\ {0, -1}, explored \\ %{}) do
    facing = go(guard_pos, dir)

    # explored = postion => (all directions we've gone from that position)
    # if we go the same direction twice, loop detected
    visited_dirs = Map.get(explored, guard_pos, MapSet.new()) 
    loop? = MapSet.member?(visited_dirs, dir)

    dirs_at_pos = 
      visited_dirs
      |> MapSet.put(dir)

    explored =
      Map.put(explored, guard_pos, dirs_at_pos)


    {next_pos, dir} =
      case grid[facing] do
        ?# -> {guard_pos, @dirs[rem(@dir_idx[dir] + 1, length(Map.keys(@dirs)))]}
        ?O -> {guard_pos, @dirs[rem(@dir_idx[dir] + 1, length(Map.keys(@dirs)))]}
        ?. -> {facing, dir}
        ?^ -> {facing, dir}
        nil -> {nil, nil}
      end

    cond do
      loop? -> 1
      not is_nil(next_pos) -> guard_wander_check_loops(grid, next_pos, dir, explored)
      true -> 0
    end
  end

  defp get_guard_pos(grid) do
    {guard_pos, _val} =
      grid
      |> Enum.find(fn {{_, _}, val} -> val == ?^ end)
    guard_pos
  end

  def part1(grid) do
    guard_wander(grid, get_guard_pos(grid))
  end

  def part2(grid, len) do
    guard_pos = get_guard_pos(grid)

    coords = for x <- 0..len-1, y <- 0..len-1, do: {x, y}
    Enum.reduce(coords, 0, &(&2 + guard_wander_check_loops(grid |> Map.put(&1, ?O), guard_pos)))
  end

  def read_input() do
    contents = File.read!(~c"./test/day6input")

    lines = contents
      |> String.split("\n")

    len = length(lines)
    # I stole this from the other problem!
    map =
      lines
      |> Stream.with_index()
      |> Stream.flat_map(fn {line, row} ->
        String.to_charlist(line)
        |> Stream.with_index()
        |> Enum.map(fn {char, col} ->
          {{col, row}, char}
        end)
      end)
      |> Map.new()

    {map, len}
  end
end
