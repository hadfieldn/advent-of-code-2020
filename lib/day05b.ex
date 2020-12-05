defmodule Day05B do
  @moduledoc """
  Day 5, part 2: Find the missing seat
  """

  @input_filename "priv/day05/input.txt"

  def run do
    found_seats =
      @input_filename
      |> Utils.read_rows()
      |> Enum.map(&seat_id/1)

    skipped_seat =
      found_seats
      |> Enum.sort()
      |> find_skipped_seat()

    IO.puts("The ID of my seat is #{skipped_seat}")
  end

  @doc """
    iex> Day05B.find_skipped_seat([0, 1, 2, 3, 5, 6, 7])
    4
  """
  def find_skipped_seat([last]), do: last

  def find_skipped_seat([left, right | rest]) do
    if left + 2 == right do
      left + 1
    else
      find_skipped_seat([right | rest])
    end
  end

  @doc """
    I realized that the whole F, B, L, R thing is really just the equivalent of a binary number.
    So I revised the implementation to just convert the path to a binary string and then parse it
    into a number.

    iex> Day05B.seat_id("FBFBBFFRLR")
    357

    iex> Day05B.seat_id("FFFBBBFRRR")
    119

    iex> Day05B.seat_id("BBFFBBFRLL")
    820
  """
  def seat_id(seat) do
    {seat_id, _} =
      seat
      |> String.replace(["F", "L"], "0")
      |> String.replace(["B", "R"], "1")
      |> Integer.parse(2)

    seat_id
  end
end
