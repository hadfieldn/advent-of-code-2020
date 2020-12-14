defmodule Day14BTest do
  use ExUnit.Case
  doctest Day14B

  @sample_data """
  mask = 000000000000000000000000000000X1001X
  mem[42] = 100
  mask = 00000000000000000000000000000000X0XX
  mem[26] = 1
  """

  test "gets correct answer for sample data" do
    %{mem: mem} =
      @sample_data
      |> String.split("\n", trim: true)
      |> Day14B.execute()

    sum = mem |> Map.values() |> Enum.sum()
    assert sum == 208
  end
end
