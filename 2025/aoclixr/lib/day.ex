defmodule Day do
  defmacro __using__(opts) do
    quote do
      def run_puzzle() do
        line_list =
          __MODULE__
          |> inspect()
          |> String.downcase()
          |> then(fn s -> "input/#{s}_input.txt" end)
          |> Util.read_line_array_from_file()

        line_list
        |> part1
        |> IO.inspect()

        line_list
        |> part2
        |> IO.inspect()
      end

      def run_sample() do
        line_list =
          __MODULE__
          |> inspect()
          |> String.downcase()
          |> then(fn s -> "input/#{s}_sample.txt" end)
          |> Util.read_line_array_from_file()

        line_list
        |> part1
        |> IO.inspect()

        line_list
        |> part2
        |> IO.inspect()
      end
    end
  end
end
