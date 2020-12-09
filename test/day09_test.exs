defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

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

  describe "find_first_error/3" do
    test "matches answer provided for sample data" do
      result =
        @sample_data
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Day09.find_first_error(5)

      assert result == {:ok, 127}
    end
  end
end
