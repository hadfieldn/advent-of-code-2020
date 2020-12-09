defmodule Day09 do
  @moduledoc """
  Day 9: Find the encoding error.
  """

  @input_filename "priv/day09/input.txt"

  def run() do
    {:ok, invalid_number} =
      @input_filename
      |> Utils.read_rows()
      |> Enum.map(&String.to_integer/1)
      |> find_first_error(25)

    IO.puts("First encoding error is #{invalid_number}.")
  end

  def find_first_error(numbers, preamble_length, offset \\ 0)

  def find_first_error(numbers, preamble_length, offset) when offset > length(numbers) - preamble_length do
    {:error, :not_found}
  end

  def find_first_error(numbers, preamble_length, offset) do
    window = Enum.slice(numbers, offset..(offset + preamble_length))
    {preamble, [next]} = Enum.split(window, preamble_length)

    if number_valid?(preamble, next) do
      find_first_error(numbers, preamble_length, offset + 1)
    else
      {:ok, next}
    end
  end

  def number_valid?(preamble, number) do
    preamble_range = 0..(length(preamble) - 1)

    Enum.any?(preamble_range, fn index1 ->
      Enum.any?(preamble_range, fn index2 ->
        number1 = Enum.at(preamble, index1)
        number2 = Enum.at(preamble, index2)
        index1 != index2 and number1 != number2 and number1 + number2 == number
      end)
    end)
  end
end
