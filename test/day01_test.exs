defmodule Day1Test do
  use ExUnit.Case
  doctest Day01

  describe "load_data/1" do
    test "gets data" do
      data = Day01.load_data("priv/day01/input.txt")
      assert length(data) > 0
      assert is_integer(hd(data))
    end
  end

  describe "find_addends/2" do
    result = Day01.find_addends([1, 2, 4, 8, 16], 12)
    assert {:ok, {4, 8}} = result
  end
end
