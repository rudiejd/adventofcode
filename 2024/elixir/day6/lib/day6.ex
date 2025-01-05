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
      loop? -> true
      not is_nil(next_pos) -> guard_wander_check_loops(grid, next_pos, dir, explored)
      true -> false
    end
  end

  def part1(grid) do
    {guard_pos, _val} =
      grid
      |> Enum.filter(fn {{_, _}, val} -> val == ?^ end)
      |> hd

    guard_wander(grid, guard_pos)
  end

  def part2(grid, len) do
    {guard_pos, _val} =
      grid
      |> Enum.find(fn {{_, _}, val} -> val == ?^ end)

    new_obstacles = 
      for y <- 0..len-1 do
        for x <- 0..len-1 do
          IO.inspect({x, y})
          if guard_wander_check_loops(Map.put(grid, {x, y}, ?O), guard_pos) do 
            1
          else
            0
          end
      end
    end

    Enum.reduce(new_obstacles, 0, fn x, acc -> acc + Enum.sum(x) end)
    |> IO.inspect()
  end

  def read_input() do
    contents = File.read!(~c"./test/day6input")

    lines = contents
      |> String.split("\n")

    len = length(lines)
    # I stole this from the other problem!
    map =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        String.to_charlist(line)
        |> Enum.with_index()
        |> Enum.map(fn {char, col} ->
          {{col, row}, char}
        end)
      end)
      |> Map.new()

    {map, len}
  end
end
