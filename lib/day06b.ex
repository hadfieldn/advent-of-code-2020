defmodule Day06B do
  @moduledoc """
  Day 6, part 2: Compute total customs questions answered by each group.
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
    iex> Day06B.question_count("abcx\nabcy\nabcz")
    3
    iex> Day06B.question_count("abc")
    3
    iex> Day06B.question_count("a\nb\nc")
    0
    iex> Day06B.question_count("ab\nac")
    1
    iex> Day06B.question_count("a\na\na\na")
    1
    iex> Day06B.question_count("b\n")
    1
  """
  def question_count(group) do
    [first | rest] = String.split(group, "\n", trim: true)

    rest
    |> Enum.reduce(MapSet.new(String.graphemes(first)), fn row, set ->
      MapSet.intersection(set, MapSet.new(String.graphemes(row)))
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
