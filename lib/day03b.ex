defmodule Day03B do
  @moduledoc """
  Day 3, part 2: Count trees encountered when traversing a set of slopes.
  """

  @input_filename "priv/day03/input.txt"

  def run do
    rows = Utils.read_rows(@input_filename)

    args_list = [
      [right: 1, down: 1],
      [right: 3, down: 1],
      [right: 5, down: 1],
      [right: 7, down: 1],
      [right: 1, down: 2]
    ]

    product = traverse_multiple(rows, args_list)
    IO.puts("Product of encountered trees = #{product}")
  end

  def traverse_multiple(rows, args_list) do
    args_list
    |> Enum.map(fn args ->
      %{count: count} = traverse(rows, args)
      count
    end)
    |> Enum.reduce(fn count, product -> product * count end)
  end

  @doc """
  iex> trees = ~w(..##....... #...#...#.. .#....#..#. ..#.#...#.# .#...##..#. ..#.##..... .#.#.#....# .#........# #.##...#... #...##....# .#..#...#.#)
  ...> %{count: count1} = Day03B.traverse(trees, right: 1, down: 1)
  ...> %{count: count2} = Day03B.traverse(trees, right: 3, down: 1)
  ...> %{count: count3} = Day03B.traverse(trees, right: 5, down: 1)
  ...> %{count: count4} = Day03B.traverse(trees, right: 7, down: 1)
  ...> %{count: count5} = Day03B.traverse(trees, right: 1, down: 2)
  ...> [count1, count2, count3, count4, count5]
  [2, 7, 3, 4, 2]

  """
  def traverse(rows, options \\ []) do
    right = options[:right] || 1
    down = options[:down] || 1

    Enum.reduce(rows, %{row_idx: 0, pos: 0, count: 0}, fn row, %{row_idx: row_idx, pos: pos, count: count} ->
      skip_row? = rem(row_idx, down) != 0

      case skip_row? do
        true ->
          %{row_idx: row_idx + 1, pos: pos, count: count}

        false ->
          count = if tree?(row, pos), do: count + 1, else: count
          %{row_idx: row_idx + 1, pos: pos + right, count: count}
      end
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
