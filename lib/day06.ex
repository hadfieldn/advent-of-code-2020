defmodule Day06 do
  @moduledoc """
  Day 6: Compute total customs questions answered by each group.
  """

  @input_filename "priv/day06/input.txt"

  def run do
    count =
      @input_filename
      |> load_file()
      |> question_total()

    IO.puts("The groups answered #{count} questions.")
  end

  def question_total(data) do
    data
    |> get_groups()
    |> Enum.map(&question_count/1)
    |> Enum.sum()
  end

  @doc ~S"""
    iex> Day06.question_count("abcx\nabcy\nabcz")
    6
  """
  def question_count(group) do
    group
    |> String.split("\n")
    |> Enum.reduce(MapSet.new(), fn row, set ->
      MapSet.union(set, MapSet.new(String.graphemes(row)))
    end)
    |> MapSet.size()
  end

  def load_file(filename) do
    filename
    |> File.read!()
    |> String.trim()
  end

  def get_groups(string) do
    string |> String.split("\n\n")
  end
end
