defmodule Utils do
  def read_rows(filename) do
    filename
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
