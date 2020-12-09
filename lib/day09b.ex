defmodule Day09B do
  @moduledoc """
  Day 9, part 2: Find the encoding weakness.
  """

  @input_filename "priv/day09/input.txt"
  @part1_answer 1_492_208_709

  def run() do
    {:ok, numbers} =
      @input_filename
      |> Utils.read_rows()
      |> Enum.map(&String.to_integer/1)
      |> find_range_with_sum(@part1_answer)

    min = Enum.min(numbers)
    max = Enum.max(numbers)
    sum = Enum.sum(numbers)
    IO.puts("The encoding weakness (sum = #{sum}) is #{min} + #{max} = #{min + max}.")
  end

  def find_range_with_sum(numbers, target_sum, {offset, count} \\ {0, 1}) do
    slice = Enum.slice(numbers, offset..(offset + count))
    sum = Enum.sum(slice)

    cond do
      sum == target_sum -> {:ok, slice}
      sum > target_sum -> find_range_with_sum(numbers, target_sum, {offset + 1, 1})
      offset + count + 1 >= length(numbers) -> find_range_with_sum(numbers, target_sum, {offset + 1, 1})
      true -> find_range_with_sum(numbers, target_sum, {offset, count + 1})
    end
  end
end
