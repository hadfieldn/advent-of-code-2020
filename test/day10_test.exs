defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

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
    histogram =
      @sample_data
      |> String.split("\n", trim: true)
      |> Day10.jolt_histogram()

    assert %{1 => 22, 3 => 10} = histogram
  end
end
