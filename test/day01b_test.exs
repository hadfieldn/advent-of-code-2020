defmodule Day01BTest do
  use ExUnit.Case
  doctest Day01_2

  describe "find_addends/2" do
    result = Day01_2.find_addends([1, 2, 4, 8, 16], 13)
    assert {:ok, {1, 4, 8}} = result
  end
end
