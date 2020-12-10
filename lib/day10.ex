defmodule Day10 do
  @moduledoc """
  Day 10: Find differences in adapters.
  """

  @input_filename "priv/day10/input.txt"

  def run() do
    histogram =
      @input_filename
      |> Utils.read_rows()
      |> jolt_histogram()

    diff1 = histogram[1]
    diff3 = histogram[3]
    product = diff1 * diff3
    IO.puts("#{histogram[1]} 1-volt diffs * #{histogram[3]} 3-volt diffs = #{product}")
  end

  @doc """
    iex> numbers = "16 10 15 5 1 11 7 19 6 12 4" |> String.split(" ")
    ...> Day10.jolt_histogram(numbers)
    %{1 => 7, 3 => 5}
  """
  def jolt_histogram(data) do
    numbers = Enum.map(data, &String.to_integer/1)

    ([0 | numbers] ++ [Enum.max(numbers) + 3])
    |> Enum.sort()
    |> get_histogram()
  end

  def get_histogram(numbers, histogram \\ %{})

  def get_histogram([_], histogram) do
    histogram
  end

  def get_histogram([a, b | rest], histogram) do
    diff = b - a
    histogram = Map.put(histogram, diff, (histogram[diff] || 0) + 1)
    get_histogram([b | rest], histogram)
  end
end
