defmodule Day09BTest do
  use ExUnit.Case
  doctest Day09B

  @sample_data """
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  """

  describe "find_range_with_sum/3" do
    test "matches answer provided for sample data" do
      {:ok, numbers} =
        @sample_data
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Day09B.find_range_with_sum(127)

      assert Enum.min(numbers) == 15
      assert Enum.max(numbers) == 47
    end
  end
end
