defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  @sample_data """
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
  """

  test "gets correct answer for sample data" do
    %{mem: mem} =
      @sample_data
      |> String.split("\n", trim: true)
      |> Day14.execute()

    sum = mem |> Map.values() |> Enum.sum()
    assert sum == 165
  end
end
