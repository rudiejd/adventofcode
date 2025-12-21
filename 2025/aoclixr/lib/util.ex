defmodule Util do
  def read_line_array_from_file(file_name) do
    file_name
    |> File.read!()
    |> String.split()
  end
end
