defmodule Day03 do
  @moduledoc """
  Day 3: Count trees encountered when traversing a slope.
  """

  @input_filename "priv/day03/input.txt"

  def run do
    rows = Utils.read_rows(@input_filename)
    %{count: count} = traverse(rows, slope: 3)
    IO.puts("Encountered #{count} trees.")
  end

  @doc """

  iex> trees = ~w(..##....... #...#...#.. .#....#..#. ..#.#...#.# .#...##..#. ..#.##..... .#.#.#....# .#........# #.##...#... #...##....# .#..#...#.#)
  iex> Day03.traverse(trees, slope: 3)
  %{pos: 33, count: 7}
  """
  def traverse(rows, options \\ []) do
    slope = options[:slope] || 3

    Enum.reduce(rows, %{pos: 0, count: 0}, fn row, %{pos: pos, count: count} ->
      count = if tree?(row, pos), do: count + 1, else: count
      %{pos: pos + slope, count: count}
    end)
  end

  @doc """
    Is the square at the given column a tree?

    ## Examples

      iex> Day03.tree?("...#.", 3)
      true

      iex> Day03.tree?("...#.", 8)
      true

      iex> Day03.tree?("...#.", 2)
      false
  """
  def tree?(row, column) do
    squares = String.graphemes(row)
    pos = rem(column, length(squares))
    Enum.at(squares, pos) == "#"
  end
end
