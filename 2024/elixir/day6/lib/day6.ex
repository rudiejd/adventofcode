defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  defp go({x, y}, {x1, y1}) do
    {x + x1, y + y1}
  end

  def print_grid(explored, pos, grid) do
    for y <- 0..length(Map.keys(grid)) do
      for x <- 0..length(Map.keys(grid)) do
        cond do
          {x, y} in explored ->
            IO.write("X")

          {x, y} == pos ->
            IO.write("^")

          Map.has_key?(grid, {x, y}) ->
            case grid[{x, y}] do
              ?^ -> IO.write(".")
              _ -> IO.write(List.to_string([grid[{x, y}]]))
            end

          true ->
            "?"
        end
      end

      IO.write("\n")
    end

    IO.write("\n\n")
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

  def check_loop(grid, guard_pos, explored \\ %{})
    facing = go(guard_pos, dir)
    dirs_at_pos = Map.get(explored, guard_pos, MapSet.new()) |> MapSet.put(dir)
  end


  defp guard_wander_check_loops(grid, guard_pos, dir \\ {0, -1}, explored \\ %{}) do
    facing = go(guard_pos, dir)

    dirs_at_pos = Map.get(explored, guard_pos, MapSet.new()) |> MapSet.put(dir)

    explored =
      Map.put(explored, guard_pos, dirs_at_pos)

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

  def part1(grid) do
    {guard_pos, _val} =
      grid
      |> Enum.filter(fn {{_, _}, val} -> val == ?^ end)
      |> hd

    guard_wander(grid, guard_pos)
  end

  def part2(grid) do
    {guard_pos, _val} =
      grid
      |> Enum.filter(fn {{_, _}, val} -> val == ?^ end)
      |> hd

    guard_wander_check_loops(grid, guard_pos)
  end

  def read_input() do
    contents = File.read!(~c"./test/day6input")

    # I stole this from the other problem!
    map =
      contents
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        String.to_charlist(line)
        |> Enum.with_index()
        |> Enum.map(fn {char, col} ->
          {{col, row}, char}
        end)
      end)
      |> Map.new()
  end
end
