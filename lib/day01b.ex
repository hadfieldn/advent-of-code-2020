defmodule Day01B do
  @moduledoc """
  Day 1, part 2: Given a list of numbers, find three that add to 2020 and return their product.
  """

  def run do
    data = load_data("priv/day01/input.txt")

    case find_addends(data, 2020) do
      {:ok, {addend_1, addend_2, addend_3}} ->
        product = addend_1 * addend_2 * addend_3
        IO.puts("#{addend_1} * #{addend_2} * #{addend_3} = #{product}")
        :ok

      _ ->
        IO.puts("Could not find three numbers that sum to 2020.")
        :error
    end
  end

  @doc "Find three addends that sum to a given amount"
  def find_addends(data, expected_sum) do
    find_addends([], data, expected_sum)
  end

  def find_addends(_, [], _) do
    {:error, "No match in list"}
  end

  def find_addends(visited, remaining, expected_sum) do
    [addend1 | rest] = remaining

    case find_addends(addend1, visited, rest, expected_sum) do
      {:ok, _} = result -> result
      {:error, _} -> find_addends([addend1 | visited], rest, expected_sum)
    end
  end

  @doc "Given one addend, find another that sums to a given amount"
  def find_addends(_, _, [], _) do
    {:error, "No match in list"}
  end

  def find_addends(addend1, visited, remaining, expected_sum) do
    [addend2 | rest] = remaining

    case find_addends(addend1, addend2, visited, rest, expected_sum) do
      {:ok, _} = result -> result
      {:error, _} -> find_addends(addend1, [addend2 | visited], rest, expected_sum)
    end
  end

  @doc "Given two addends, find another that sums to a given amount"
  def find_addends(_, _, _, [], _) do
    {:error, "No match in list"}
  end

  def find_addends(addend1, addend2, visited, remaining, expected_sum) do
    [addend3 | rest] = remaining

    if addend1 + addend2 + addend3 == expected_sum do
      {:ok, {addend1, addend2, addend3}}
    else
      find_addends(addend1, addend2, [addend3 | visited], rest, expected_sum)
    end
  end

  def load_data(filename) do
    filename
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
