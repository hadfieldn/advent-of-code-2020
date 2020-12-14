defmodule Day13B do
  @moduledoc """
  Day 13B:
  """

  @input_filename "priv/day13/input.txt"

  def run() do
    time =
      @input_filename
      |> Utils.read_rows()
      |> get_input()
      |> find_time()

    IO.puts("Time = #{time}")
  end

  @doc """
    iex> Day13B.find_time([4, 3, 7])
    68
  """

  def find_time(buses) do
    %{last: time} =
      buses
      |> Enum.map(&%{n: &1, start: 0, last: 0})
      |> find_time(1)

    time
  end

  def find_time([bus, last], delay), do: find_time(bus, last, delay)

  def find_time([bus1, bus2 | rest], delay) do
    combined_bus = find_time(bus1, bus2, delay)
    find_time([combined_bus | rest], delay + 1)
  end

  def find_time(
        %{n: b1_n, start: b1_start, last: b1_last} = b1,
        %{n: b2_n, start: b2_start, last: b2_last} = b2,
        delay,
        iteration \\ 0
      ) do
    cond do
      b1_last == b2_last - delay ->
        %{n: b1_n * b2_n, last: b1_last, start: b1_last}

      b1_last > b2_last - delay ->
        next_b2_last = b2_start + div(b1_last - b2_start + delay, b2_n) * b2_n
        next_b2_last = if next_b2_last - delay < b1_last, do: next_b2_last + b2_n, else: next_b2_last
        find_time(b1, %{b2 | last: next_b2_last}, delay, iteration + 1)

      true ->
        next_b1_last = b1_start + div(b2_last - b1_start - delay, b1_n) * b1_n
        next_b1_last = if next_b1_last + delay < b2_last, do: next_b1_last + b1_n, else: next_b1_last
        find_time(%{b1 | last: next_b1_last}, b2, delay, iteration + 1)
    end
  end

  @doc """
  iex> Day13B.valid_time?(3417, [17, 1, 13, 19])
  true

  iex> Day13B.valid_time?(754018, [67, 7, 59, 61])
  true

  iex> Day13B.valid_time?(779210, [67, 1, 7, 59, 61])
  true

  iex> Day13B.valid_time?(1261476, [67, 7, 1, 59, 61])
  true

  iex> Day13B.valid_time?(1202161486, [1789, 37, 47, 1889])
  true
  """
  def valid_time?(_, []), do: true

  def valid_time?(current_time, [bus | rest]) do
    (bus == 1 or time_until_bus(current_time, bus) == 0) and valid_time?(current_time + 1, rest)
  end

  @doc """
  iex> Day13B.time_until_bus(939, 7)
  6

  iex> Day13B.time_until_bus(939, 13)
  10

  iex> Day13B.time_until_bus(939, 59)
  5

  iex> Day13B.time_until_bus(3417, 17)
  0

  iex> Day13B.time_until_bus(3417, 1)
  0
  """
  def time_until_bus(current_time, bus) do
    time = bus - rem(current_time, bus)
    rem(time, bus)
  end

  @doc """
    iex> Day13B.get_input(["939", "7,13,x,x,59,x,31,19"])
    [7, 13, 1, 1, 59, 1, 31, 19]
  """
  def get_input([_line1, line2]) do
    line2
    |> String.split(",")
    |> Enum.map(&if &1 == "x", do: 1, else: String.to_integer(&1))
  end
end
