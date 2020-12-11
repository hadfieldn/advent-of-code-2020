defmodule Day11B do
  @moduledoc """
  Day 11, part 2: Find the number of occupied seats when the seating pattern stabilizes.
  """

  @input_filename "priv/day11/input.txt"

  def run() do
    %{occupancy: occupancy} =
      @input_filename
      |> Utils.read_rows()
      |> get_layout()
      |> iterate_to_convergence()

    IO.puts("Occupancy: #{occupancy}")
  end

  def iterate_to_convergence(layout, occupancy \\ 0) do
    new_layout = update_seating(layout)
    new_occupancy = occupancy(new_layout)

    if new_occupancy != occupancy do
      iterate_to_convergence(new_layout, new_occupancy)
    else
      %{layout: new_layout, occupancy: new_occupancy}
    end
  end

  def render_layout(%{width: width, height: height, grid: grid}) do
    for row <- 0..(height - 1) do
      for col <- 0..(width - 1), into: [], do: grid[{row, col}]
    end
    |> Enum.join("\n")
  end

  def update_seating(%{width: width, height: height, grid: grid} = layout) do
    next_grid =
      for row <- 0..(height - 1), col <- 0..(width - 1), into: grid do
        {{row, col}, next_state({row, col}, grid)}
      end

    %{layout | grid: next_grid}
  end

  @doc """
    iex> Day11B.get_layout(~w(L.L LL# L.#)) |> Day11B.occupancy()
    2
  """
  def occupancy(%{width: width, height: height, grid: grid} = _layout) do
    for row <- 0..(height - 1), col <- 0..(width - 1), grid[{row, col}] == "#" do
      {row, col}
    end
    |> Enum.count()
  end

  @doc """
  iex> grid = Day11B.to_indexed_grid(~w(... LL. LLL))
  ...> Day11B.next_state({1, 1}, grid)
  "#"

  iex> grid = Day11B.to_indexed_grid(~w(.#. ##. ###))
  ...> Day11B.next_state({1, 1}, grid)
  "L"

  iex> grid = Day11B.to_indexed_grid(~w(.#. #.. ###))
  ...> Day11B.next_state({1, 1}, grid)
  "."
  """
  def next_state(pos, grid) do
    case {grid[pos], adjacent_occupancy(pos, grid)} do
      {"L", occupancy} when occupancy == 0 -> "#"
      {"#", occupancy} when occupancy >= 5 -> "L"
      {state, _} -> state
    end
  end

  @doc """
  iex> grid = Day11B.to_indexed_grid(~w(... L## ##L))
  ...> Day11B.adjacent_occupancy({1, 1}, grid)
  3

  iex> grid = Day11B.to_indexed_grid(~w(### ### ###))
  ...> Day11B.adjacent_occupancy({1, 1}, grid)
  8
  """
  def adjacent_occupancy(pos, grid) do
    for row_offset <- -1..1, col_offset <- -1..1, row_offset != 0 or col_offset != 0 do
      first_seat(pos, {row_offset, col_offset}, grid)
    end
    |> Enum.count(&(&1 == "#"))
  end

  def first_seat({row, col}, {row_offset, col_offset} = offset, grid) do
    next_pos = {row + row_offset, col + col_offset}

    case grid[next_pos] do
      "." -> first_seat(next_pos, offset, grid)
      value -> value
    end
  end

  @doc """
  iex> Day11B.get_layout(~w(L.L LLL L..))
  %{width: 3, height: 3, grid: ~w(L.L LLL L..) |> Day11B.to_indexed_grid()}
  """
  def get_layout([row1 | _rest] = data) do
    width = String.length(row1)
    height = length(data)
    %{width: width, height: height, grid: to_indexed_grid(data)}
  end

  @doc """
  Converts the layout to a map keyed by {row, col} tuples.

  iex> Day11B.to_indexed_grid(~w(... .LL ...))
  %{{0, 0} => ".", {0, 1} => ".", {0, 2} => ".", {1, 0} => ".", {1, 1} => "L", {1, 2} => "L", {2,0} => ".", {2, 1} => ".", {2, 2} => "."}
  """
  def to_indexed_grid([row1 | _] = layout) do
    for row <- 0..(length(layout) - 1), col <- 0..(String.length(row1) - 1), into: %{} do
      {{row, col}, layout |> Enum.at(row) |> String.at(col)}
    end
  end
end
