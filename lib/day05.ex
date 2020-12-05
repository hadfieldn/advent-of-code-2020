defmodule Day05 do
  @moduledoc """
  Day 5: Find a seat using binary partitioning.
  """

  @input_filename "priv/day05/input.txt"

  def run do
    highest_seat_id =
      @input_filename
      |> Utils.read_rows()
      |> Enum.map(&seat_id/1)
      |> Enum.max()

    IO.puts("Highest seat ID: #{highest_seat_id}")
  end

  @doc """
    iex> Day05.seat_id("FBFBBFFRLR")
    357

    iex> Day05.seat_id("FFFBBBFRRR")
    119

    iex> Day05.seat_id("BBFFBBFRLL")
    820
  """
  def seat_id(seat) do
    %{"row" => row_path, "col" => col_path} = parse_seat(seat)
    row = find_row(row_path)
    col = find_col(col_path)
    row * 8 + col
  end

  @doc """
    iex> Day05.parse_seat("BFFFBBFRRR")
    %{"row" => "BFFFBBF", "col" => "RRR"}
  """
  def parse_seat(seat) do
    Regex.named_captures(~r/^(?<row>[BF]{7})(?<col>[LR]{3}$)/, seat)
  end

  @doc """
    iex> Day05.find_row("FBFBBFF")
    44

    iex> Day05.find_row("BFFFBBF")
    70

    iex> Day05.find_row("FFFBBBF")
    14

    iex> Day05.find_row("BBFFBBF")
    102
  """

  def find_row(chars) when is_binary(chars) do
    find_row(chars |> String.graphemes(), {0, 127})
  end

  def find_row([], {section_start, _}), do: section_start

  def find_row([part | rest], {section_start, section_end}) do
    middle = section_start + div(section_end - section_start, 2)

    next_section =
      case part do
        "F" -> {section_start, middle}
        "B" -> {middle + 1, section_end}
      end

    find_row(rest, next_section)
  end

  @doc """
    iex> Day05.find_col("RLR")
    5

    iex> Day05.find_col("RRR")
    7

    iex> Day05.find_col("RLL")
    4
  """
  def find_col(chars) when is_binary(chars) do
    find_col(chars |> String.graphemes(), {0, 7})
  end

  def find_col([], {section_start, _}), do: section_start

  def find_col([part | rest], {section_start, section_end}) do
    middle = section_start + div(section_end - section_start, 2)

    next_section =
      case part do
        "L" -> {section_start, middle}
        "R" -> {middle + 1, section_end}
      end

    find_col(rest, next_section)
  end
end
