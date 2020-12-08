defmodule Day08BTest do
  use ExUnit.Case
  doctest Day08B

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

  describe "fix_code/2" do
    test "matches answer provided for sample data", %{code: code} do
      assert {:ok, %{acc: 8}} = Day08B.fix_code(code)
    end
  end
end
