defmodule Day10BTest do
  use ExUnit.Case
  doctest Day10B

  @sample_data """
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  """

  test "gets answer provided for sample data" do
    count =
      @sample_data
      |> String.split("\n", trim: true)
      |> Day10B.get_tree()
      |> Day10B.leaf_count()

    assert count == 19208
  end
end
