defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  @sample_data """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  setup do
    code = Day08.parse_code(@sample_data)
    %{code: code}
  end

  describe "execute_code/2" do
    test "matches answer provided for sample data", %{code: code} do
      state = Day08.execute_code(code)
      assert %{acc: 5} = state
    end
  end
end
