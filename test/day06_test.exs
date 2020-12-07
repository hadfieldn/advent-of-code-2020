defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  describe "question_total/1" do
    test "gets correct total for sample data" do
      sample = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """

      assert Day06.question_total(sample) == 11
    end
  end
end
