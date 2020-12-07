defmodule Day06BTest do
  use ExUnit.Case
  doctest Day06B

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

      assert Day06B.question_total(sample) == 6
    end
  end
end
