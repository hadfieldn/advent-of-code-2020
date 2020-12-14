defmodule Day13 do
  @moduledoc """
  Day 13:
  """

  @input_filename "priv/day13/input.txt"

  def run() do
    {bus, wait} =
      @input_filename
      |> Utils.read_rows()
      |> get_input()
      |> next_bus()

    IO.puts("Next bus #{bus} in #{wait} minutes = #{bus * wait}")
  end

  @doc """
  iex> ["939", "7,13,x,x,59,x,31,19"] |> Day13.get_input() |> Day13.next_bus()
  {59, 5}
  """
  def next_bus(%{time: time, buses: buses}) do
    buses
    |> Enum.map(&{&1, time_until_bus(time, &1)})
    |> Enum.min_by(fn {_bus, wait} -> wait end)
  end

  @doc """
  iex> Day13.time_until_bus(939, 7)
  6

  iex> Day13.time_until_bus(939, 13)
  10

  iex> Day13.time_until_bus(939, 59)
  5
  """
  def time_until_bus(current_time, bus) do
    bus - rem(current_time, bus)
  end

  @doc """
    iex> Day13.get_input(["939", "7,13,x,x,59,x,31,19"])
    %{time: 939, buses: [7, 13, 59, 31, 19]}
  """
  def get_input([line1, line2]) do
    time = String.to_integer(line1)

    buses =
      line2
      |> String.split(",")
      |> Enum.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer/1)

    %{time: time, buses: buses}
  end
end
