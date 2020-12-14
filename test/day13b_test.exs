defmodule Day13BTest do
  use ExUnit.Case
  doctest Day13B

  test "correct answer for sample data" do
    assert Day13B.valid_time?(3417, [17, 1, 13, 19])
  end

  test "find_time/3" do
    assert Day13B.find_time([7, 13]) == 77
    assert Day13B.find_time([4, 3]) == 8
    assert Day13B.find_time([4, 3, 7]) == 68
    assert Day13B.valid_time?(68, [4, 3, 7])
  end
end
